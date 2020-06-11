FROM ubuntu:20.04

LABEL maintainer="Pascal Watteel"

ENV DEBIAN_FRONTEND noninteractive

RUN apt update -y && apt upgrade -y && apt install openjdk-8-jre-headless wget -y && apt-get clean autoclean && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /srv && wget https://launcher.mojang.com/v1/objects/bb2b6b1aefcd70dfd1892149ac3a215f6c636b07/server.jar -O /srv/server.jar

RUN cd /srv && java -Xms1024M -Xmx1024M -jar server.jar nogui