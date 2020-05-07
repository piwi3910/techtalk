# DevOps in a box
### intro
In this episode we wil lbe looking into how to create a full DevOps infrastructure to build,
 host and run Docker containers and Applications on top of Docker and Synology.
 
 It's a continuation of our episode 4, where we added Portainer on Docker and Synology in the docker Series
 
 ### Infra description
 We will be using and building a full stack DevOps infra with the following components:
 
 * Docker on Synology: Container Engine
 * Portainer: Docker Admin GUI and Docker-compose Provisioner
 * Traefik: Reverse proxy and SSL (letsencrypt)
 * Gitea: git server and source controle for all our code and docker files
 * Jenkins / BlueOcean: automation pipelines and CI/CD orchestrator
 * Sonatype Nexus: artifact store and Container registry
 
 additionally we will be configuring Nexus as a passthrough proxy so that we can cache any docker hub images.
 We will finish it all up, by creating a jenkins pipeline split in 3 phases:
 
 * Phase 1: Building
 1. get our code from gitea
 2. Build our Dockerfile
 3. Upload our Docker container to our Nexus Registry as 'testing'
 
 * Phase 2: Testing
 1. get our container from the registry with tag 'testing'
 2. run it on docker
 3. test it
 4. Upload our Docker container to our Nexus Registry as 'prod'
 
 * Phase3: deployment
 1. get our container from the registry with tag 'prod'
 2. deploy it on docker
 3. test our deployment
 4. notify
 
 