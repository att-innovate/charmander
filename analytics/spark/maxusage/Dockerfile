FROM spark

ENV MAXUSAGE_DIR /maxusage

RUN mkdir -p $MAXUSAGE_DIR/src

ADD src/ $MAXUSAGE_DIR/src
ADD maxusage.sbt $MAXUSAGE_DIR/

RUN cd $MAXUSAGE_DIR && sbt package

ENTRYPOINT cd $MAXUSAGE_DIR && spark-submit --class MaxUsage --master local[*] target/scala-2.10/max-usage_2.10-1.0.jar



