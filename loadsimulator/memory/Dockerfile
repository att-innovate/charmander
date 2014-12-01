# Memory Load Simulator

FROM ubuntu
MAINTAINER Theodora Chu

# Get python installed
RUN apt-get update
RUN apt-get install -y python

RUN mkdir /prog
ADD sim_mem.py /prog/
ADD sim_mem_inner.py /prog/
RUN chmod +x /prog/sim_mem.py
RUN chmod +x /prog/sim_mem_inner.py
