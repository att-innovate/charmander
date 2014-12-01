FROM busybox:ubuntu-14.04
MAINTAINER Marcel

ADD crand /usr/bin/crand
RUN chmod +x /usr/bin/crand

ENTRYPOINT ["/usr/bin/crand"]
