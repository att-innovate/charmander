FROM docker.registry.foundry:80/charmander-oracle-java7

RUN apt-get install -y wget

RUN wget http://apache.osuosl.org/hbase/hbase-0.98.4/hbase-0.98.4-hadoop2-bin.tar.gz
RUN tar xzf hbase-0.98.4-hadoop2-bin.tar.gz
RUN ln -sfn hbase-0.98.4-hadoop2 hbase

ADD files/hbase-site.xml hbase/conf/hbase-site.xml
ADD files/log4j.properties hbase/conf/log4j.properties
ADD files/hbase-env.sh hbase/conf/hbase-env.sh
ADD files/start-hbase.sh hbase/bin/start-hbase.sh

ADD hbase-start.sh hbase/hbase-start.sh

VOLUME [ "/data" ]
VOLUME [ "/logs" ]

# hbase.master.port
EXPOSE 16000
# hbase.master.info.port
EXPOSE 16010
# hbase.regionserver.port
EXPOSE 16020
# hbase.regionserver.info.port
EXPOSE 16030

ENV JAVA_HOME /usr/lib/jvm/java-7-oracle

CMD ["hbase/hbase-start.sh"]






