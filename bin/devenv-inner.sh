#/bin/bash
set -e

DIR="$( cd "$( dirname "$0" )" && pwd )"
APPS=${APPS:-/mnt/apps}
HOST_NAME="devenv1"
ZK_HOST="172.31.0.11"

stop(){
	echo "Stopping all docker containers:"
	docker ps
	ids=`docker ps | tail -n +2 |cut -d ' ' -f 1`
	echo $ids | xargs docker stop
	echo $ids | xargs docker rm
}

start(){
	echo "Starting all docker containers:"

	mkdir -p $APPS/redis/data
	mkdir -p $APPS/redis/logs
	REDIS=$(docker run \
		--detach=true \
		--publish=6379:6379 \
		--publish=8081:8081 \
		--memory=400m \
		--cpu-shares=100 \
		--volume=$APPS/redis/data:/data \
		--volume=$APPS/redis/logs:/logs \
		--hostname=$HOST_NAME \
		--name=redis \
		docker.registry.foundry:80/charmander-redis)
	echo "Started REDIS in container $REDIS"

	mkdir -p $APPS/hbase/data
	mkdir -p $APPS/hbase/logs
	HBASE=$(docker run \
		--detach=true \
		--publish=16000:16000 \
		--publish=16010:16010 \
		--publish=16020:16020 \
		--publish=16030:16030 \
		--memory=600m \
		--cpu-shares=100 \
		--volume=$APPS/hbase/data:/data \
		--volume=$APPS/hbase/logs:/logs \
		--hostname=$HOST_NAME \
		--name=hbase \
		--env ZOOKEEPER_PORT_2181_TCP_ADDR=$ZK_HOST \
		docker.registry.foundry:80/charmander-hbase)
	echo "Started HBASE in container $HBASE"

	mkdir -p $APPS/opentsdb/logs
	OPENTSDB=$(docker run \
		--detach=true \
		--publish=4242:4242 \
		--memory=600m \
		--cpu-shares=100 \
		--volume=$APPS/opentsdb/logs:/logs \
		--hostname=$HOST_NAME \
		--name=opentsdb \
		--env ZOOKEEPER_PORT_2181_TCP_ADDR=$ZK_HOST \
		--link=hbase:hbase \
		docker.registry.foundry:80/charmander-opentsdb)
	echo "Started OPENTSDB in container $OPENTSDB"

	CADVISOR=$(docker run \
		--detach=true \
		--publish=8070:8080 \
		--memory=60m \
		--volume=/var/run:/var/run:rw \
		--volume=/sys:/sys:ro \
		--volume=/var/lib/docker/:/var/lib/docker:ro \
		--name=cadvisor \
		google/cadvisor:latest)
	echo "Started CADVISOR in container $CADVISOR"

	sleep 1

}

init(){
	docker pull docker.registry.foundry:80/charmander-redis
	docker pull docker.registry.foundry:80/charmander-hbase
	docker pull docker.registry.foundry:80/charmander-opentsdb
}

case "$1" in
	start)
		start
		;;
	stop)
		stop
		;;
	init)
		init
		;;
	status)
		docker ps
		;;
	logs)
		docker logs "$2"
		;;
	rm)
		docker rm "$2"
		;;
	*)
		echo $"Usage: $0 {ssh|start|stop|init|status|logs|rm}"
		RETVAL=1
esac
