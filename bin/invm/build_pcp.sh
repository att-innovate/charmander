#/bin/bash
set -e

DIR=$PWD

PCP_DIR=/vagrant/vector/pcp

cd $PCP_DIR &&
    image_name="pcp-all" &&
	echo "Building $image_name" &&
	docker build -t $image_name .

