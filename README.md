#Charmander Lab

### Prerequisites

#### Virtual Environment

Tested on OSX Yosemite.

[VirtualBox](https://www.virtualbox.org), version >= 4.3.20

[Vagrant](http://www.vagrantup.com/downloads.html), version >= 1.7.1

Verify vagrant version:

```
vagrant version
```

#### Additional Vagrant Plugins (optional)

[vagrant-cachier](https://github.com/fgrehm/vagrant-cachier), >= 1.1.0

This optional plugin helps to speed up the installation of Charmander, but it also has caused some dependency-issues in the past.
Use with caution.

Installation:

```
vagrant plugin install vagrant-cachier
```

### Initial Bootstrap

Installs and configures the test environment. That process can take a while.

```
vagrant up
```

Important! We will have to reboot all the nodes once to get all the configuration options applied correctly.

```
vagrant reload
```

Mesos Management console should now be available at: [http://172.31.1.11:5050](http://172.31.1.11:5050)


### Deploy Charmander-Scheduler

Install and start up Charmander-Scheduler, our "Mesos-Framework"

```
./bin/deploy_scheduler
```

Verify that is shows up under Frameworks in the Mesos Management Console.


### Deploy cAdvisor

Deploys cAdvisor to all the slave nodes

```
./bin/start_cadvisor
```

Mesos console can be used to check on cAdvisor status.

cAdvisor WebUI will become available on all the slave nodes at:

Slave1: [http://172.31.2.11:31500](http://172.31.2.11:31500)

Slave2: [http://172.31.2.12:31500](http://172.31.2.12:31500)

Slave3: [http://172.31.2.13:31500](http://172.31.2.13:31500)


### Build and start Analytics Stack

Deploy Analytics stack (InfluxDB, Redis, Heapster, Spark) on the slave1 as configured in `cluster.yml`

```
./bin/build_analytics
./bin/start_analytics
```

Redis and InfluxDB's WebUI will become available on slave1 at:

Redis: [http://172.31.2.11:31610](http://172.31.2.11:31610)

InfluxDB: [http://172.31.2.11:31400](http://172.31.2.11:31400)

InfluxDB username and password: root

InfluxDB Hostname and Port Settings: 172.31.2.11 31410 and no SSL


### Reset the Charmander environment

To reset the environment in to a fresh state:

```
./bin/reset_scheduler
./bin/start_cadvisor
./bin/start_analytics
```

### Reboot of the Charmander environment

To reboot in to a fresh test-environment:

```
vagrant halt
vagrant up
./bin/reset_scheduler
./bin/start_cadvisor
./bin/start_analytics
```

### Destroy test environment

```
vagrant destroy
```

