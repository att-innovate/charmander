FROM busybox:ubuntu-14.04
MAINTAINER Charmander

ADD stress /usr/bin/stress
RUN chmod +x /usr/bin/stress

ENTRYPOINT ["/usr/bin/stress"]
