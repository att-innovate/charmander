Scheduler-API
-------------

The Charmander-Scheduler offers a REST-like API for its task scheduling functionality. For this documentation
we assume that Charmander is running at its default location at `172.31.1.11:7075`.

#### Admin API

Simple ping-pong healthcheck

    curl -i 172.31.1.11:7075/admin/ping

Should return a _pong_.

#### Client API

**Start a Task**

To start a task in Mesos you will have to pass in a task-configuration.

Example configuration for cAdvisor:

    {
        "id":          "cadvisor",
        "dockerimage": "google/cadvisor:0.6.2",
        "mem":         "50",
        "sla":         "one-per-node",
        "notmetered":  true,
        "volumes": [
            {
                "host_path":"/",
                "container_path":"/rootfs",
                "mode":"ro"
            },
            {
                "host_path":"/var/run",
                "container_path":"/var/run",
                "mode":"rw"
            },
            {
                "host_path":"/sys",
                "container_path":"/sys",
                "mode":"ro"
            },
            {
                "host_path":"/var/lib/docker",
                "container_path":"/var/lib/docker/",
                "mode":"ro"
            }
        ],
        "ports": [
            {
                "host_port":"31500",
                "container_port":"8080"
            }
        ]

    }

Example configuration for stress60mb:

    {
        "id": "stress60",
        "dockerimage": "stress",
        "mem": "100",
        "reshuffleable": true,
        "nodetype": "lab",
        "arguments": ["--vm-bytes", "60M", "--vm", "1"]
    }

Example configration for influxdb:

    {
        "id":          "influxdb",
        "dockerimage": "influxdb",
        "mem":         "100",
        "cpus":        "1",
        "sla":         "singleton",
        "nodetype":    "analytics",
        "notmetered":  true,
        "volumes": [
            {
                "host_path":"/analytics/log/influxdb",
                "container_path":"/log/",
                "mode":"rw"
            }
        ],
        "ports": [
            {
                "host_port":"31400",
                "container_port":"8083"
            },
            {
                "host_port":"31410",
                "container_port":"8086"
            }
        ]

    }

Field-definitions:

    id           The name of the task. Charmander will internally add a timestamp to the id to make it unique
    dockerimage  The name of the docker image to start
    mem          Memory-allocation requested
    cpus         Percentage of cpu requested
    sla          Current supported sla-types are "one-per-node" (see cAdvisor) and "singleton" (see influxdb)
    nodetype     Node-types can be either "analytics" (for analytics node) and "lab" (for lab nodes)
    notmetered   Defines if the metrics of a task gets metered/collected or not
    reshuffeable Defines if a task will be restarted by the "reshuffle" command. Typically set for simulators
    ports        Container-Port-mapping: "host_port" and "container_port" define intern and external port, in "bridge" mode only
    volumes      Volume-mapping for the container. "host_path", "container_path", and "mode" define the mapping of volumes
    networkmode  Supported modes: "bridge", "host", and "none", see Docker documentation for further explanation
    arguments    Additional arguments that will get passed to the ENTRY_POINT of the docker image


Example: Start stress60mb

    curl -s -X POST -T loadsimulator/stress/stress60mb.json -H "Accept: application/json" -H "Content-Type: application/json" 172.31.1.11:7075/client/task

Which returns a confirmation that the task request got accepted and is now waiting for a matching offer from Mesos to get started

    {"code":202,"message":"Run task: stress60"}

**List Task**

    curl 172.31.1.11:7075/client/task

Returns a detailed list of all the tasks (scheduled and running).

**Kill Task**

Example: Kill all tasks whose task id starts with _stress_

    curl -X DELETE 172.31.1.11:7075/client/task/stress

This should return a list of all the tasks that are planned to be killed. Only running tasks in that list will get deleted.

    {"code":200,"message":"Kill task: stress60-1421970700191214531"}

**Reshuffle Tasks**

After you have collected _intelligence_ about the running simulators you typically want to verify the impact it has on
future distribution. Reshuffle will restart all the currently running simulators (`"reshuffleable": true`) based on the
collected _task-intelligence_.

    curl 172.31.1.11:7075/client/task/reshuffle

.. response you get.

    {"code":202,"message":"Reshuffle tasks"}



#### Next Script Reference

[Script Reference](https://github.com/att-innovate/charmander/blob/master/docs/SCRIPTS.md)

