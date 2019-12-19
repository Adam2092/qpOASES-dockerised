FROM alpine:3.10.2 as BaseImage
MAINTAINER Yue Kang yuek@chalmers.se
RUN apk update && \
    apk --no-cache add \
        ca-certificates \
        cmake \
        g++ \
        make
ADD . /opt/sources
WORKDIR /opt/sources
RUN cd /opt/sources/qpOASES-3.2.1 && \
    make clean && cmake . && make && make install