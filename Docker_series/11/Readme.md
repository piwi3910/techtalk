# Multi-Arch Docker builds with buildkit and qemu

## Intro

In this episode we will focus on using an experimental feature of Docker to build Multi-arch containers. With Apple announcing their move to arm64 and the raspberry pi also moving to arm64 it's a perfect moment to discuss this.

## use cases

* Build containers on a fast pc for executing on raspberry pi, as buolding on raspberry pi would take to long
* Build containers on your pc for multiple users on arm or arm64 while you do not posses a arm or arm64
* use (future macs)[https://www.macrumors.com/guide/apple-silicon/] to build containers for normal pc's and servers or public clouds

example architectures:

* PC: amd64 or x86_64
* raspberry pi: arm or arm/7
* raspberry pi 4 with 64bit os: arm64
* current Mac: x86_64
* future Mac: arm64

you can build:

* arm64 to arm and x86_64
* x86_64 to arm and arm64

## Pre-requirement

Your builder must at least run docker version 19.03

## Links

* [Part1: Cross Building with Buildx and Docker for Windows](Readme_part1.md)
* [Part2: Building x86_64 on arm64 and visa versa](Readme_part2.md)

