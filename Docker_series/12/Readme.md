# Docker-compose

## What is docker-compose

``Compose is a tool for defining and running multi-container Docker applications. With Compose, you use a YAML file to configure your application’s services. Then, with a single command, you create and start all the services from your configuration``

## Use cases

* Development
* automated testing
* single dockerhost, multiple containers

## difference with Dockerfile

Dockerfile defines how the container will be build (created).

Compose defines how the container will be run.

* docker run
* docker volume
* docker network

...all these typical docker commands get replaced by a compose file.

## Compose versions and references

Compose exists in multiple versions.

Syntax is fairly backwards compatible, but you have to check what version your docker engine supports.
Version 2 is currently the most universal working version.

latest reference [link](https://docs.docker.com/compose/compose-file/)

## Examples

### Example 1

    Basic compose syntax

### Example 2

    Using a .env file and substitute

### Example 3

    how to use bind mounts

### Example 4

    networks

## Compose commands

``docker-compose config``
checks the compose file to be valid and displays the content

``docker-compose up``

runs your compose file, but in the foreground

``docker-compose up -d``
same as above but now puts it in the background (deamonize)

``docker-compose stop``
stops all containers

``docker-compose start``
start all already created containers

``docker-compose down``
removes all containers, volumes and networks

``docker-compose rm``
removes all already stopped containers

``docker-compose pull``
pulls a new version of the image

``docker-compose restart``
restart all containers

``docker-compose restart wordpress``
restart only 1 service

## advanced compose commands

``docker-compose up -d --force-recreate``
Recreate containers even if their configuration and image haven't changed

``docker-compose up -d --remove-orphans``
Remove containers for services not defined in the Compose file

``docker-compose down --rmi all``
removes all containers,volumes and networks but also remove the downloaded images
