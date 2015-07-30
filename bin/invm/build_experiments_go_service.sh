#/bin/bash
set -e

DIR=$PWD

EXPERIMENT_NAME=$1
SERVICE_NAME=$2

export GOPATH=$DIR/go

mkdir -p $GOPATH/src
mkdir -p $GOPATH/bin
mkdir -p $GOPATH/pkg

export PATH=$PATH:/usr/local/go/bin

SERVICE_SRC_ROOT=$GOPATH/src/github.com/charmander
rm -rf $SERVICE_SRC_ROOT/$EXPERIMENT_NAME/$SERVICE_NAME
mkdir -p $SERVICE_SRC_ROOT/$EXPERIMENT_NAME/$SERVICE_NAME

cp -r /vagrant/experiments/$EXPERIMENT_NAME/services/$SERVICE_NAME/* $SERVICE_SRC_ROOT/$EXPERIMENT_NAME/$SERVICE_NAME

go get github.com/charmander/$EXPERIMENT_NAME/$SERVICE_NAME
go install github.com/charmander/$EXPERIMENT_NAME/$SERVICE_NAME

rm -rf /vagrant/experiments/$EXPERIMENT_NAME/services/$SERVICE_NAME/$SERVICE_NAME
cp $GOPATH/bin/$SERVICE_NAME /vagrant/experiments/$EXPERIMENT_NAME/services/$SERVICE_NAME/