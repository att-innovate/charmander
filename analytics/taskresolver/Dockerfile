FROM busybox:ubuntu-14.04
MAINTAINER Charmander

ADD taskresolver /usr/bin/taskresolver
RUN chmod +x /usr/bin/taskresolver

VOLUME [ "/containers" ]

ENTRYPOINT ["/usr/bin/taskresolver"]
