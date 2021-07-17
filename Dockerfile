#########################
######## alpine #########
#########################
# FROM alpine:latest
# RUN apk add --update \
#     libevent-dev \
#     libpthread-stubs

#########################
###### rockylinux #######
#########################
# FROM rockylinux/rockylinux:latest
# RUN dnf install -y libevent-devel

# If you want other distribute linux, then you check package *.so file version.
# When *.o executed, then check lld which same *.so in binary file.

FROM ubuntu:20.04
RUN apt update -y && apt install -y libevent-dev

ADD build/server.o /opt

RUN chmod +x /opt/server.o && \
    touch /opt/log.txt

EXPOSE 8080

RUN ls -ahl /opt/server.o

# Keep container running for Test.
# CMD exec /bin/sh -c "trap : TERM INT; sleep infinity & wait"
ENTRYPOINT [ "./opt/server.o" ]
