FROM phusion/baseimage:0.9.9

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -qq
RUN apt-get install -y wget

ENV INFLUXDB_VERSION 0.8.7

RUN wget https://s3.amazonaws.com/influxdb/influxdb_${INFLUXDB_VERSION}_amd64.deb && \
  dpkg -i influxdb_${INFLUXDB_VERSION}_amd64.deb && \
  rm influxdb_${INFLUXDB_VERSION}_amd64.deb

VOLUME [ "/data" ]
VOLUME [ "/log" ]

# Admin server
EXPOSE 8083
# HTTP API
EXPOSE 8086

ADD files/config.toml config.toml

CMD /usr/bin/influxdb -config=config.toml
