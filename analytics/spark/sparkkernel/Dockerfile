FROM javascala
MAINTAINER Charmander

# Install IPython3
RUN apt-get -y install python3-pip libzmq-dev
RUN pip3 install ipython[notebook]==3.0.0

RUN mkdir /etc/service/ipython3notebook
ADD files/ipython3notebook.sh /etc/service/ipython3notebook/run

RUN ipython3 profile create

EXPOSE 8888


# Install Spark-Kernel
ENV SPARKKERNEL_COMMIT 09a30fbe8a9d3300342fb44d29bb02b7a3bcf945

RUN git clone --recursive --single-branch https://github.com/ibm-et/spark-kernel.git \
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

ADD files/charmander-utils_2.10-1.0.jar /root/local/kernel/current/lib/


# Install example notebooks
RUN mkdir /notebooks
ADD notebooks/* /notebooks/

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
