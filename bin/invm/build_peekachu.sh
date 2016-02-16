#/bin/bash
set -e

DIR=$PWD

PEEKACHU_DIR=/vagrant/peekachu

cd $PEEKACHU_DIR &&
    image_name="peekachu" &&
	echo "Building $image_name" &&
	docker build -t $image_name .

