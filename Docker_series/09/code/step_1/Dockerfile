FROM ubuntu:20.04

LABEL maintainer="Pascal Watteel"

RUN apt update -y
RUN apt upgrade -y
RUN apt install openjdk-8-jre-headless -y
RUN apt install wget -y
RUN mkdir -p /srv
RUN cd /srv
RUN wget https://launcher.mojang.com/v1/objects/bb2b6b1aefcd70dfd1892149ac3a215f6c636b07/server.jar
RUN java -Xms1024M -Xmx1024M -jar server.jar nogui