#Mesos - Marathon - Docker - cAdvisor - Devenv (OpenTSDB, HBase, Redis)

Vagrant script to build up a test environment with 1 Zookeeper, 1 Mesos-Master, 2 Mesos-Slaves, 1 Marathon, and 1 Devenv node.

### Prerequisites

#### OS X Command Line Tools
Make sure you have Command Line Tools installed before proceeding:

```
xcode-select --install
```

#### Virtual Environment

[VirtualBox](https://www.virtualbox.org), version >= 4.3.12

[Vagrant](http://www.vagrantup.com/downloads.html), version >= 1.6.0

#### Additional Vagrant Plugins

[vagrant-cachier](https://github.com/fgrehm/vagrant-cachier), >= 0.8.0

Installation:

```
vagrant plugin install vagrant-cachier
```

[vagrant-hosts](https://github.com/adrienthebo/vagrant-hosts), >= 2.2.0

Installation:

```
vagrant plugin install vagrant-hosts
```

### Initial Bootstrap

Installs and configures the test environment. That process can take a while.

```
vagrant up
```

We will have to reboot all the nodes once to get all the configuration options applied correctly.

```
vagrant halt
vagrant up
```

Mesos Management console available at: [http://172.31.1.11:5050](http://172.31.1.11:5050)

Marathon Management console available at: [http://172.31.3.11:8080](http://172.31.3.11:8080)


### Deploy cAdvisor

Deploys cAdvisor to all the slave nodes

```
./bin/start_cadvisor
```

Mesos or Marathon console can be used to check on cAdvisor status.

cAdvisor WebUI will become available on both slave nodes at:

Slave1: [http://172.31.2.11:8070](http://172.31.2.11:8070)

Slave2: [http://172.31.2.12:8070](http://172.31.2.12:8070)


Docker and cAdvisor services are available via REST via their default ports from your local system:

```
cAdvisor Slave1 172.31.2.11:8070
cAdvisor Slave2 172.31.2.12:8070
docker Slave1   172.31.2.11:2375
docker Slave2   172.31.2.12:2375
```

### Init Devenv

This will pull all the docker images from the server.

```
./bin/devenv init
```

### Start Devenv

Start the devenv container:

```
./bin/devenv start
```

You should see:

```
Started REDIS in container f49c9910da35
Started HBASE in container c435621da435
Started OPENTSDB in container ecfdb18d09bc
```

And if you want to check the status of the running services:

```
./bin/devenv status
```

All the admin pages of all the services can be accessed at:

HBase: [http://172.31.4.11:16010/master.jsp](http://172.31.4.11:16010/master.jsp)

OpenTSDB: [http://172.31.4.11:4242/](http://172.31.4.11:4242/)

Redis Commander: [http://172.31.4.11:8081/](http://172.31.4.11:8081)

cAdvisor: [http://172.31.4.11:8070/](http://172.31.4.11:8070)


And all the services can now be accessed via their default ports from your local system:

```
hbase.master 172.31.4.11:16000
hbase.region 172.31.4.11:16020
redis        172.31.4.11:6379
opentsdb     172.31.4.11:4242
```


### Reset the test environment

To reboot in to a fresh test-environment:

```
vagrant halt
vagrant up
./bin/start_cadvisor
./bin/devenv start
```

### Temporarily suspend test environment

```
vagrant suspend
```

### Destroy test environment

```
vagrant destroy
```

