#/bin/bash
set -e

ANALYTICS_DIR=/vagrant/analytics

JAVASCALA_DIR=$ANALYTICS_DIR/spark/javascala
cd $JAVASCALA_DIR &&
    image_name="javascala" &&
	echo "Building $image_name" &&
	docker build -t $image_name .

MAXUSAGE_DIR=$ANALYTICS_DIR/spark/maxusage
cd $MAXUSAGE_DIR &&
    image_name="maxusage" &&
	echo "Building $image_name" &&
	docker build -t $image_name .

