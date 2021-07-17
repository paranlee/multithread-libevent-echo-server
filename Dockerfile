#########################
######## alpine #########
#########################
FROM alpine:latest
RUN apk add --no-cache --upgrade \
    clang \
    build-base \
    libevent-dev

#########################
###### rockylinux #######
#########################
# FROM rockylinux/rockylinux:latest
# RUN dnf install -y clang libevent-devel \
#     && dnf clean all \
#     && rm -rf /var/cache/yum

#########################
######## ubuntu #########
#########################
# FROM ubuntu:20.04
# RUN apt update -y \
#     && apt install -y clang \
#         libevent-dev  \
#     && rm -rf /var/lib/apt/lists/*

# If you want other distribute linux, then you check package *.so file version.
# When *.o executed, then check lld which same *.so in binary file.

WORKDIR /opt
RUN mkdir src
ADD src src

RUN clang -o server.o src/server.c src/workqueue.c -levent -lpthread && \
    rm -rf /opt/src && \
    apk del clang \
        build-base

EXPOSE 8080

# Keep container running for Test.
# CMD exec /bin/sh -c "trap : TERM INT; sleep infinity & wait"
ENTRYPOINT [ "./server.o" ]
