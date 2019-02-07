# JENKINS on Windows Server Core

This repository contains Dockerfiles of Jenkins for Docker's for Windows automated build published to the public Docker Hub Registry. 
The repository contains images for Master and Slave.

#### Jenkins Master
Master is a base installation of Jenkins and Git configured in the image

In order to save configurations between exits attach volume to c:/jenkins when starting container.

#### Jenkins Slave
Slave is optimized for MSbuild and has a list of predefined software:
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

1. Install Docker.
2. Download automated build from public Docker Hub Registry: 
``` sh
docker pull asmagin/jenkins-on-windowsservercore
```

*Alternatively, you can build an image from Dockerfile:*
``` sh
docker build -t="asmagin/jenkins-on-windowsservercore" "https://github.com/asmagin/jenkins-on-windowsservercore.git#master:master"

# or

docker build -t="asmagin/jenkins-on-windowsservercore" "https://github.com/asmagin/jenkins-on-windowsservercore.git#master:slave"
```

## Usage

* Run Jenkins Master
``` sh
docker run -it --rm asmagin/jenkins-on-windowsservercore -v c:/hostfolder:c:/jenkins
```

* Run Jenkins Slave
``` sh
docker run -it --rm asmagin/jenkins-on-windowsservercore:slave -c "java -jar c:/jenkins/slave.jar -jnlpUrl <master url> -secret <your secret>"
```

## Issues
Git clone does not work in Windows Docker container in mounted host volume folder: 
- [https://github.com/git-for-windows/git/issues/1007](https://github.com/git-for-windows/git/issues/1007)
