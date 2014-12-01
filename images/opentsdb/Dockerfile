FROM docker.registry.foundry:80/charmander-oracle-java7

RUN apt-get install -y autoconf libtool gnuplot make gettext gettext-base git-core socat

# Get HBase Client
RUN wget http://apache.osuosl.org/hbase/hbase-0.98.4/hbase-0.98.4-hadoop2-bin.tar.gz
RUN tar xzf hbase-0.98.4-hadoop2-bin.tar.gz
RUN ln -sfn hbase-0.98.4-hadoop2 hbase

ADD files/hbase-site.xml hbase/conf/hbase-site.xml

# Get OpenTSDB
RUN git clone git://github.com/OpenTSDB/opentsdb.git
RUN cd opentsdb && ./build.sh

ADD opentsdb-start.sh opentsdb/opentsdb-start.sh
ADD files/opentsdb.conf opentsdb/opentsdb.conf

VOLUME [ "/logs" ]

EXPOSE 4242

ENV JAVA_HOME /usr/lib/jvm/java-7-oracle

CMD ["opentsdb/opentsdb-start.sh"]


