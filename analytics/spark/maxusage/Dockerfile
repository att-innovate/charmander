FROM javascala
MAINTAINER Charmander

# Install Spark
ENV SPARK_BINARY_RELEASE 1.2.0-bin-cdh4
ENV SPARK_HOME /usr/spark-$SPARK_BINARY_RELEASE

RUN curl \
  --silent \
  --location \
  --retry 3 \
  --insecure \
  https://d3kbcqa49mib13.cloudfront.net/spark-$SPARK_BINARY_RELEASE.tgz \
    | gunzip \
    | tar x -C /usr/ \
  && ln -s /usr/spark-$SPARK_BINARY_RELEASE /usr/spark


RUN sed 's/^\(log4j.rootCategory=\)INFO\(, console\)$/\1ERROR\2/' \
  $SPARK_HOME/conf/log4j.properties.template \
  > $SPARK_HOME/conf/log4j.properties

ENV PATH $PATH:$SPARK_HOME/bin:/usr/python/bin/


# Install maxusage
ENV MAXUSAGE_DIR /maxusage

RUN mkdir -p $MAXUSAGE_DIR/src

ADD src/ $MAXUSAGE_DIR/src
ADD build.sbt $MAXUSAGE_DIR/

RUN cd $MAXUSAGE_DIR && sbt package


# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT cd $MAXUSAGE_DIR && spark-submit --class MaxUsage --master local[*] target/scala-2.10/max-usage_2.10-1.0.jar



