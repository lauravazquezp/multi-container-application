# Multi-Container Application Deployment Pipeline

This project was developed as part of the [roadmap.sh Multi-container Service](https://roadmap.sh/projects/multi-container-service) challenge. It demonstrates a complete end-to-end engineering workflow, including containerization, Infrastructure as Code (IaC), configuration management, and Continuous Deployment (CD).

## Project Overview
The primary objective of this project is to manage a multi-container architecture in a production-ready environment. The system consists of a Node.js REST API and a MongoDB database, provisioned on a virtualized remote server with an automated deployment pipeline.

## Technical Stack
* **Application Framework:** Node.js, Express.js
* **Database:** MongoDB
* **Data Modeling:** Mongoose ORM
* **Containerization:** Docker, Docker Compose
* **Infrastructure:** Terraform (HCL), Multipass (Ubuntu)
* **Configuration:** Ansible (YAML)
* **Automation:** GitHub Actions (Self-hosted Runner)


## Requirements Implementation

### 1. Application Architecture and Containerization
The API service manages a todo list via standard RESTful endpoints (`GET`, `POST`, `PUT`, `DELETE`). 
* **Persistent Storage:** Data persistence is achieved using Docker volumes, ensuring MongoDB data is retained across container restarts or updates.
* **Orchestration:** A `docker-compose.yml` file defines the networking and service dependencies, allowing the API and database to communicate via the internal Docker network.

### 2. Infrastructure as Code (IaC) and Configuration
The project utilizes a two-tier approach to infrastructure:
* **Terraform:** Automates the lifecycle of the remote server. It handles the initial provisioning of the VM, CPU/Memory allocation, and initial SSH key injection via cloud-init.
* **Ansible:** Executed post-provisioning to configure the server environment. This includes updating system packages, installing the Docker engine, and ensuring the correct directory structures and permissions are in place for the application.

### 3. Automated CI/CD Pipeline
A Continuous Deployment pipeline is implemented using GitHub Actions.
* **Self-Hosted Runner:** Due to the local-virtualization nature of the server, a self-hosted runner is utilized to bridge the GitHub repository with the production VM.
* **Pipeline Logic:** Upon a push to the main branch, the runner executes a sequence that pulls the latest source code and triggers the Ansible playbook to perform an idempotent update of the Docker services.

---

## Operational Commands

### Local Development
To run the environment locally for testing:
```bash
make install      # Install dependencies
make docker-up    # Spin up local containers
