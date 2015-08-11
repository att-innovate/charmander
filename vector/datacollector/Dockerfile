FROM busybox:ubuntu-14.04
MAINTAINER Charmander

ADD charmander-datacollector /usr/bin/charmander-datacollector
RUN chmod +x /usr/bin/charmander-datacollector

ENTRYPOINT ["/usr/bin/charmander-datacollector", "-stderrthreshold=INFO", "-influxdb_host=172.31.2.11:31410", "-source_redis_host=172.31.2.11:31600"]

