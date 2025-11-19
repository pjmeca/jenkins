# pjmeca/jenkins: A Jenkins Image with Docker CLI + Preinstalled Plugins

[![GitHub Repo stars](https://img.shields.io/github/stars/pjmeca/jenkins?style=flat&logo=github&label=Star%20this%20repo!)](https://github.com/pjmeca/jenkins)
[![Docker Image Version (tag)](https://img.shields.io/docker/v/pjmeca/jenkins/latest?logo=docker)](https://hub.docker.com/r/pjmeca/jenkins)

A custom Jenkins image based on `jenkins/jenkins:latest` that includes:

* **Docker CLI installed**, allowing Jenkins to run `docker build`, `docker run`, etc.
* **Essential preinstalled plugins** (Git, GitHub, Pipeline, Matrix Auth, Email, Theme Manager, etc.).
* **Ready for CI/CD pipelines** that build and publish Docker images automatically.

This image is ideal for environments where Jenkins needs to interact with Docker without extra configuration.

---

## 🚀 Features

* Based on the official `jenkins/jenkins` image.
* Docker installed automatically via the official script (`get.docker.com`).
* The `jenkins` user is added to the `docker` group.
* Plugins loaded from a `plugins.txt` file.
* Ready to be used as a base for automated CI/CD pipelines.

---

## 📦 Included Plugins

The plugin list is managed in `plugins.txt`. Key plugins include:

* Git / Git Client
* GitHub + GitHub Branch Source
* Pipeline (all core components)
* Credentials + SSH Credentials
* Theme Manager
* Matrix Auth
* Metrics
* Apache HTTP Components
* JSON / GSON APIs

You can easily add or remove plugins by modifying `plugins.txt`.

---

## 🛠 Usage

### Build locally

```bash
docker build -t <your-tag> .
```

### Run with Docker

```bash
docker run -p 8080:8080 -p 50000:50000 <your-tag>
```

### Run with Docker Compose (example)

```yaml
services:
  jenkins:
    image: pjmeca/jenkins
    privileged: true
    user: root
    container_name: jenkins
    restart: unless-stopped
    ports:
      - 8080:8080       # Change this (optional)
      - 50000:50000     # Change this (optional)
    volumes:
      - /opt/docker:/opt/docker:ro
      - /var/run/docker.sock:/var/run/docker.sock
      - /usr/bin/docker:/usr/bin/docker
      - /store/your/jenkins/home:/var/jenkins_home # Change this
```

> This compose example runs Jenkins as root with Docker access, mapping the Docker socket and binaries for building images inside pipelines. Ports are mapped to your host, and persistent storage is configured under `/store/your/jenkins/home`.