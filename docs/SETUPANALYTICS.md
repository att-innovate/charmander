Build and deploy Analytics Stack
--------------------------------

Charmander uses different open-source tools as its Analytics-Stack:

- [InfluxDB](http://influxdb.com) as central store for all the collected timeseries
- [Redis](http://redis.io) as Task-Insights database to share information about tasks and nodes between Analytics-Stack, Spark, and Charmander-Scheduler
- container-resolver, a simple service we wrote to help with the translation of mesos' container-ids in to task-ids

Build Docker images for our Analytics stack (InfluxDB, Redis, container-resolver) on the _analytics-node_, _slave1_ as configured in `cluster.yml`

```
./bin/build_analytics
```

#### Next run a simple Experiment

[Maxusage](https://github.com/att-innovate/charmander-experiment-maxusage)

