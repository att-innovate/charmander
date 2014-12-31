FROM phusion/baseimage:0.9.14

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -qq
RUN apt-get -y install git wget

# No need for ssh server
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

# Install Java
ENV JAVA_HOME /usr/jdk1.8.0_25
ENV SPARK_BINARY_RELEASE 1.2.0-bin-cdh4

RUN cd /tmp \
    && wget \
    --no-check-certificate \
    --no-cookies \
    --header "Cookie: oraclelicense=accept-securebackup-cookie" \
    --progress=bar:force \
    download.oracle.com/otn-pub/java/jdk/8u25-b17/jdk-8u25-linux-x64.tar.gz \
    && tar -xvf jdk-8u25-linux-x64.tar.gz -C /usr/ \
    && ln -s $JAVA_HOME /usr/java \
    && rm -rf $JAVA_HOME/src.zip $JAVA_HOME/javafx-src.zip $JAVA_HOME/man

ENV PATH $PATH:$JAVA_HOME/bin

# Install sbt
RUN cd /tmp \
    && wget \
    --no-check-certificate \
    --no-cookies \
    --progress=bar:force \
    https://dl.bintray.com/sbt/native-packages/sbt/0.13.7/sbt-0.13.7.tgz \
    && tar -xvf sbt-0.13.7.tgz -C /usr/ \
    && /usr/sbt/bin/sbt -batch

ENV PATH $PATH:/usr/sbt/bin

# Install IPython3
RUN apt-get -y install python3-pip libzmq-dev

ENV IPYTHON_COMMIT 4e49a837589c49d1576136cdbc65fe2efba1eb7c

RUN git clone --recursive --depth 1 --single-branch https://github.com/ipython/ipython.git \
    && cd ipython \
    && git checkout $IPYTHON_COMMIT
RUN cd ipython && pip3 install -e ".[notebook]"

RUN mkdir /etc/service/ipython3notebook
ADD files/ipython3notebook.sh /etc/service/ipython3notebook/run

RUN ipython3 profile create

RUN mkdir /notebooks
ADD notebooks/* /notebooks/
EXPOSE 8888


# Install Spark-Kernel
ENV SPARKKERNEL_COMMIT b2550136da17cc4a9c86b0411e82e72f27e58562

RUN git clone --recursive --depth 1 --single-branch https://github.com/ibm-et/spark-kernel.git \
    && cd /spark-kernel \
    && git checkout $SPARKKERNEL_COMMIT \
    && sbt compile \
    && sbt kernel/pack \
    && cd kernel/target/pack \
    && make install

RUN mkdir -p $HOME/.ipython/kernels/spark
ADD files/kernel.json $HOME/.ipython/kernels/spark/

RUN mkdir -p $HOME/.ipython/profile_default/static/custom/
ADD files/custom.js $HOME/.ipython/profile_default/static/custom/

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
