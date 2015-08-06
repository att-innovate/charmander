#/bin/bash
set -e

DIR=$PWD

EXPERIMENT_NAME=$1
TRAFFIC_NAME=$2

export GOPATH=$DIR/go

mkdir -p $GOPATH/src
mkdir -p $GOPATH/bin
mkdir -p $GOPATH/pkg

export PATH=$PATH:/usr/local/go/bin

CHARMANDER_SRC_ROOT=$GOPATH/src/github.com/charmander
rm -rf $CHARMANDER_SRC_ROOT/$EXPERIMENT_NAME/$TRAFFIC_NAME
mkdir -p $CHARMANDER_SRC_ROOT/$EXPERIMENT_NAME/$TRAFFIC_NAME

cp -r /vagrant/experiments/$EXPERIMENT_NAME/traffic/$TRAFFIC_NAME/* $CHARMANDER_SRC_ROOT/$EXPERIMENT_NAME/$TRAFFIC_NAME

go get github.com/charmander/$EXPERIMENT_NAME/$TRAFFIC_NAME
go install github.com/charmander/$EXPERIMENT_NAME/$TRAFFIC_NAME

rm -rf /vagrant/experiments/$EXPERIMENT_NAME/traffic/$TRAFFIC_NAME/$TRAFFIC_NAME
cp $GOPATH/bin/$TRAFFIC_NAME /vagrant/experiments/$EXPERIMENT_NAME/traffic/$TRAFFIC_NAME/