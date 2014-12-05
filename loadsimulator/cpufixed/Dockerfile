FROM busybox:ubuntu-14.04
MAINTAINER Charmander

ADD cpufixed /usr/bin/cpufixed
RUN chmod +x /usr/bin/cpufixed

ENTRYPOINT ["/usr/bin/cpufixed"]
