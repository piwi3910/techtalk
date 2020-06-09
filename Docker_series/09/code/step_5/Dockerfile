FROM ubuntu:20.04

LABEL maintainer="Pascal Watteel"

ENV DEBIAN_FRONTEND noninteractive

RUN apt update -y && apt upgrade -y && apt install openjdk-8-jre-headless wget -y && apt-get clean autoclean && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

RUN useradd -m -d /srv minecraft
RUN mkdir -p /srv && chown -R minecraft:minecraft /srv
ADD start.sh /start.sh
RUN chmod +x /start.sh && chown minecraft:minecraft /start.sh

VOLUME /srv
EXPOSE 25565

USER minecraft
ENTRYPOINT [ "/start.sh" ]