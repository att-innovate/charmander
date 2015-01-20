Run simple Experiment - maxusage
--------------------------------

#### Deploy Charmander-Scheduler

Install and start up Charmander-Scheduler, our "Mesos-Framework"

```
./bin/deploy_scheduler
```

Verify that it shows up under Frameworks in the Mesos Management Console.


#### Start cAdvisor

Deploys cAdvisor to all the slave nodes

    ./bin/start_cadvisor

Mesos console can be used to check on cAdvisor status.

cAdvisor WebUI will become available on all the slave nodes at:

Slave1: [http://172.31.2.11:31500](http://172.31.2.11:31500)

Slave2: [http://172.31.2.12:31500](http://172.31.2.12:31500)

Slave3: [http://172.31.2.13:31500](http://172.31.2.13:31500)


#### Start Analytics Stack

Deploy Analytics stack (InfluxDB, Redis, Heapster, Spark) on the slave1 as configured in `cluster.yml`

    ./bin/start_analytics

Redis and InfluxDB's WebUI will become available on slave1 at:

Redis: [http://172.31.2.11:31610](http://172.31.2.11:31610)

InfluxDB: [http://172.31.2.11:31400](http://172.31.2.11:31400)

InfluxDB username and password: root

InfluxDB Hostname and Port Settings: 172.31.2.11 31410 and no SSL


#### Reset the Charmander environment

To reset the environment in to a fresh state:

```
./bin/reset_scheduler
./bin/start_cadvisor
./bin/start_analytics
```


