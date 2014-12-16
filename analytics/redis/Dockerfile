FROM phusion/baseimage:0.9.9

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -qq
RUN apt-get install -y git curl build-essential make gcc wget

ENV REDISVERSION 2.8.11
RUN wget http://download.redis.io/releases/redis-$REDISVERSION.tar.gz
RUN tar xzf redis-$REDISVERSION.tar.gz
RUN cd redis-$REDISVERSION && make
RUN ln -sfn redis-$REDISVERSION redis

#VOLUME [ "/data" ]
RUN mkdir /data

ADD files/redis.conf redis.conf

EXPOSE 6379

ENV NODEVERSION v0.10.30
RUN wget http://nodejs.org/dist/$NODEVERSION/node-$NODEVERSION-linux-x64.tar.gz
RUN tar -xvf node-$NODEVERSION-linux-x64.tar.gz
RUN mv node-$NODEVERSION-linux-x64 /opt/node
RUN cd /usr/local/bin && ln -s /opt/node/bin/* .
RUN npm install -g redis-commander

EXPOSE 8081

ENTRYPOINT redis/src/redis-server redis.conf & redis-commander
