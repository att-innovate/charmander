#/bin/bash
set -e

export PATH=$PATH:/usr/local/go/bin

ANALYTICS_DIR=/vagrant/analytics


CONTAINERRESOLVER_DIR=$ANALYTICS_DIR/containerresolver
export GOPATH=$CONTAINERRESOLVER_DIR
cd $CONTAINERRESOLVER_DIR &&
    go build containerresolver.go
    image_name="containerresolver" &&
	echo "Building $image_name" &&
	docker build -t $image_name .

