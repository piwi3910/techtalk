# Logging on Docker

In this episode we will look at dockers logging capabilities and how we can extend it to centralized logging

## Local logging
the first option is the build in docker logs command

```docker logs containername```

example:

```docker logs plex```

```
Starting Plex Media Server.
[cont-finish.d] executing container finish scripts...
[cont-finish.d] done.
[s6-finish] syncing disks.
[s6-finish] sending all processes the TERM signal.
Critical: libusb_init failed
[s6-finish] sending all processes the KILL signal and exiting.
[s6-init] making user provided files available at /var/run/s6/etc...exited 0.
[s6-init] ensuring user provided files have correct perms...exited 0.
[fix-attrs.d] applying ownership & permissions fixes...
[fix-attrs.d] done.
[cont-init.d] executing container initialization scripts...
[cont-init.d] 40-plex-first-run: executing...
[cont-init.d] 40-plex-first-run: exited 0.
[cont-init.d] 45-plex-hw-transcode-and-connected-tuner: executing...
[cont-init.d] 45-plex-hw-transcode-and-connected-tuner: exited 0.
[cont-init.d] 50-plex-update: executing...
[cont-init.d] 50-plex-update: exited 0.
[cont-init.d] done.
[services.d] starting services
[services.d] done.
Starting Plex Media Server.
```

## Centralized Logging
docker has several logging plugins:

https://docs.docker.com/config/containers/logging/configure/

however when you are not using docker enterprise -> configuring centralized logging via any other plugin will disable using ```docker log``` command

```
none            No logs are available for the container and docker logs does not return any output.
local	        Logs are stored in a custom format designed for minimal overhead.
json-file	The logs are formatted as JSON. The default logging driver for Docker.
syslog	        Writes logging messages to the syslog facility. The syslog daemon must be running on the host machine.
journald	Writes log messages to journald. The journald daemon must be running on the host machine.
gelf	        Writes log messages to a Graylog Extended Log Format (GELF) endpoint such as Graylog or Logstash.
fluentd	        Writes log messages to fluentd (forward input). The fluentd daemon must be running on the host machine.
awslogs	        Writes log messages to Amazon CloudWatch Logs.
splunk	        Writes log messages to splunk using the HTTP Event Collector.
etwlogs	        Writes log messages as Event Tracing for Windows (ETW) events. Only available on Windows platforms.
gcplogs	        Writes log messages to Google Cloud Platform (GCP) Logging.
logentries	Writes log messages to Rapid7 Logentries.
```

### per container logging options
if you only want to centralize logging for some specific containers you can run them with the logging driver options:

```
docker run \ 
--log-driver syslog --log-opt syslog-address=udp://192.168.0.35:514 \
alpine echo hello world
```

--log-driver: specified the driver to use in our case syslog

--log-opt: specifies configuration parameters, in our case the syslog destination

each driver has its own list of configuration parameters:

https://docs.docker.com/config/containers/logging/syslog/

### per engine default logging configuration

edit ```/etc/docker/daemon.json```

example:

```
{
  "log-driver": "syslog",
  "log-opts": {
    "syslog-address": "udp://192.168.0.35:514",
    "tag": "{{.Name}}"
  }
}
```

here i set the default logging location to syslog and configure the destination. I also add a tag to the syslog output to include the name of the container for ease of reading later on.

```service docker restart```

### Caveat
```
Any container started before these changes will not start logging to the central location until you recreate them
starting and stopping them is NOT enough!!! The logging settings are applied on container creation, not runtime.
```

example:
```
docker inspect plex |grep LogConfig -A1

            "LogConfig": {
                "Type": "json-file",
```
```
docker inspect airsonic |grep LogConfig -A1

            "LogConfig": {
                "Type": "syslog",
```

