# DevOps Build Pipeline

This repository demonstrates a simple DevOps workflow for a React application using Docker, Jenkins, and Docker Hub. It includes automation for building, pushing, and deploying Docker images based on branch names.


## Project Overview

- **Frontend:** React app served via Nginx in a Docker container.
- **CI/CD:** Jenkins pipeline automates build, push, and deployment.
- **Container Registry:** Docker Hub.

---

## Folder Structure

```
.
├── build.sh             # Script to build Docker images
├── deploy.sh            # Script to deploy Docker containers
├── Dockerfile           # Docker image definition for React app
├── docker-compose.yml   # Local orchestration for development
├── Jenkinsfile          # Jenkins pipeline definition
├── README.md            # Project documentation
└── ...                  # React app source code and other files
```

---

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) installed
- [Jenkins](https://www.jenkins.io/doc/book/installing/) server (with Docker installed on the agent)
- [Git](https://git-scm.com/)
- Docker Hub account

---

## Getting Started

1. **Clone the repository:**

   ```sh
   git clone https://github.com/dharineesh16/devops-build.git
   cd devops-build
   ```

2. **Build and run locally:**

   ```sh
   docker-compose up --build
   ```

   The React app will be available at [http://localhost](http://localhost).

---

## CI/CD Pipeline

The Jenkins pipeline (`Jenkinsfile`) performs the following:

1. **Checkout:** Clones the repository for the current branch.
2. **Build Docker Image:** Builds a Docker image using `build.sh` for `dev` or `main` branches.
3. **Push to Docker Hub:** Pushes the image to Docker Hub using credentials stored in Jenkins.
4. **Deploy Application:** Runs the container on the server, mapping ports based on the branch.

**Branch Mapping:**

| Branch | Docker Image Tag         | Container Name    | Port Mapping   |
|--------|-------------------------|-------------------|---------------|
| dev    | dharineesh01/dev:latest | react-app-dev     | 3001:3000     |
| main   | dharineesh01/prod:latest| react-app-prod    | 3002:3000     |

---

## Local Development

- **Start the app:**

  ```sh
  docker-compose up --build
  ```

- **Stop the app:**

  ```sh
  docker-compose down
  ```

---

## Scripts

- **Build Docker Image:**

  ```sh
  ./build.sh dev    # For development branch
  ./build.sh main   # For main/production branch
  ```

- **Deploy Docker Container:**

  ```sh
  ./deploy.sh dev
  ./deploy.sh main
  ```

---

## Environment Variables

- Docker Hub credentials are managed via Jenkins credentials (ID: `Credentials`).
- Update `DEV_IMAGE` and `PROD_IMAGE` in the `Jenkinsfile` as needed.

# Application Url: http://52.66.8.81/
# Jenkins Url: http://13.201.12.206:8080/
# Prometheus Url: http://52.66.8.81:9090/
# Grafana Url: http://52.66.8.81:3000/
