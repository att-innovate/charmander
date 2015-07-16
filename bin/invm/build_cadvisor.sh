#/bin/bash
set -e

DIR=$PWD

CADVISOR_DIR=/vagrant/cadvisor/heapster

export PATH=$PATH:/usr/local/go/bin:$DIR/bin
export GOPATH=$DIR

go get -u github.com/tools/godep

mkdir -p $DIR/src/github.com/att-innovate/
cd $DIR/src/github.com/att-innovate/
rm -rf charmander-heapster

git clone https://github.com/att-innovate/charmander-heapster.git
cd charmander-heapster
godep restore
go install -a github.com/att-innovate/charmander-heapster
cp $DIR/bin/charmander-heapster $CADVISOR_DIR
cd $CADVISOR_DIR &&
    image_name="heapster" &&
	echo "Building $image_name" &&
	docker build -t $image_name .