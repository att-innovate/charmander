#/bin/bash
set -e

DIR=$PWD

VECTOR_DIR=/vagrant/vector/vector
DATACOLLECTOR_DIR=/vagrant/vector/datacollector

cd $VECTOR_DIR &&
    image_name="vector" &&
	echo "Building $image_name" &&
	docker build -t $image_name .

export PATH=$PATH:/usr/local/go/bin:$DIR/bin
export GOPATH=$DIR

go get -u github.com/tools/godep

mkdir -p $DIR/src/github.com/att-innovate/
cd $DIR/src/github.com/att-innovate/
rm -rf charmander-datacollector

git clone https://github.com/att-innovate/charmander-datacollector.git
cd charmander-datacollector
godep restore
go install -a github.com/att-innovate/charmander-datacollector
cp $DIR/bin/charmander-datacollector $DATACOLLECTOR_DIR
cd $DATACOLLECTOR_DIR &&
    image_name="datacollector" &&
	echo "Building $image_name" &&
	docker build -t $image_name .