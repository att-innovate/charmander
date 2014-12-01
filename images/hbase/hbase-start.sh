#!/bin/bash

export HBASE_LOG_DIR=/logs

sed -i "s/{{ZOOKEEPER_IP}}/${ZOOKEEPER_PORT_2181_TCP_ADDR:-localhost}/g" /hbase/conf/hbase-site.xml
more /hbase/conf/hbase-site.xml > /logs/hbase-start-conf.log

more /hbase/conf/hbase-env.sh >> /logs/hbase-start-conf.log

/hbase/bin/start-hbase.sh

sleep 10
tail -f /logs/hbase--master-devenv1.log



