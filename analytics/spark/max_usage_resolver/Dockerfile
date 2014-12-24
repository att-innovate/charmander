FROM spark

RUN mkdir -p /maxusageresolver/src

ADD src/ /maxusageresolver/src
ADD simple.sbt /maxusageresolver/

RUN cd /maxusageresolver && sbt package

ENTRYPOINT cd /maxusageresolver && spark-submit --class SimpleApp --master local[*] target/scala-2.10/simple-project_2.10-1.0.jar



