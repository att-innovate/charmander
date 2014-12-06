#/bin/bash
set -e

ANALYTICS_DIR=/vagrant/analytics
ANALYTICS_DATA_DIR=/data

mkdir -p $ANALYTICS_DATA_DIR/redis
chown -R 777 $ANALYTICS_DATA_DIR

REDIS_DIR=$ANALYTICS_DIR/redis
cd $REDIS_DIR &&
    image_name="redis" &&
	echo "Building $image_name" &&
	docker build -t $image_name .
