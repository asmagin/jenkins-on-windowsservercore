FROM openjdk:windowsservercore

MAINTAINER Alex Smagin

# $ProgressPreference will disable download progress info and speed-up download
SHELL ["powershell", "-NoProfile", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue'; "]

# Note: Install Jenkins slave
RUN \
    # TODO: refactor with docker ENV after 1.4 release. 
    # jenkins version being bundled in this docker image
    if (-not($env:JENKINS_VERSION)) { $env:JENKINS_VERSION = '2.46.1'; \
        [Environment]::SetEnvironmentVariable('JENKINS_VERSION', $env:JENKINS_VERSION, 'Machine') }; \
    if (-not($env:JENKINS_HOME)) { $env:JENKINS_HOME = 'c:/jenkins'; \
        [Environment]::SetEnvironmentVariable('JENKINS_HOME', $env:JENKINS_HOME, 'Machine') }; \
    if (-not($env:JENKINS_UC)) { $env:JENKINS_UC = 'https://updates.jenkins.io'; \
        [Environment]::SetEnvironmentVariable('JENKINS_UC', $env:JENKINS_UC, 'Machine') }; \

    New-Item -ItemType Directory -Force -Path 'c:/jenkins'; \
    Invoke-WebRequest "https://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/$env:JENKINS_VERSION/jenkins-war-$env:JENKINS_VERSION.war" -OutFile "c:/jenkins.war" -UseBasicParsing

# for main web interface:
EXPOSE 8080

# will be used by attached slave agents:
EXPOSE 50000

CMD [ "java", "-jar", "c:/jenkins.war" ]