#!/bin/bash
#
# run as sudo
#

SCRIPT_HOME="$( cd "$( dirname "$0" )" && pwd )"

for dir in $SCRIPT_HOME/../images/*/
do
	cd $dir &&
	image_name="charmander-"${PWD##*/} &&
	echo "Pushing $image_name" &&
	docker push docker.registry.foundry:80/$image_name
done
