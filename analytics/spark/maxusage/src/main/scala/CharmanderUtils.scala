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

import java.io.{IOException, InputStreamReader, BufferedReader, PrintWriter}
import java.net.Socket

import scala.collection.mutable


class ScalaCustomException(msg: String) extends RuntimeException(msg)

trait CharmanderUtils {
  def setToRedis(key: String, value: String): Unit
  def getFromRedis(key: String): String
  def getMeteredTaskNamesFromRedis(): List[String]
  def sendQueryStringToOpenInfluxDB(query: String): String
}

object CharmanderUtils {

  val REDIS_HOST = "172.31.2.11"
  val REDIS_PORT = 31600
  val INFLUXDB_HOST = "172.31.2.11"
  val INFLUXDB_PORT = 31410


  def setToRedis(key: String, value: String): Unit = {
    val socket = new Socket(REDIS_HOST, REDIS_PORT)
    var out = new PrintWriter(socket.getOutputStream(), true)
    var in = new BufferedReader(new InputStreamReader(socket.getInputStream()))
    out.println("*3\r\n$3\r\nSET\r\n$" + key.length.toString + "\r\n" + key + "\r\n$" + value.length.toString + "\r\n" + value + "\r\n")
    if (in.readLine() != "+OK")
      throw new ScalaCustomException("Could not set value in Redis.")
  }

  def getFromRedis(key: String): String = {
    val socket = new Socket(REDIS_HOST, REDIS_PORT)
    var out = new PrintWriter(socket.getOutputStream(), true)
    var in = new BufferedReader(new InputStreamReader(socket.getInputStream()))
    out.println("*2\r\n$3\r\nGET\r\n$" + key.length.toString + "\r\n" + key + "\r\n")
    if (in.readLine().charAt(1) == '-') //Redis responses with $-1 if no value found
      return ""
    else
      return in.readLine()
  }

  def getMeteredTaskNamesFromRedis(): List[String] = try {
    var tasks = mutable.Set[String]()
    val socket = new Socket(REDIS_HOST, REDIS_PORT)
    var out = new PrintWriter(socket.getOutputStream(), true)
    var in = new BufferedReader(new InputStreamReader(socket.getInputStream()))
    out.println("*2\r\n$4\r\nKEYS\r\n$26\r\ncharmander:tasks-metered:*\r\n")
    val numberOfResultsRaw: String = in.readLine()
    if (numberOfResultsRaw == "*0") {
      return tasks.toList
    }

    val numberOfResults = (numberOfResultsRaw.substring(1)).toInt
    for (i <- 1 to numberOfResults) {
      in.readLine() // we don't care abput the length
      val taskNameRaw = in.readLine()
      val taskName = taskNameRaw slice((taskNameRaw lastIndexOf (':')) + 1, taskNameRaw lastIndexOf ('-'))
      tasks += taskName
    }

    return tasks.toList
  } catch {
    case e: java.net.ConnectException => return List[String]()
  }

  def sendQueryStringToOpenInfluxDB(query: String): String = try {
    val in = scala.io.Source.fromURL("http://"
      + INFLUXDB_HOST
      + ":"
      + INFLUXDB_PORT
      + "/db/charmander/series?u=root&p=root&q="
      + java.net.URLEncoder.encode(query),
      "utf-8")
    var data = ""
    for (line <- in.getLines)
      data = line
    return data
  } catch {
    case e: IOException => return ""
    case e: java.net.ConnectException => return ""
  }
}
