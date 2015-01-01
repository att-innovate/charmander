#/bin/bash
set -e

ANALYTICS_DIR=/vagrant/analytics

JAVASCALA_DIR=$ANALYTICS_DIR/spark/javascala
cd $JAVASCALA_DIR &&
    image_name="javascala" &&
	echo "Building $image_name" &&
	docker build -t $image_name .

SPARKKERNEL_DIR=$ANALYTICS_DIR/spark/sparkkernel
cd $SPARKKERNEL_DIR &&
    image_name="sparkkernel" &&
	echo "Building $image_name" &&
	docker build -t $image_name .

