FROM javascala
MAINTAINER Charmander

# Install IPython3
RUN apt-get -y install python3-pip libzmq-dev

ENV IPYTHON_COMMIT 4e49a837589c49d1576136cdbc65fe2efba1eb7c

RUN git clone --recursive --single-branch https://github.com/ipython/ipython.git \
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
