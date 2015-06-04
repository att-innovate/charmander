FROM busybox:ubuntu-14.04
MAINTAINER Charmander

ADD containerresolver /usr/bin/tasknameresolverapi
RUN chmod +x /usr/bin/tasknameresolverapi

VOLUME [ "/containers" ]

ENTRYPOINT ["/usr/bin/tasknameresolverapi"]
