#/bin/bash
set -e

export PATH=$PATH:/usr/local/go/bin

LOADSIMULATOR_DIR=/vagrant/loadsimulator


LOOKBUSY_DIR=$LOADSIMULATOR_DIR/lookbusy
cd $LOOKBUSY_DIR &&
    image_name="lookbusy" &&
	echo "Building $image_name" &&
	docker build -t $image_name .


STRESS_DIR=$LOADSIMULATOR_DIR/stress
cd $STRESS_DIR &&
    image_name="stress" &&
	echo "Building $image_name" &&
	docker build -t $image_name .


CPURANDOM_DIR=$LOADSIMULATOR_DIR/cpurandom
export GOPATH=$CPURANDOM_DIR
cd $CPURANDOM_DIR &&
    go build cpurandom.go
    image_name="cpurandom" &&
	echo "Building $image_name" &&
	docker build -t $image_name .


CPUFIXED_DIR=$LOADSIMULATOR_DIR/cpufixed
export GOPATH=$CPUFIXED_DIR
cd $CPUFIXED_DIR &&
    go build cpufixed.go
    image_name="cpufixed" &&
	echo "Building $image_name" &&
	docker build -t $image_name .
