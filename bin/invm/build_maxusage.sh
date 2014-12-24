#/bin/bash
set -e

ANALYTICS_DIR=/vagrant/analytics

MAXUSAGE_DIR=$ANALYTICS_DIR/spark/maxusage
cd $MAXUSAGE_DIR &&
    image_name="maxusage" &&
	echo "Building $image_name" &&
	docker build -t $image_name .

