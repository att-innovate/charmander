Script Reference
----------------

A list of all the scripts that come with Charmander and can be found in the `./bin` directory.
The scripts should get started from the root of the Charmander project, example `./bin/start_cadvisor`.

**Build Scripts**

The build-scripts get used to build the docker images on the corresponding lab and/or analytics nodes

    build_analytics : builds the docker images for the Analytics-Stack (heapster, influxdb, redis, containerresolver)
    build_cadvisor  : builds the docker images for cAdvisor and correpsonding data-collector
    build_vector    : builds the docker images for Vector and correpsonding data-collector

**Deploy**

    deploy_scheduler  : clones the scheduler code on to the master1 node, builds it, and start is as a service

**Task Admin**

    get_tasklist : get a detailed list of all running and scheduled tasks
    kill_task    : kills all the tasks whose id start with the provided string

**Reset Cluster**

    reset_cluster : restarts Charmander lab environment, doesn't restart VMs.

**Reshuffle**

    reshuffle : restarts all the simulators ("reshuffleable": true)

**Start Tasks**

The following commands can be used to start individual tasks and task groups

    start_analytics : starts the Analytics-Stack (heapster, influxdb, redis, containerresolver)
    start_cadvisor  : starts cAdvisor on all nodes. and data-collector on the analytics node
    start_vector    : starts Vector on all nodes. and data-collector on the analytics node 



#### Next Tips and Tricks

[Tips and Tricks](https://github.com/att-innovate/charmander/blob/master/docs/TRICKSTIPS.md)



