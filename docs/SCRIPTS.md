Script Reference
----------------

A list of all the scripts that come with Charmander and can be found in the `./bin` directory.
The scripts should get started from the root of the Charmander project, example `./bin/start_cadvisor`.

**Build Scripts**

The build-scripts get used to build the docker images on the corresponding lab and/or analytics nodes

    build_analytics   : builds the docker images for the Analytics-Stack (heapster, influxdb, redis, containerresolver)
    build_maxusage    : builds the docker image for the max_usage analyzer
    build_simulator   : builds the images for all the simulators
    build_sparkkernel : builds the image for the spark-kernel installation (spark, iPython, spark-kernel)

**Deploy**

    deploy_scheduler  : clones the scheduler code on to the master1 node, builds it, and start is as a service

**Task Admin**

    get_tasklist : get a detailed list of all running and scheduled tasks
    kill_task    : kills all the tasks whose id start with the provided string

**Reshuffle**

    reshuffle : restarts all the simulators ("reshuffleable": true)

**Start Tasks**

The following commands can be used to start individual tasks and task groups

    start_analytics     : starts the Analytics-Stack (heapster, influxdb, redis, containerresolver)
    start_cadvisor      : starts cAdvisor on all nodes
    start_cpufixed      : starts simulator with a fixed load pattern
    start_cpurandom     : starts simulator with random cpu pattern
    start_lookbusy80mb  : starts lookbusy simulator consuming fixed 80MB
    start_lookbusy200mb : starts lookbusy simulator consuming fixed 200MB
    start_maxusage      : starts max-usage analyzer
    start_sparkkernel   : the spark-kernel installation (spark, iPython, spark-kernel)
    start_stress60mb    : starts stress simulator consuming not more than 60MB



#### Next Tips and Tricks

[Tips and Tricks](https://github.com/att-innovate/charmander/blob/master/docs/TRICKSTIPS.md)



