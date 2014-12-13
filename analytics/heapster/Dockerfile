FROM busybox:ubuntu-14.04
MAINTAINER Charmander

ADD charmander-heapster /usr/bin/charmander-heapster
RUN chmod +x /usr/bin/charmander-heapster

ENTRYPOINT sleep 20; /usr/bin/charmander-heapster -stderrthreshold=INFO -sink_influxdb_host="172.31.2.11:31410" -source_redis_host="172.31.2.11:31600"

