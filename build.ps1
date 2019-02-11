Clear-Host

$ErrorActionPreference = 'Continue'

# Note: run clean-up
docker rm $(docker ps -a -q)
docker rmi $(docker images -f dangling=true -q)

$ErrorActionPreference = 'Stop'

docker build -t asmagin/jenkins-on-windowsservercore              .\master
docker build -t asmagin/jenkins-on-windowsservercore:slave        .\slave

$JENKINS_VERSION = "2.46.1"

docker build --build-arg JENKINS_VERSION=$JENKINS_VERSION -t asmagin/jenkins-on-windowsservercore:$JENKINS_VERSION             .\master
docker build -t asmagin/jenkins-on-windowsservercore:$JENKINS_VERSION-slave       .\slave