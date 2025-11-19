FROM jenkins/jenkins

USER root

RUN apt-get update && \
    apt-get install -y curl sudo && \
    curl -fsSL https://get.docker.com | sh && \
    usermod -aG docker jenkins

USER jenkins

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt

RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt
