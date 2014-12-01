# -*- mode: ruby -*-
# vi: set ft=ruby :

def gen_node_infos(cluster_yml)

  master_n = 1
  master_mem = cluster_yml['master_mem']
  master_cpus = cluster_yml['master_cpus']

  slave_n = cluster_yml['slave_n']
  slave_mem = cluster_yml['slave_mem']
  slave_cpus = cluster_yml['slave_cpus']

  master_ipbase = cluster_yml['master_ipbase']
  slave_ipbase = cluster_yml['slave_ipbase']

  master_infos = (1..master_n).map do |i|
  { :hostname => "master#{i}",
    :ip => master_ipbase + "#{10+i}",
    :mem => master_mem,
    :cpus => master_cpus
  }
  end

  slave_infos = (1..slave_n).map do |i|
    { :hostname => "slave#{i}",
      :ip => slave_ipbase + "#{10+i}",
      :mem => slave_mem,
      :cpus => slave_cpus
    }
  end

  return { :master => master_infos, :slave=>slave_infos }
end
