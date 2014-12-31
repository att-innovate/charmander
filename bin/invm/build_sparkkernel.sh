#/bin/bash
set -e

ANALYTICS_DIR=/vagrant/analytics

SPARKKERNEL_DIR=$ANALYTICS_DIR/spark/sparkkernel
cd $SPARKKERNEL_DIR &&
    image_name="sparkkernel" &&
	echo "Building $image_name" &&
	docker build -t $image_name .

