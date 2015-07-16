#!/bin/bash
set -e

SCRIPT_HOME="$( cd "$( dirname "$0" )" && pwd )"
EXPERIMENT_NAME=$1


for dir in /vagrant/experiments/$EXPERIMENT_NAME/analytics/*/
do
	cd $dir &&
	image_name=${PWD##*/} && # to assign to a variable
	echo "Building $image_name from $dir" &&
	docker build -t $image_name .
done
