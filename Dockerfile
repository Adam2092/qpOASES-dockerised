FROM qpoases-base:test as Builder
MAINTAINER Yue Kang yuek@chalmers.se
ADD ./src /opt/sources/src
ADD CMakeLists.txt /opt/sources
WORKDIR /opt/sources
RUN mkdir build && cd build && cmake .. && make && \
    cp ./test /tmp

FROM alpine:3.10.2 as Deployment
MAINTAINER Yue Kang yuek@chalmers.se
RUN apk update && apk add libstdc++
WORKDIR /usr/bin
COPY --from=Builder /tmp/* .
ENTRYPOINT ["/usr/bin/test"]