# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'yaml'
require './lib/gen_node_infos'
require './lib/predicates'

base_dir = File.expand_path(File.dirname(__FILE__))
conf = YAML.load_file(File.join(base_dir, "cluster.yml"))
ninfos = gen_node_infos(conf)

BOX_NAME = "ubuntu-dev-trusty"
BOX_URI = "http://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
MESOS_PACKAGE_VERSION = "0.20.1-1.0.ubuntu1404"

Vagrant.require_version ">= 1.6.0"

Vagrant.configure("2") do |config|
  config.vm.box = BOX_NAME
  config.vm.box_url = BOX_URI

  if Vagrant.has_plugin?('vagrant-cachier')
    config.cache.scope = :box
  end

  unless Vagrant.has_plugin?('vagrant-hosts')
    raise 'vagrant-hosts is not installed!'
  end

  [ninfos[:master], ninfos[:slave]].flatten.each_with_index do |ninfo, i|
    config.vm.define ninfo[:hostname] do |cfg|

      cfg.vm.provider :virtualbox do |vb, override|
        override.vm.hostname = ninfo[:hostname]
        override.vm.network :private_network, :ip => ninfo[:ip]
        override.vm.provision :hosts do |host_provisioner|
          host_provisioner.autoconfigure = true
          host_provisioner.add_host '12.144.186.254', ['docker.registry.foundry']
        end

        vb.name = 'charmander-' + ninfo[:hostname]
        vb.customize ["modifyvm", :id, "--memory", ninfo[:mem], "--cpus", ninfo[:cpus] ]
      end

      # Default behaviour for initial install and for every reboot
      pkg_once_cmd  = 'apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF; DISTRO=$(lsb_release -is | tr "[:upper:]" "[:lower:]"); CODENAME=$(lsb_release -cs); '
      pkg_once_cmd << 'echo "deb http://repos.mesosphere.io/${DISTRO} ${CODENAME} main" | tee /etc/apt/sources.list.d/mesosphere.list; '
      pkg_once_cmd << 'apt-get update; '

      pkg_always_cmd = 'echo "done"; '

      # Install docker
      pkg_once_cmd << 'curl -s https://get.docker.io/ubuntu/ | sudo sh; '
      pkg_once_cmd << "sed -i 's,GRUB_CMDLINE_LINUX=\"\",GRUB_CMDLINE_LINUX=\"cgroup_enable=memory swapaccount=1\",' /etc/default/grub; "
      pkg_once_cmd << 'update-grub; '
      pkg_once_cmd << "sed -i 's,DOCKER_OPTS=.*,DOCKER_OPTS=\"-d -r=false -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock\",' /etc/init/docker.conf; "
      pkg_once_cmd << 'service docker restart; sleep 5; '
      pkg_once_cmd << 'docker pull phusion/baseimage:0.9.9; '
      pkg_once_cmd << 'docker pull google/cadvisor:0.4.1; '

      # at bootup always remove old containers
      pkg_always_cmd << 'docker ps -a | grep \'Exit\' | awk \'{print $1}\' | xargs -r docker rm; '

      # Install go
      pkg_once_cmd << 'wget https://storage.googleapis.com/golang/go1.3.3.linux-amd64.tar.gz; '
      pkg_once_cmd << 'tar -C /usr/local -xzf go1.3.3.linux-amd64.tar.gz; '

      # Install node specific software
      if master?(ninfo[:hostname]) then
        pkg_once_cmd << "apt-get -y install mesos=#{MESOS_PACKAGE_VERSION}; "
        pkg_once_cmd << 'mkdir -p /etc/mesos-master; '
        pkg_once_cmd << "echo #{ninfo[:ip]} | dd of=/etc/mesos-master/hostname; "
        pkg_once_cmd << "echo #{ninfo[:ip]} | dd of=/etc/mesos-master/ip; "
        pkg_once_cmd << 'echo mesosenv | dd of=/etc/mesos-master/cluster; '
        pkg_once_cmd << 'echo in_memory | dd of=/etc/mesos-master/registry; '
        pkg_once_cmd << 'echo 1 | dd of=/etc/mesos-master/quorum; '
        pkg_once_cmd << 'echo zk://master1:2181/mesos | dd of=/etc/mesos/zk; '
        pkg_once_cmd << 'stop mesos-slave; rm /etc/init/mesos-slave.conf; '
      elsif slave?(ninfo[:hostname]) then
        pkg_once_cmd << "apt-get -y install mesos=#{MESOS_PACKAGE_VERSION}; "
        pkg_once_cmd << 'mkdir -p /etc/mesos-slave; '
        pkg_once_cmd << 'echo docker,mesos | dd of=/etc/mesos-slave/containerizers; '
        pkg_once_cmd << 'echo 5mins | dd of=/etc/mesos-slave/executor_registration_timeout; '
        pkg_once_cmd << "echo nodename:#{ninfo[:hostname]} | dd of=/etc/mesos-slave/attributes; "
        pkg_once_cmd << "echo #{ninfo[:ip]} | dd of=/etc/mesos-slave/ip; "
        pkg_once_cmd << 'echo zk://master1:2181/mesos | dd of=/etc/mesos/zk; '
        pkg_once_cmd << 'stop mesos-master; rm /etc/init/mesos-master.conf; stop zookeeper; rm /etc/init/zookeeper.conf; '
      end

      cfg.vm.provision :shell, :inline => pkg_once_cmd,   :run => :once   # installation of all the software/services
      cfg.vm.provision :shell, :inline => pkg_always_cmd, :run => :always # gets executed at every reboot
    end
  end

end



