FROM analyticsbase
MAINTAINER Charmander

ENV INFLUXDB_VERSION 0.8.8

RUN wget \
    --no-check-certificate \
    --no-cookies \
    --progress=bar:force \
    https://s3.amazonaws.com/influxdb/influxdb_${INFLUXDB_VERSION}_amd64.deb \
    && dpkg -i influxdb_${INFLUXDB_VERSION}_amd64.deb \
    && rm influxdb_${INFLUXDB_VERSION}_amd64.deb

ADD files/config.toml config.toml

#VOLUME [ "/data" ]
RUN mkdir /data
VOLUME [ "/log" ]

# Admin server
EXPOSE 8083
# HTTP API
EXPOSE 8086

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT /usr/bin/influxdb -config=config.toml
