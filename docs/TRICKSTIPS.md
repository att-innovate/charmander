#### Tips and Tricks

**/etc/hosts**

To access slave specific information thru the Mesos Web-UI we suggest that you add the ip addresses of our cluster nodes to your
local `/etc/hosts` file:

    172.31.1.11     master1  #mesosenv
    172.31.2.11     slave1   #mesosenv
    172.31.2.12     slave2   #mesosenv
    172.31.2.13     slave3   #mesosenv

**Build Issues with Vagrantfile**

There are those rare times when `vagrant up` fails. In those situations we suggest to do a clean `vagrant destroy` and `vagrant up` cycle.
This will get the system in to a consistent state again.

**Build Issues with ./bin/build.. scripts**

There are those random times when you see `tar: Unexpected EOF in archive` errors or some other funny error while building an image.
No problem, just run the build script again.

**Reset Scheduler**

If you feel that tasks are in a bad state just reset the cluster:

    ./bin/reset_cluster

This command simply restarts the Charmander-Scheduler/Framework which forces Mesos to cleanup all previous tasks assigned
to this scheduler/framework.

**Reboot cluster**

The whole cluster-setup can easily be rebooted into a clean state:

    vagrant reload

**Shutdown Cluster**

We suggest that you shutdown the cluster when you aren't running any experiments. We have encountered network issues
when leaving the cluster running for a long time.

Shutdown cluster

    vagrant halt

Start cluster

    vagrant up

**Redis updates are asynchronous**

The different Analytics-related services exchange the state with the scheduler using Redis. The polling interval of the
services is between 15s and 30s. Expect data to be _eventual-consistent_.

**Verify that Charmander-Scheduler is running**

In very rare cases it could be that after a reboot of the master node the Scheduler wasn't able to re-connect to Mesos.
We suggested that after a reboot you verify on the [Mesos-Frameworks](http://172.31.1.11:5050/#/frameworks) page that
charmander is listed as an active framework. In case of an issue just restart the scheduler/cluster:

    ./bin/reset_cluster


#### That's it, back to the homepage

[Homepage](https://github.com/att-innovate/charmander/)
