FROM pcp-docker-containers.bintray.io/pcp-base:latest
MAINTAINER Henry Chang

RUN dnf -y install supervisor pcp pcp-collector pcp-webapi && dnf clean all

RUN . /etc/pcp.conf && echo "-A" >> $PCP_PMCDOPTIONS_PATH
RUN . /etc/pcp.conf && echo OPTIONS=\"\$OPTIONS -S\" >> $PCP_PMWEBDOPTIONS_PATH

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY ./supervisord.conf /etc/supervisord.conf

EXPOSE 44321 44323

ENV PCP_CONTAINER_IMAGE pcp-all
ENV NAME pcp-all
ENV IMAGE pcp-all

LABEL RUN docker run -d --privileged --net=host --pid=host --ipc=host -v /sys:/sys:ro -v /etc/localtime:/etc/localtime:ro -v /var/lib/docker:/var/lib/docker:ro -v /run:/run -v /var/log:/var/log -v /dev/log:/dev/log --name=pcp-all pcp-all

ENV PATH /usr/share/pcp/lib:/usr/libexec/pcp/bin:$PATH

CMD ["/usr/bin/supervisord"]
