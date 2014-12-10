#Charmander Lab

### Prerequisites

#### OS X Command Line Tools
Make sure you have Command Line Tools installed before proceeding:

```
xcode-select --install
```

#### Virtual Environment

[VirtualBox](https://www.virtualbox.org), version >= 4.3.12

[Vagrant](http://www.vagrantup.com/downloads.html), version >= 1.6.0

#### Additional Vagrant Plugins (optional)

[vagrant-cachier](https://github.com/fgrehm/vagrant-cachier), >= 0.8.0

Installation:

```
vagrant plugin install vagrant-cachier
```

### Initial Bootstrap

Installs and configures the test environment. That process can take a while.

```
vagrant up
```

We will have to reboot all the nodes once to get all the configuration options applied correctly.

```
vagrant reload
```

Mesos Management console available at: [http://172.31.1.11:5050](http://172.31.1.11:5050)


### Deploy Charmander-Scheduler

Install and runs Charmander-Scheduler

```
./bin/deploy_scheduler
```


### Deploy cAdvisor

Deploys cAdvisor to all the slave nodes

```
./bin/start_cadvisor
```

Mesos console can be used to check on cAdvisor status.

cAdvisor WebUI will become available on both slave nodes at:

Slave1: [http://172.31.2.11:31500](http://172.31.2.11:31500)

Slave2: [http://172.31.2.12:31500](http://172.31.2.12:31500)

Slave3: [http://172.31.2.13:31500](http://172.31.2.13:31500)



### Reset the test environment

To reboot in to a fresh test-environment:

```
vagrant halt
vagrant up
./bin/start_cadvisor
```

### Temporarily suspend test environment

```
vagrant suspend
```

### Destroy test environment

```
vagrant destroy
```

