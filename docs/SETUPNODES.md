Setup Nodes
-----------

![image](https://github.com/att-innovate/charmander/blob/master/docs/assets/Nodes.png?raw=true)

#### Prerequisites

**Virtual Environment**

Tested on OSX Yosemite.

- [VirtualBox](https://www.virtualbox.org), version >= 4.3.20
- [Vagrant](http://www.vagrantup.com/downloads.html), version >= 1.7.1

Verify vagrant version:

    vagrant version

**Additional Vagrant Plugins (optional)**

[vagrant-cachier](https://github.com/fgrehm/vagrant-cachier), >= 1.1.0

This optional plugin helps to speed up the installation of Charmander, but it also has caused some dependency-issues in the past.
Use with caution.

Installation:

    vagrant plugin install vagrant-cachier


#### Default Configuration, 4 Node Cluster

The script by default creates a 4 node cluster (master1, slave1 .. 3). Slave1 will host the analytics stack and slave2 and slave 3
become lab nodes. The default configuration is defined in `cluster.yml`.

    # Mesos cluster configurations

    # The numbers of servers
    ##############################
    slave_n  : 3      # hostname will be slave1,slave2,…

    # Name of slave-node assigned to do analytics
    # All other slave nodes become "lab-nodes"
    ################################################
    analytics_node : "slave1"

    # Memory and Cpu settings
    ##########################################
    master_mem     : 384
    master_cpus    : 1
    analytics_mem  : 2048
    analytics_cpus : 2
    slave_mem      : 1024
    slave_cpus     : 2


Changes in that file require a **complete rebuild** of all the nodes.


#### Initial Bootstrap

Installs and configures the test environment. That process can take a while.

    vagrant up

**Important!** We will have to reboot all the nodes once to get all the configuration options applied correctly.

    vagrant reload

Mesos Management console should now be available at: [http://172.31.1.11:5050](http://172.31.1.11:5050)


#### Next deploy Charmander-Scheduler

[Deploy Scheduler](https://github.com/att-innovate/charmander/blob/master/docs/SETUPSCHEDULER.md)


#### Reboot of the Charmander environment

To reboot in to a fresh test-environment:

    vagrant halt
    vagrant up

#### Destroy Charmander environment

    vagrant destroy

