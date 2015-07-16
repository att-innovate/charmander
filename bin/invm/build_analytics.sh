#/bin/bash
set -e

DIR=$PWD

ANALYTICS_DIR=/vagrant/analytics
# ANALYTICS_DATA_DIR=/analytics/data
ANALYTICS_LOG_DIR=/analytics/log

# mkdir -p $ANALYTICS_DATA_DIR/redis
# mkdir -p $ANALYTICS_DATA_DIR/influxdb

mkdir -p $ANALYTICS_LOG_DIR/influxdb

# chown -R 777 $ANALYTICS_DATA_DIR
chown -R 777 $ANALYTICS_LOG_DIR


ANALYTICSBASE_DIR=$ANALYTICS_DIR/analyticsbase
cd $ANALYTICSBASE_DIR &&
    image_name="analyticsbase" &&
	echo "Building $image_name" &&
	docker build -t $image_name .


REDIS_DIR=$ANALYTICS_DIR/redis
cd $REDIS_DIR &&
    image_name="redis" &&
	echo "Building $image_name" &&
	docker build -t $image_name .


INFLUXDB_DIR=$ANALYTICS_DIR/influxdb
cd $INFLUXDB_DIR &&
    image_name="influxdb" &&
	echo "Building $image_name" &&
	docker build -t $image_name .