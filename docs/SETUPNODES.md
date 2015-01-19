Setup Nodes
-----------

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

**Important!** We will have to reboot all the nodes once to get all the configuration options applied correctly.

```
vagrant reload
```

Mesos Management console should now be available at: [http://172.31.1.11:5050](http://172.31.1.11:5050)


### Reboot of the Charmander environment

To reboot in to a fresh test-environment:

```
vagrant halt
vagrant up
```

### Destroy test environment

```
vagrant destroy
```

