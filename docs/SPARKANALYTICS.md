Spark Analytics - Build your own Experiment
-------------------------------------------

#### Data-Source
All the collected data of your _metered_ simulators/tasks is available in **InfluxDB** via the [InfluxDB-API](http://influxdb.com/docs/v0.7/api/reading_and_writing_data.html).

We put together a [simple library](https://github.com/att-innovate/charmander-spark/blob/master/src/main/scala/org/att/charmander/CharmanderUtils.scala)
that gives you easy access to the data from Spark/Scala. Some available functions are:

    def getMeteredTaskNamesFromRedis(): List[String]
    def getRDDForTask(sc: SparkContext, taskName: String, attributeName: String, numberOfPoints: Int): RDD[List[BigDecimal]]
    def getRDDForNode(sc: SparkContext, nodeName: String, attributeName: String, numberOfPoints: Int): RDD[List[BigDecimal]]

Example: Retrieve the currently active metered tasks:

    val tasks = CharmanderUtils.getMeteredTaskNamesFromRedis

Example: Get 200 memory_usage data-points for lookbusy200 simulator:

    val memoryUsage= CharmanderUtils.getRDDForTask(sc, "lookbusy200", "memory_usage", 200)

Example: Get 200 memory_usage data-points for the _slave2_ node:

    val memoryUsage= CharmanderUtils.getRDDForNode(sc, "slave2", "memory_usage", 200)


#### Destination for Task-Intelligence
The output of your analysis can be fed back in to the scheduler via Redis. The keys in Redis have to be in a certain form
to be understood by the Charmander-Scheduler.

To simplify the setting of those findings our [library](https://github.com/att-innovate/charmander-spark/blob/master/src/main/scala/org/att/charmander/CharmanderUtils.scala)
offers following function:

    def setTaskIntelligence(taskName: String, attributeName: String, value: String)
    def getTaskIntelligence(taskName: String, attributeName: String): String

Example: Overwrite the memory allocation for lookbusy200 to 400

    // Redis key to overwrite memory allocation: charmander:task-intelligence:lookbusy200:mem
    CharmanderUtils.setTaskIntelligence("lookbusy200", "mem", "400")

Example: Retrieve previously set memory allocation for lookbusy200

    val mem = CharmanderUtils.getTaskIntelligence("lookbusy200", "mem")

Example: Force lookbusy200 to always be deployed to slave2

    // Redis key to overwrite memory allocation: charmander:task-intelligence:lookbusy200:nodename
    CharmanderUtils.setTaskIntelligence("lookbusy200", "nodename", "slave2")


#### Build and use our Spark utilties library locally
Use the library that comes with the Charmander project. Copy that library in to your `/tmp` directory for example
and use it with Spark-shell:

    git clone https://github.com/att-innovate/charmander
    cp charmander/analytics/spark/sparkkernel/files/charmander-utils_2.10-1.0.jar /tmp

    //cd to your local spark deployment
    cd spark-1.2.0
    ./bin/spark-shell --jars /tmp/charmander-utils_2.10-1.0.jar

    //verify that you can import the library
    import org.att.charmander.CharmanderUtils

And of course you can build the library yourself:

    git clone https://github.com/att-innovate/charmander-spark
    cd charmander-spark

    // verify that you have Java and sbt (>= 0.13.6) installed
    java -version
    sbt --version

    // build it
    sbt package

    // copy the library to the tmp directoy
    cp target/scala-2.10/charmander-utils_2.10-1.0.jar /tmp

    //cd to your local spark deployment
    cd spark-1.2.0
    ./bin/spark-shell --jars /tmp/charmander-utils_2.10-1.0.jar

    //verify that you can import the library
    import org.att.charmander.CharmanderUtils

#### Spark-Shell: Simple example

Start Analytics-Stack and the lookbusy60mb simulator

    ./bin/reset_cluster
    ./bin/start_cadvisor
    ./bin/start_analytics
    ./bin/start_lookbusy80mb

Let it run for a bit. You can verify that everything is up and running using [Redis](http://172.31.2.11:31610). You
should see 10 running tasks.

Start your Spark-shell

    //cd to your local spark deployment
    //adjust the path to charmander-utils.jar accordingly
    cd spark-1.2.0
    ./bin/spark-shell --jars /tmp/charmander-utils_2.10-1.0.jar

Retrieve 200 data-points as RDD and print them out using the Spark-shell

    import org.att.charmander.CharmanderUtils
    val datapoints= CharmanderUtils.getRDDForTask(sc, "lookbusy80", "memory_usage", 200)
    datapoints.foreach(println)


#### Spark-Kernel - experimental!

IBM recently open-sourced their [Spark-Kernel](https://github.com/ibm-et/spark-kernel) project.
It allows you to run the Spark-Shell as a _Notebook_ in jupyter (previously known as iPython).

Charmander includes scripts to build and run a Spark-Kernel docker image.

Lets build the Docker image. Be warned, the first time you run it that build takes a loooooooong type to complete.

    ./bin/reset_cluster
    ./bin/build_sparkkernel

Run Spark-Kernel with Charmander

    ./bin/start_cadvisor
    ./bin/start_analytics
    ./bin/start_lookbusy80mb
    ./bin/start_sparkkernel

Open Spark-Kernel/jupyter at [172.31.2.11:31800/](http://172.31.2.11:31800/)

Open the _CharmanderUtils.ipynb_ notebook and wait until the Spark Kernel is ready, indicated in the header by the dot
changing in to a circle, that takes roughly 10s, and you should see something like this:

![image](https://github.com/att-innovate/charmander/blob/master/docs/assets/SparkKernel.png?raw=true)

You can now execute all the _cells_ using menu _Cell/Run All_ .. Have fun!



#### Next learn about the Scheduler API

[Scheduler API](https://github.com/att-innovate/charmander/blob/master/docs/SCHEDULERAPI.md)





