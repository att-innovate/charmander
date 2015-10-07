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

# Platform Package Versiona
MESOS_PACKAGE_VERSION = '0.23.0-1.0.ubuntu1404'
DOCKER_PACKAGE_VERSION = '1.7.1'
GO_PACKAGE_VERSION = '1.5.1'

# Docker Image Versiona
PHUSION_IMAGE_VERSION = '0.9.17'
BUSY_BOX_IMAGE_VERSION = 'ubuntu-14.04'
CADVISOR_IMAGE_VERSION = '0.18.0'



Vagrant.require_version ">= 1.7.1"

Vagrant.configure("2") do |config|
  config.vm.box = BOX_NAME
  config.vm.box_url = BOX_URI

  if Vagrant.has_plugin?('vagrant-cachier')
    config.cache.scope = :box
  end

  [ninfos[:master], ninfos[:slave]].flatten.each_with_index do |ninfo, i|
    config.vm.define ninfo[:hostname] do |cfg|

      cfg.vm.provider :virtualbox do |vb, override|
        override.vm.hostname = ninfo[:hostname]
        override.vm.network :private_network, :ip => ninfo[:ip]

        vb.name = 'charmander-' + ninfo[:hostname]
        vb.gui = false
        vb.customize ["modifyvm", :id, "--nictype1", "Am79C973"]
        vb.customize ["modifyvm", :id, "--nictype2", "Am79C973"]
        
        if ninfo[:hostname] == ninfos[:analytics][:node] then
          vb.customize ["modifyvm", :id, "--memory", ninfos[:analytics][:mem], "--cpus", ninfos[:analytics][:cpus]]
        elsif ninfo[:hostname] == ninfos[:traffic][:node] then
            vb.customize ["modifyvm", :id, "--memory", ninfos[:traffic][:mem], "--cpus", ninfos[:traffic][:cpus]]
        else
          vb.customize ["modifyvm", :id, "--memory", ninfo[:mem], "--cpus", ninfo[:cpus] ]
        end
      end

      # Initialize command list for provisioning phase
      # and add some additional keys/repository for Docker, Mesos, and Performance CoPilot
      pkg_once_cmd  = 'apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9; '
      pkg_once_cmd << 'echo deb https://get.docker.com/ubuntu docker main > /etc/apt/sources.list.d/docker.list; '
      pkg_once_cmd << 'apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF; DISTRO=$(lsb_release -is | tr "[:upper:]" "[:lower:]"); CODENAME=$(lsb_release -cs); '
      pkg_once_cmd << 'echo "deb http://repos.mesosphere.io/${DISTRO} ${CODENAME} main" | tee /etc/apt/sources.list.d/mesosphere.list; '
      pkg_once_cmd << 'apt-add-repository ppa:simon-kjellberg/pcp-daily; '
      pkg_once_cmd << 'apt-get update; '

      # Initialize command list that gets run on every reboot
      # and we won't stop if some of the commands fail
      pkg_always_cmd = 'echo "Running init script"; set +e; '

      # install aufs driver for docker to prevent race condition issue with devicemapper
      pkg_once_cmd << 'apt-get install -y linux-image-extra-$(uname -r) aufs-tools; '

      # Install docker
      pkg_once_cmd << "apt-get install -y lxc-docker-#{DOCKER_PACKAGE_VERSION}; "
      pkg_once_cmd << "sed -i 's,GRUB_CMDLINE_LINUX=\"\",GRUB_CMDLINE_LINUX=\"cgroup_enable=memory swapaccount=1\",' /etc/default/grub; "
      pkg_once_cmd << 'update-grub; '

      pkg_once_cmd << "docker pull phusion/baseimage:#{PHUSION_IMAGE_VERSION}; "
      pkg_once_cmd << "docker pull busybox:#{BUSY_BOX_IMAGE_VERSION}; "
      pkg_once_cmd << "docker pull google/cadvisor:#{CADVISOR_IMAGE_VERSION}; "

      # at bootup always remove old containers
      pkg_always_cmd << 'docker ps -a | grep \'Exit\' | awk \'{print $1}\' | xargs -r docker rm; '

      # Install go
      pkg_once_cmd << "wget --progress=bar:force https://storage.googleapis.com/golang/go#{GO_PACKAGE_VERSION}.linux-amd64.tar.gz; "
      pkg_once_cmd << "tar -C /usr/local -xzf go#{GO_PACKAGE_VERSION}.linux-amd64.tar.gz; "

      # Install Perf Tool
      pkg_once_cmd << "apt-get -y install linux-tools-common linux-tools-generic linux-tools-`uname -r`; "

      # Install Top Tools
      pkg_once_cmd << "apt-get -y install iftop htop; "

      # Install ntp
      pkg_once_cmd << "apt-get -y install ntp; "

      # Install Performance Copilot
      pkg_once_cmd << "apt-get -y install pcp pcp-webapi; "
      pkg_once_cmd << "sed -i 's,PMCD_REQUEST_TIMEOUT=1,PMCD_REQUEST_TIMEOUT=10,' /etc/pcp/pmwebd/pmwebd.options; "

      # Update hosts file
      [ninfos[:master], ninfos[:slave]].flatten.each_with_index do |host, i|
        pkg_once_cmd << "echo '#{host[:ip]} #{host[:hostname]}' >> /etc/hosts; "
      end

      # Install node specific software
      if master?(ninfo[:hostname]) then
        pkg_once_cmd << "apt-get -y install mesos=#{MESOS_PACKAGE_VERSION}; "
        pkg_once_cmd << 'mkdir -p /etc/mesos-master; '
        pkg_once_cmd << "echo #{ninfo[:ip]} | dd of=/etc/mesos-master/hostname; "
        pkg_once_cmd << "echo #{ninfo[:ip]} | dd of=/etc/mesos-master/ip; "
        pkg_once_cmd << 'echo charmander | dd of=/etc/mesos-master/cluster; '
        pkg_once_cmd << 'echo in_memory | dd of=/etc/mesos-master/registry; '
        pkg_once_cmd << 'echo 1 | dd of=/etc/mesos-master/quorum; '
        pkg_once_cmd << 'echo zk://master1:2181/mesos | dd of=/etc/mesos/zk; '
        pkg_once_cmd << 'rm /etc/init/mesos-slave.conf; '

        # remove previous node-list files generated by the slaves, see below
        pkg_once_cmd << 'rm /vagrant/node_*.txt; '

      elsif slave?(ninfo[:hostname]) then
        if ninfo[:hostname] == ninfos[:analytics][:node] then
          nodetype = 'analytics'
        elsif ninfo[:hostname] == ninfos[:traffic][:node] then
          nodetype = 'traffic'
        else
          nodetype = 'lab'
        end
        pkg_once_cmd << "apt-get -y install mesos=#{MESOS_PACKAGE_VERSION}; "
        pkg_once_cmd << 'mkdir -p /etc/mesos-slave; '
        pkg_once_cmd << 'echo docker,mesos | dd of=/etc/mesos-slave/containerizers; '
        pkg_once_cmd << 'echo 5mins | dd of=/etc/mesos-slave/executor_registration_timeout; '
        pkg_once_cmd << "echo 'nodename:#{ninfo[:hostname]};nodetype:#{nodetype}' | dd of=/etc/mesos-slave/attributes; "
        pkg_once_cmd << "echo #{ninfo[:ip]} | dd of=/etc/mesos-slave/ip; "
        pkg_once_cmd << 'echo zk://master1:2181/mesos | dd of=/etc/mesos/zk; '
        pkg_once_cmd << 'rm /etc/init/mesos-master.conf; rm /etc/init/zookeeper.conf; '

        # scripts in the bin directory require a list of those different nodes
        # to build/install the docker images
        pkg_once_cmd << "echo #{ninfo[:hostname]} >> /vagrant/node_slaves.txt; "
        if ninfo[:hostname] == ninfos[:analytics][:node] then
          pkg_once_cmd << "echo #{ninfo[:hostname]} >> /vagrant/node_analytics.txt; "
        elsif ninfo[:hostname] == ninfos[:traffic][:node] then
            pkg_once_cmd << "echo #{ninfo[:hostname]} >> /vagrant/node_traffic.txt; "
        else
          pkg_once_cmd << "echo #{ninfo[:hostname]} >> /vagrant/node_lab.txt; "
        end

        # increase conntrack size to prevent the traffic-generators to be shut down by os
        if ninfo[:hostname] == ninfos[:traffic][:node] then
          pkg_always_cmd << 'sysctl -w net.netfilter.nf_conntrack_max=131072; '
        end
      end

      # end of command list
      pkg_always_cmd << 'set -e'
      pkg_once_cmd << 'echo "!! ---- vagrant reload required ---- !!"'

      cfg.vm.provision :shell, :inline => pkg_once_cmd,   :run => :once   # installation of all the software/services
      cfg.vm.provision :shell, :inline => pkg_always_cmd, :run => :always # gets executed at every reboot
    end
  end

end



