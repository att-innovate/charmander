FROM phusion/baseimage:0.9.17

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -qq
RUN apt-get -y install git wget

ENV GO_VERSION 1.5.3

RUN wget \
    --no-check-certificate \
    --no-cookies \
    --progress=bar:force \
    https://storage.googleapis.com/golang/go${GO_VERSION}.linux-amd64.tar.gz \
    && tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz \
    && export PATH=$PATH:/usr/local/go/bin \
    && rm go${GO_VERSION}.linux-amd64.tar.gz
                    
ENV PATH $PATH:/usr/local/go/bin
ENV GOPATH /tmp/go 
ENV PATH $PATH:/usr/local/go/bin:$GOPATH:$GOPATH/bin
RUN mkdir -p "/tmp/go/src" "/tmp/go/bin" 

ENV GOPATH /tmp/go

WORKDIR $GOPATH/src

RUN go get github.com/tools/godep
RUN go get gopkg.in/matryer/try.v1

RUN go get -d github.com/att-innovate/charmander-peekachu \
    && cd /tmp/go/src/github.com/att-innovate/charmander-peekachu \
    && sed -i.bak 's|v0.3.4|master|' Godeps/Godeps.json \
    && cd /tmp/go/src/github.com/att-innovate/charmander-peekachu \
    && godep restore 

WORKDIR /tmp/go/src/github.com/att-innovate/charmander-peekachu

CMD go run main/main.go -v=0 -logtostderr -config ./examples/config.json -torc false && tail -f dev/null


