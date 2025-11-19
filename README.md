# Jenkins Image with Docker CLI + Preinstalled Plugins

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

Build locally:

```bash
docker build -t <your-tag> .
```

Run:

```bash
docker run -p 8080:8080 -p 50000:50000 <your-tag>
```
