FROM debian:stretch

ARG HOST_UID=1000

ADD install.sh /tmp/install.sh
RUN /tmp/install.sh
