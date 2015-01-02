// The MIT License (MIT)
//
// Copyright (c) 2014 AT&T
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


// ../spark/bin/spark-submit --class "MaxUsage" --master local[*]  target/scala-2.10/max-usage_2.10-1.0.jar

import scala.collection.mutable
import org.apache.spark.{SparkConf, SparkContext}
import org.apache.spark.rdd.RDD
import org.apache.spark.streaming._
import org.json4s.jackson.JsonMethods

case class MemoryUsage(timestamp: BigDecimal, memory: BigDecimal)

object MaxUsage {


  def main(args: Array[String]) {

    // Create the contexts
    val conf = new SparkConf().setAppName("Charmander-Spark")
    val sc = new SparkContext(conf)
    val ssc = new StreamingContext(sc, Seconds(2))
    val sqlContext = new org.apache.spark.sql.SQLContext(sc)
    import sqlContext._

    // Create the queue through which RDDs can be pushed to
    // a QueueInputDStream
    val rddQueue = new mutable.SynchronizedQueue[RDD[List[BigDecimal]]]()

    // Create the QueueInputDStream and use it do some processing
    val inputStream = ssc.queueStream(rddQueue)
    inputStream.foreachRDD(rdd => {
      if (rdd.count != 0) {
        val memoryusage = rdd.map(p => MemoryUsage(BigDecimal(p(0).asInstanceOf[BigInt]), BigDecimal(p(2).asInstanceOf[BigInt])))
        memoryusage.registerTempTable("memoryusage")
        val newestMaxRaw = sqlContext.sql("select max(memory) from memoryusage").first()
        println(newestMaxRaw)
        val newestMax = BigDecimal(newestMaxRaw(0).toString)

        val redisKey = "charmander:task-intelligence:" + rdd.name + ":mem"
        val maxMemUse = CharmanderUtils.getFromRedis("SPARK_MAX")

        if (maxMemUse != "") {
          //task exists in redis
          if (BigDecimal(maxMemUse) < newestMax) {
            CharmanderUtils.setToRedis(redisKey, newestMax.toString)
          }
        } else {
          //task does not exist in redis
          CharmanderUtils.setToRedis(redisKey, newestMax.toString)
        }
      }
    })
    ssc.start()


    while (true) {
      val taskNamesMetered = CharmanderUtils.getMeteredTaskNamesFromRedis()

      for {taskNameMetered <- taskNamesMetered} {
        val rawData = CharmanderUtils.sendQueryStringToOpenInfluxDB("select memory_usage from stats where container_name =~ /" + taskNameMetered + "*/ limit 100")
        if (rawData.length > 0) {
          val json = JsonMethods.parse(rawData)
          val points = json \\ "points"
          val mypoints = points.values

          if (points.values.isInstanceOf[List[Any]]) {
            val rdd = sc.parallelize(mypoints.asInstanceOf[List[List[BigDecimal]]])
            rdd.setName(taskNameMetered)
            rddQueue += rdd
            println(taskNameMetered)
          }
        }
      }

      Thread.sleep(15000)
    }

  }
}
