FROM progrium/busybox

RUN opkg-install curl ca-certificates bash libstdcpp zlib

ENV JAVA_HOME /usr/jdk1.8.0_25
ENV SPARK_BINARY_RELEASE 1.1.0-bin-cdh4

RUN curl \
  --silent \
  --location \
  --retry 3 \
  --cacert /etc/ssl/certs/GeoTrust_Global_CA.crt \
  --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
  "http://download.oracle.com/otn-pub/java/jdk/8u25-b17/jdk-8u25-linux-x64.tar.gz" \
    | gunzip \
    | tar x -C /usr/ \
    && ln -s $JAVA_HOME /usr/java \
    && rm -rf $JAVA_HOME/src.zip $JAVA_HOME/javafx-src.zip $JAVA_HOME/man

ENV PATH $PATH:$JAVA_HOME/bin

RUN curl \
  --silent \
  --location \
  --retry 3 \
  --insecure \
  https://d3kbcqa49mib13.cloudfront.net/spark-$SPARK_BINARY_RELEASE.tgz \
    | gunzip \
    | tar x -C /usr/ \
  && ln -s /usr/spark-$SPARK_BINARY_RELEASE /usr/spark

ENV SPARK_HOME /usr/spark-$SPARK_BINARY_RELEASE
ENV PATH $PATH:$SPARK_HOME/bin:/usr/python/bin/

RUN sed 's/^\(log4j.rootCategory=\)INFO\(, console\)$/\1ERROR\2/' \
  $SPARK_HOME/conf/log4j.properties.template \
  > $SPARK_HOME/conf/log4j.properties

RUN curl \
  --silent \
  --location \
  --retry 3 \
  --insecure \
  https://dl.bintray.com/sbt/native-packages/sbt/0.13.7/sbt-0.13.7.tgz \
    | gunzip \
    | tar x -C /usr/

ENV PATH $PATH:/usr/sbt/bin

RUN sbt -batch


