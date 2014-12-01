#!/bin/bash

# wait some time for HBASE to come up
sleep 20

# forward ports to HBASE
socat TCP-LISTEN:16000,fork TCP:$HBASE_PORT_16000_TCP_ADDR:16000 &
socat TCP-LISTEN:16020,fork TCP:$HBASE_PORT_16020_TCP_ADDR:16020 &

# adjust configuration files
sed -i "s/{{ZOOKEEPER_IP}}/${ZOOKEEPER_PORT_2181_TCP_ADDR:-localhost}/g" /opentsdb/opentsdb.conf
more /opentsdb/opentsdb.conf > /logs/opentsdb-start-conf.log

sed -i "s/{{ZOOKEEPER_IP}}/${ZOOKEEPER_PORT_2181_TCP_ADDR:-localhost}/g" /hbase/conf/hbase-site.xml
more /hbase/conf/hbase-site.xml >> /logs/opentsdb-start-conf.log

# Create tables
env COMPRESSION=NONE HBASE_HOME=/hbase /opentsdb/src/create_table.sh

# Run
cd opentsdb
./build/tsdb tsd --port=4242




