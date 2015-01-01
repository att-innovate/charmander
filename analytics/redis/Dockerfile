FROM analyticsbase
MAINTAINER Charmander

RUN apt-get install -y build-essential make gcc

ENV REDISVERSION 2.8.11

RUN wget \
    --no-cookies \
    --progress=bar:force \
    http://download.redis.io/releases/redis-$REDISVERSION.tar.gz \
    && tar xzf redis-$REDISVERSION.tar.gz \
    && cd redis-$REDISVERSION \
    && make \
    && cd .. \
    && ln -sfn redis-$REDISVERSION redis

#VOLUME [ "/data" ]
RUN mkdir /data

ADD files/redis.conf redis.conf

EXPOSE 6379

ENV NODEVERSION v0.10.30
RUN wget \
    --no-cookies \
    --progress=bar:force \
    http://nodejs.org/dist/$NODEVERSION/node-$NODEVERSION-linux-x64.tar.gz \
    && tar -xvf node-$NODEVERSION-linux-x64.tar.gz \
    && mv node-$NODEVERSION-linux-x64 /opt/node \
    && cd /usr/local/bin && ln -s /opt/node/bin/* . \
    && npm install -g redis-commander

EXPOSE 8081

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT redis/src/redis-server redis.conf & redis-commander
