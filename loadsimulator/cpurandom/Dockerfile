FROM busybox:ubuntu-14.04
MAINTAINER Charmander

ADD cpurandom /usr/bin/cpurandom
RUN chmod +x /usr/bin/cpurandom

ENTRYPOINT ["/usr/bin/cpurandom"]
