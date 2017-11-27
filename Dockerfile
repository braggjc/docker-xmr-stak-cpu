FROM ubuntu:17.04

USER root

RUN set -ex ;
RUN apt update -qq ;
RUN apt install -y -qq libmicrohttpd-dev libssl-dev cmake build-essential libhwloc-dev;

RUN apt install -y -qq git

RUN git clone https://github.com/fireice-uk/xmr-stak-cpu.git
RUN ls -last
RUN cd xmr-stak-cpu && \
    cmake -DCMAKE_LINK_STATIC=ON . && \
    make install && \
    ls -last

COPY ./config.txt /xmr-stak-cpu/bin/
#RUN chmod 777 /xmr-stak-cpu/bin/config.txt

WORKDIR /xmr-stak-cpu/bin

ENTRYPOINT ["./xmr-stak-cpu"]
