# Cross building with buildx and Docker for windows

```set DOCKER_CLI_EXPERIMENTAL=enabled```

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

[+] Building 44.2s (12/12) FINISHED
 => [internal] load .dockerignore                                                                                                        0.2s
 => => transferring context: 2B                                                                                                          0.0s
 => [internal] load build definition from Dockerfile                                                                                     0.2s
 => => transferring dockerfile: 280B                                                                                                     0.0s
 => [internal] load metadata for docker.io/library/alpine:latest                                                                         9.4s
 => [internal] load build context                                                                                                        0.1s
 => => transferring context: 231B                                                                                                        0.0s
 => [stage-1 1/3] FROM docker.io/library/alpine@sha256:185518070891758909c9f839cf4ca393ee977ac378609f700f60a771a2dfe321                  8.0s
 => => resolve docker.io/library/alpine@sha256:185518070891758909c9f839cf4ca393ee977ac378609f700f60a771a2dfe321                          0.0s
 => => sha256:185518070891758909c9f839cf4ca393ee977ac378609f700f60a771a2dfe321 1.64kB / 1.64kB                                           0.0s
 => => sha256:a15790640a6690aa1730c38cf0a440e2aa44aaca9b0e8931a9f2b0d7cc90fd65 528B / 528B                                               0.0s
 => => sha256:a24bb4013296f61e89ba57005a7b3e52274d8edd3ae2077d04395f806b63d83e 1.51kB / 1.51kB                                           0.0s
 => => sha256:df20fa9351a15782c64e6dddb2d4a6f50bf6d3688060a34c4014b0d9a752eb4c 2.80MB / 2.80MB                                           4.0s
 => => sha256:df20fa9351a15782c64e6dddb2d4a6f50bf6d3688060a34c4014b0d9a752eb4c 2.80MB / 2.80MB                                           4.0s
 => => unpacking docker.io/library/alpine@sha256:185518070891758909c9f839cf4ca393ee977ac378609f700f60a771a2dfe321                        0.2s
 => [builder 2/5] RUN apk add build-base                                                                                                16.5s
 => [stage-1 2/3] WORKDIR /home                                                                                                          0.2s
 => [builder 3/5] WORKDIR /home                                                                                                          0.1s
 => [builder 4/5] COPY hello.c .                                                                                                         0.1s
 => [builder 5/5] RUN gcc "-DARCH="`uname -a`"" hello.c -o hello                                                                         0.3s
 => [stage-1 3/3] COPY --from=builder /home/hello .                                                                                      0.1s
 => exporting to image                                                                                                                   9.4s
 => => exporting layers                                                                                                                  0.3s
 => => exporting manifest sha256:dd0ed42812a42961b96360518a8be1b895fcb247d6c3d317a093a3b655e18d81                                        0.0s
 => => exporting config sha256:668f888cd8fb26775234eb761352598caa2585320f016a242b0dc072e9b5d4a2                                          0.0s
 => => pushing layers                                                                                                                    6.9s
 => => pushing manifest for docker.io/piwi3910/hello:latest                                                                              2.1s
```
