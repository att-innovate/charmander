FROM phusion/baseimage:0.9.16

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -qq
RUN apt-get -y install git wget

# No need for ssh server
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh
