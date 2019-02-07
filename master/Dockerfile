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
    [Net.ServicePointManager]::SecurityProtocol = "tls12, tls11"; \
    Invoke-WebRequest "https://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/$env:JENKINS_VERSION/jenkins-war-$env:JENKINS_VERSION.war" -OutFile "c:/jenkins.war" -UseBasicParsing

# Note: Install Git
RUN \
    if (-not($env:GIT_VERSION)) { $env:GIT_VERSION = '2.12.2'; \
        [Environment]::SetEnvironmentVariable('GIT_VERSION', $env:GIT_VERSION, 'Machine') }; \
    New-Item -ItemType Directory -Force -Path 'c:/git'; \
    [Net.ServicePointManager]::SecurityProtocol = "tls12, tls11"; \
    Invoke-WebRequest "https://github.com/git-for-windows/git/releases/download/v$env:GIT_VERSION.windows.1/Git-$env:GIT_VERSION-64-bit.exe" -OutFile "$env:TEMP/git.exe" -UseBasicParsing; \
    Start-Process -FilePath "$env:TEMP/git.exe" -ArgumentList '/VERYSILENT', '/NORESTART', '/NOCANCEL', '/SP-', '/DIR="c:/git"' -PassThru | Wait-Process; \
    dir "$env:TEMP" | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue

COPY scripts /scripts

# for main web interface:
EXPOSE 8080

# will be used by attached slave agents:
EXPOSE 50000

CMD [ "powershell", "c:/scripts/startup.ps1" ]
