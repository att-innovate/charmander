#/bin/bash
set -e

DIR=$PWD
UPSTART=/etc/init/charmander-scheduler.conf

export PATH=$PATH:/usr/local/go/bin
export GOPATH=$DIR

if [ -e $UPSTART ]; then
    if ( initctl status charmander-scheduler | grep start ); then
        initctl stop charmander-scheduler
    fi
fi

go get -u github.com/att-innovate/charmander-scheduler
go install -a github.com/att-innovate/charmander-scheduler
cp $DIR/bin/charmander-scheduler /usr/local/bin/

if [ -e $UPSTART ]; then
	initctl start charmander-scheduler
else
    cp /vagrant/bin/invm/charmander-scheduler.conf /etc/init/
	initctl start charmander-scheduler
fi