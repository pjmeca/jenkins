FROM jenkins/jenkins
LABEL org.label-schema.name="pjmeca/jenkins" \
    org.label-schema.description="Jenkins with Docker-in-Docker support and plugin bundle" \
    org.label-schema.url="https://hub.docker.com/r/pjmeca/jenkins" \
    org.label-schema.vcs-url="https://github.com/pjmeca/jenkins" \
    org.label-schema.schema-version="1.0.0-rc.1" \
    maintainer="pjmeca"
USER root
RUN apt-get update && \
    apt-get install -y curl sudo && \
    curl -fsSL https://get.docker.com | sh && \
    usermod -aG docker jenkins
USER jenkins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt
