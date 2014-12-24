#/bin/bash
set -e

ANALYTICS_DIR=/vagrant/analytics

MAXUSAGERESOLVER_DIR=$ANALYTICS_DIR/spark/max_usage_resolver
cd $MAXUSAGERESOLVER_DIR &&
    image_name="maxusageresolver" &&
	echo "Building $image_name" &&
	docker build -t $image_name .

