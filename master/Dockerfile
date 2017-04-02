FROM openjdk:windowsservercore

MAINTAINER Alex Smagin

# $ProgressPreference will disable download progress info and speed-up download
SHELL ["powershell", "-NoProfile", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue'; "]

ENV JENKINS_HOME c:/jenkins

# Jenkins home directory is a volume, so configuration and build history
# can be persisted and survive image upgrades
VOLUME c:/jenkins

# jenkins version being bundled in this docker image
ENV JENKINS_VERSION 2.46.1

# Can be used to customize where jenkins.war get downloaded from
ENV JENKINS_URL https://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/${JENKINS_VERSION}/jenkins-war-${JENKINS_VERSION}.war

ADD ${JENKINS_URL} /jenkins.war

ENV JENKINS_UC https://updates.jenkins.io

# for main web interface:
EXPOSE 8080

# will be used by attached slave agents:
EXPOSE 50000

CMD [ "java", "-jar", "c:/jenkins.war" ]