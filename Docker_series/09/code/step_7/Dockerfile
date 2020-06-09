FROM ubuntu:20.04

LABEL maintainer="Pascal Watteel" \
      name="my_minecraft_server" \
      version="1.0"

#set env variables
ENV DEBIAN_FRONTEND noninteractive

# Install packages
RUN apt update -y \
    && apt upgrade -y  \
    && apt install -y \
        openjdk-8-jre-headless \
        wget \
    && apt-get clean autoclean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# Add dedicated Minecraft user
RUN useradd -m -d /srv minecraft

# Add Entrypoint script
ADD start.sh /start.sh

# Create needed data dir and set the dedicated minecraft user as owner
RUN mkdir -p /srv \
    && chown -R minecraft:minecraft /srv
RUN chmod +x /start.sh \
    && chown minecraft:minecraft /start.sh

# Expose a volume so that minecraft server data is persistent
VOLUME /srv
# Minecraft port
EXPOSE 25565

#switch to the dedicated Minecraft user for entrypoint execution
USER minecraft
ENTRYPOINT [ "/start.sh" ]