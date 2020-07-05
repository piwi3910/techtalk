# Cross building x86_64 on arm64 with buildx and visa versa

## examples of arm64

* raspberry pi 4 with ubuntu
* raspberry pi 4 with [raspberry pi OS 64-bit](https://www.raspberrypi.org/forums/viewtopic.php?t=275370)
* [new Apple macs with arm64](https://www.macrumors.com/guide/apple-silicon/)

## installing cross building support

```apt install qemu binfmt-support qemu-user-static```

This command would be enough on a x86_64. However this would still not allow us to build for x86_64 on an arm64 as only arm, mips and others are available.
This is because to build pc code on arm we need full HW emulation.

note: **You can not build 64bit on an non 64bit CPU**

**Only on arm64: ```apt install qemu-system-x86```

This will install the needed full system emulation to build PC code on arm.

verify it is enabled:

```update-binfmts --display |grep x86```

output:

```
qemu-x86_64 (enabled):
 interpreter = /usr/bin/qemu-x86_64-static
```

## Building

```export DOCKER_CLI_EXPERIMENTAL=enabled```

check the current default builder
```docker buildx ls```

output on x86_64:

```
NAME/NODE DRIVER/ENDPOINT STATUS  PLATFORMS
default * docker
  default default         running linux/amd64, linux/386
```
output on arm64:

```
NAME/NODE DRIVER/ENDPOINT STATUS  PLATFORMS
default * docker
  default default         running linux/arm64, linux/arm/v7, linux/arm/v6
```

As you see for the default builder only the sub-architectures are available, no cross building.
So lets create our own builder. 


create a new builder for the architectures you want:
```docker buildx create --name mybuilder --platform linux/arm,linux/arm64,linux/amd64```

```docker buildx use mybuilder```

check the multi arch are enabled

```docker buildx inspect```

output:

```
Name:   mybuilder
Driver: docker-container

Nodes:
Name:      mybuilder0
Endpoint:  npipe:////./pipe/docker_engine
Status:    inactive
Platforms: linux/arm/v7, linux/arm64, linux/amd64
```

bootstrap the buildkit builder

```docker buildx inspect --bootstrap```

output:

```
[+] Building 0.0s (1/1) FINISHED
 => [internal] booting buildkit                                                                                                          8.8s
 => => pulling image moby/buildkit:buildx-stable-1                                                                                       8.3s
 => => creating container buildx_buildkit_mybuilder0                                                                                     0.6s
Name:   mybuilder
Driver: docker-container

Nodes:
Name:      mybuilder0
Endpoint:  npipe:////./pipe/docker_engine
Status:    running
Platforms: linux/arm/v7, linux/arm64, linux/amd64, linux/ppc64le, linux/s390x, linux/386, linux/arm/v6
```

**DON'T FORGET TO LOGIN TO DOCKERHUB BEFORE BUILDING AND PUSHING**

build our container:

```docker buildx build --platform linux/arm,linux/arm64,linux/amd64 -t piwi3910/hello . --push```

output:

```

[+] Building 71.0s (12/12) FINISHED
 => [internal] load build definition from Dockerfile                                                                                                                                                                   1.0s
 => => transferring dockerfile: 269B                                                                                                                                                                                   0.0s
 => [internal] load .dockerignore                                                                                                                                                                                      1.1s
 => => transferring context: 2B                                                                                                                                                                                        0.0s
 => [internal] load metadata for docker.io/library/alpine:latest                                                                                                                                                      10.1s
 => [internal] load build context                                                                                                                                                                                      0.1s
 => => transferring context: 230B                                                                                                                                                                                      0.0s
 => [builder 1/5] FROM docker.io/library/alpine@sha256:185518070891758909c9f839cf4ca393ee977ac378609f700f60a771a2dfe321                                                                                                7.9s
 => => resolve docker.io/library/alpine@sha256:185518070891758909c9f839cf4ca393ee977ac378609f700f60a771a2dfe321                                                                                                        0.0s
 => => sha256:3b3f647d2d99cac772ed64c4791e5d9b750dd5fe0b25db653ec4976f7b72837c 528B / 528B                                                                                                                             0.0s
 => => sha256:b538f80385f9b48122e3da068c932a96ea5018afa3c7be79da00437414bd18cd 2.71MB / 2.71MB                                                                                                                         3.8s
 => => sha256:62ee0e9f84408099149bdf3873554feebd1ee199daa1e0e80b840414cd5c4c9b 1.51kB / 1.51kB                                                                                                                         0.0s
 => => sha256:185518070891758909c9f839cf4ca393ee977ac378609f700f60a771a2dfe321 1.64kB / 1.64kB                                                                                                                         0.0s
 => => unpacking docker.io/library/alpine@sha256:185518070891758909c9f839cf4ca393ee977ac378609f700f60a771a2dfe321                                                                                                      0.7s
 => [stage-1 2/3] WORKDIR /home                                                                                                                                                                                        1.0s
 => [builder 2/5] RUN apk add build-base                                                                                                                                                                              40.2s
 => [builder 3/5] WORKDIR /home                                                                                                                                                                                        1.1s
 => [builder 4/5] COPY hello.c .                                                                                                                                                                                       0.6s
 => [builder 5/5] RUN gcc "-DARCH="`uname -a`"" hello.c -o hello                                                                                                                                                       0.5s
 => [stage-1 3/3] COPY --from=builder /home/hello .                                                                                                                                                                    0.3s
 => exporting to image                                                                                                                                                                                                 9.1s
 => => exporting layers                                                                                                                                                                                                0.5s
 => => exporting manifest sha256:401e6e74ac775675467d39269beeccaf4ba0ee593d58bfb728fa17c279b2d22f                                                                                                                      0.1s
 => => exporting config sha256:824609c90abb71bf32a64e049a0be8836cd80babbb98f09847e201ba3bbba829                                                                                                                        0.1s
 => => pushing layers                                                                                                                                                                                                  6.4s
 => => pushing manifest for docker.io/piwi3910/hello:latest 
```
