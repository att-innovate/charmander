#!/bin/bash
#
# run as sudo
#

SCRIPT_HOME="$( cd "$( dirname "$0" )" && pwd )"

# build java base image
cd $SCRIPT_HOME/../images/oracle-java7
docker build -t docker.registry.foundry:80/charmander-oracle-java7 .

# build rest
for dir in $SCRIPT_HOME/../images/*/
do
	cd $dir &&
	image_name="charmander-"${PWD##*/} &&
	echo "Building $image_name from $dir" &&
	docker build -t docker.registry.foundry:80/$image_name .
done
