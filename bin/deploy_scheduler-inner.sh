#/bin/bash
set -e

DIR=$PWD
UPSTART=/etc/init/charmander-scheduler.conf

export PATH=$PATH:/usr/local/go/bin
export GOPATH=$DIR

if [ -e $UPSTART ]; then
	service charmander-scheduler stop
fi

go get -u github.com/att-innovate/charmander-scheduler
go install -a github.com/att-innovate/charmander-scheduler
cp $DIR/bin/charmander-scheduler /usr/local/bin/

if [ -e $UPSTART ]; then
	service charmander-scheduler start
else
    cp /vagrant/bin/charmander-scheduler.conf /etc/init/
	service charmander-scheduler start
fi