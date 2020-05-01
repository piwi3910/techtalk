# Top 15 Docker commands for beginners

## 1) docker --version

```
root@docker01:~# docker --version
Docker version 19.03.8, build afacb8b7f0
root@docker01:~#
```

## 2) docker pull

```
root@docker01:~# docker pull ubuntu:latest
latest: Pulling from library/ubuntu
d51af753c3d3: Pull complete
fc878cd0a91c: Pull complete
6154df8ff988: Pull complete
fee5db0ff82f: Pull complete
Digest: sha256:747d2dbbaaee995098c9792d99bd333c6783ce56150d1b11e333bbceed5c54d7
Status: Downloaded newer image for ubuntu:latest
docker.io/library/ubuntu:latest
```

## 3) docker run

```
root@docker01:~# docker run -it -d ubuntu:latest
ece220a53e21d8032ace85c1971cc09de61eccd746a98393133ad88440b7ffb6
```
## 4) docker ps

```
root@docker01:~# docker ps
CONTAINER ID        IMAGE                    COMMAND             CREATED              STATUS              PORTS               NAMES
ece220a53e21        ubuntu:latest            "/bin/bash"         About a minute ago   Up About a minute                       ecstatic_burnell
```

## 5) docker ps -a

```
CONTAINER ID        IMAGE                    COMMAND                  CREATED             STATUS                          PORTS               NAMES
ece220a53e21        ubuntu:latest            "/bin/bash"              2 minutes ago       Up 2 minutes                                        ecstatic_burnell
df4f45eb972d        wordpress:latest         "docker-entrypoint.s…"   11 days ago         Exited (0) About a minute ago                       wordpress_wordpress.1.dg5mghb4wbhnomawmc78dpmrc
5cf671bb4976        portainer/agent:latest   "./agent"                11 days ago         Up 11 days                                          portainer_agent.raee18c3snsfhsv8bjkegzid3.xqqoqxq2bpj9dr6bfmezh4fr9
```

## 6) docker exec

```
root@docker01:~# docker exec -it ece220a53e21 bash
root@ece220a53e21:/#
```

## 7) docker stop
```
root@docker01:~# docker stop ece220a53e21
ece220a53e21
```

## 8) docker kill

```
root@docker01:~# docker kill ece220a53e21
ece220a53e21
```

## 9) docker commit

```
root@docker01:~# docker commit ece220a53e21 piwi3910/ubuntu-techtalk
sha256:261038311235f3dc70b126e8430663fc1e6d3fac4f0ed148177ca250e93bf24c
```

## 10) docker login

```
root@docker01:~# docker login
Login with your Docker ID to push and pull images from Docker Hub. If you don't have a Docker ID, head over to https://hub.docker.com to create one.
Username: piwi3910
Password:
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded
```

## 11) docker push

```
root@docker01:~# docker push piwi3910/ubuntu-techtalk
The push refers to repository [docker.io/piwi3910/ubuntu-techtalk]
b4555cfd62f6: Pushed
8891751e0a17: Mounted from library/ubuntu
2a19bd70fcd4: Mounted from library/ubuntu
9e53fd489559: Mounted from library/ubuntu
7789f1a3d4e9: Mounted from library/ubuntu
latest: digest: sha256:604d96dc8de248d7e76f64e5a40704179e9abe07e90229f8648c1b603c4ac813 size: 1359
```

## 12) docker images

```
root@docker01:~# docker images
REPOSITORY                 TAG                 IMAGE ID            CREATED             SIZE
piwi3910/ubuntu-techtalk   latest              261038311235        2 minutes ago       73.9MB
ubuntu                     latest              1d622ef86b13        7 days ago          73.9MB
wordpress                  <none>              895c3d7568db        13 days ago         540MB
mysql                      <none>              273c7fcf9499        13 days ago         455MB
wordpress                  <none>              0d205d4886fe        4 weeks ago         540MB
portainer/portainer        <none>              2869fc110bf7        6 weeks ago         78.6MB
portainer/agent            <none>              5b96aa0902cb        6 months ago        13.9MB
```

## 13) docker rm
```
root@docker01:~# docker ps -a
CONTAINER ID        IMAGE                    COMMAND                  CREATED             STATUS                       PORTS               NAMES
ece220a53e21        ubuntu:latest            "/bin/bash"              9 minutes ago       Exited (137) 4 minutes ago                       ecstatic_burnell
df4f45eb972d        wordpress:latest         "docker-entrypoint.s…"   11 days ago         Exited (0) 8 minutes ago                         wordpress_wordpress.1.dg5mghb4wbhnomawmc78dpmrc
5cf671bb4976        portainer/agent:latest   "./agent"                11 days ago         Up 11 days                                       portainer_agent.raee18c3snsfhsv8bjkegzid3.xqqoqxq2bpj9dr6bfmezh4fr9
root@docker01:~# docker rm ece220a53e21
ece220a53e21
```

## 14) docker rmi

```
root@docker01:~# docker images
REPOSITORY                 TAG                 IMAGE ID            CREATED             SIZE
piwi3910/ubuntu-techtalk   latest              261038311235        4 minutes ago       73.9MB
ubuntu                     latest              1d622ef86b13        7 days ago          73.9MB
wordpress                  <none>              895c3d7568db        13 days ago         540MB
mysql                      <none>              273c7fcf9499        13 days ago         455MB
wordpress                  <none>              0d205d4886fe        4 weeks ago         540MB
portainer/portainer        <none>              2869fc110bf7        6 weeks ago         78.6MB
portainer/agent            <none>              5b96aa0902cb        6 months ago        13.9MB
root@docker01:~# docker rmi piwi3910/ubuntu-techtalk
Untagged: piwi3910/ubuntu-techtalk:latest
Untagged: piwi3910/ubuntu-techtalk@sha256:604d96dc8de248d7e76f64e5a40704179e9abe07e90229f8648c1b603c4ac813
Deleted: sha256:261038311235f3dc70b126e8430663fc1e6d3fac4f0ed148177ca250e93bf24c
Deleted: sha256:3d7e0e34c3effd992728d5ca852ca12024f952bc9974dd2ae2e07d11db77ba1d
```

## 15) docker build



