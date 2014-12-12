FROM busybox:ubuntu-14.04
MAINTAINER Charmander

ADD containerresolver /usr/bin/containerresolver
RUN chmod +x /usr/bin/containerresolver

VOLUME [ "/containers" ]

ENTRYPOINT ["/usr/bin/containerresolver"]
