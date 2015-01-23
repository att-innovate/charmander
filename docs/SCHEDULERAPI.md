Scheduler-API
-------------

The Charmander-Scheduler offers a REST-like API to all the task scheduling functionality. We assume that Charmander is
running at its default location at `172.31.1.11:7075`.

#### Admin API

Simple ping-pong healthcheck

    curl -i 172.31.1.11:7075/admin/ping

Should return a _pong_.

#### Client API

**Start a Task**

To start a task in Mesos you will have to pass in a task-configuration (in json). Example configuration for cAdvisor:

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

    id           The name of the task. Charmander will internally add a timestamp to the id to make it unique.
    dockerimage  The name of the docker image to start
    mem          Memory-allocation requested
    cpus         Percentage of cpu request
    sla          Current sla-types are "one-per-node" (see cAdvisor) and "singleton" (see influxdb)
    nodetype     Node-types are either "analytics" (for analytics node) and "lab" (for lab nodes)
    notmetered   Defines if the metrics of a task gets metered/collected or not
    reshuffeable Defines if a task will be restarted by the "reshuffle" command. Typically set for simulators
    ports        Port-mapping for the container. _host_port_ and _container_port_ used to define intern and external port
    volumes      Volume-mapping for the container. _host_path_, _container_path_, and _mode_ define the mapping of volumes
    arguments    Additional arguments that will get passed to the _cmd_ to the _ENTRY_POINT_ of the docker image


Example: Start stress60mb

    curl -s -X POST -T loadsimulator/stress/stress60mb.json -H "Accept: application/json" -H "Content-Type: application/json" 172.31.1.11:7075/client/task

Which returns a confirmation that the task request got accepted and is waiting for a matching offer from Mesos to get started

    {"code":202,"message":"Run task: stress60"}

**List Task**

    curl 172.31.1.11:7075/client/task

Returns a detailed list of all the tasks (scheduled and running).

**Kill Task**

Kill all tasks whose task id starts with _stress_

    curl -X DELETE 172.31.1.11:7075/client/task/stress

This should return a list of all the tasks that are planned to be killed. Only running tasks in that list will get deleted.

    {"code":200,"message":"Kill task: stress60-1421970700191214531"}

**Reshuffle Tasks**

After you have collected _intelligence_ about the running simulators you typically want to verify that impact it has on
the distribution. Reshuffle will restart all the currently running simulators (`"reshuffleable": true`).

    curl 172.31.1.11:7075/client/task/reshuffle

and you will get a confirmation for that request.

    {"code":202,"message":"Reshuffle tasks"}

