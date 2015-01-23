Run simple Experiment - maxusage
--------------------------------

Our MaxUsage-Experiment will analyze the actual memory usage of a running simulator and use that result to overwrite
the memory-allocation for subsequent run-requests for the same simulator.


#### Build and deploy the "max-usage" analyzer
The max-usage Analyzer is implemented in Scala using Spark-Streamning and Spark-SQL.

The code can be found in Github in [MaxUsage.scala](https://github.com/att-innovate/charmander/blob/master/analytics/spark/maxusage/src/main/scala/MaxUsage.scala).

One can argue that using Spark to resolve the max memory usage of a simulator is an over-kill .. but hey, we had
to try out streaming and Spark-SQL.

Lets build it.

    ./bin/build_maxusage

This command builds max-usage and creates a corresponding Docker image. This command will take some time to finish the first time you run it.


#### Start cAdvisor and Analytics-Stack

    ./bin/start_cadvisor
    ./bin/start_analytics

#### Start two instances of the lookbusy simulator

    ./bin/start_lookbusy200mb
    ./bin/start_lookbusy200mb

#### Start max-usage

    ./bin/start_maxusage

#### Verify the experiment setup in Redis

Redis-UI can be found at: [http://172.31.2.11:31610](http://172.31.2.11:31610)

The information in Redis gets updated by the scheduler every 15s. Give it some time to get synchronized.
You should then see something like:

![image](https://github.com/att-innovate/charmander/blob/master/docs/assets/Redis.png?raw=true)

Redis shows all the 3 slaves/nodes, all the currently running tasks, all the "metered" tasks, and the "intelligence" collected
by maxusage in the task-intelligence section. The _mem_ value represents the highest memory-use of a metered task, for lookbusy it should
be something roughly _210MB_ (_209928192_).

#### Verify idle memory

Open the Mesos console at [http://172.31.1.11:5050](http://172.31.1.11:5050) and look for the _Resources_ _idle_ number at the bottom left.
It should be something like _582MB_.

#### Redeploy simulators

    ./bin/reshuffle

This command will kill and restart our running simulators. The Mesos console can be used to see the progress of the _reshuffling_.

#### Verify idle memory

The memory allocation for the lookbusy-tasks got lowered now by the scheduler from originally _300MB_ to now _230MB_ (maxusage + 10% safety).
That decrease in allocated memory should increase the amount of idle memory for the cluster.

Open Mesos console at [http://172.31.1.11:5050](http://172.31.1.11:5050) and look for the _Resources_ _idle_ number at the bottom left.
It should now be roughly _722MB_.

#### That's it, let's clean up

    ./bin/reset_cluster

This commands resets the cluster by killing all the running tasks. And we are again ready for a new experiment.



#### Next Spark Analytics and build your own Experiment

[Spark Analytics](https://github.com/att-innovate/charmander/blob/master/docs/SPARKANALYTICS.md)


