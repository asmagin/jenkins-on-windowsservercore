# JENKINS on Windows Server Core

This repository contains Dockerfiles of Jenkins for Docker's for Windows automated build published to the public Docker Hub Registry. 
The repository contains images for MASTER and SLAVE.

#### MASTER
Master is a base installation of Jenkins and Git configured in the image

#### SLAVE
SLAVE is optimized for MSbuild and has a list of predefined software:
* ASP.NET v4.5 Framework & Web Features
* MSBuild v14
* Nuget
* Node JS v6.10.1
* JetBrains.ReSharper.CommandLineTools v2016.3
* Nunit Console Runner v3.6.1
* xUnit Console Runner v2.2.0

### Base Docker Image
[openjdk:windowsservercore](https://hub.docker.com/_/openjdk/)

## Installation

* Install Docker.

* Download automated build from public Docker Hub Registry: 
``` sh
docker pull asmagin/jenkins-on-windowsservercore
```

Alternatively, you can build an image from Dockerfile: 
``` sh
docker build -t="asmagin/jenkins-on-windowsservercore" github.com/asmagin/jenkins-on-windowsservercore/jenkins)
```

## Usage

* Run Jenkins Master
``` sh
docker run -it --rm asmagin/jenkins-on-windowsservercore
```

* Run Jenkins Master
``` sh
docker run -it --rm asmagin/jenkins-on-windowsservercore:slave
```