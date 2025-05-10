# Infini-Quest DevOps Challenge

This repository contains my solution for the **Infini-Quest** DevOps simulation challenge. 
It includes provisioning a Fedora CoreOS VM, containerizing a Python Flask inventory app with Prometheus monitoring, and deploying it with full automation and observability.

---

##Project Structure

| Component          | Description                             |
|-------------------|-----------------------------------------|
| `app.py`          | Flask API with CRUD and /metrics endpoint |
| `Dockerfile`      | Production-grade image using Python 3.11 |
| `docker-compose.yml` | Brings up Flask app, Prometheus, Node Exporter |
| `prometheus.yml`  | Configures Prometheus scrape jobs       |
| `deploy.sh`       | Automates the deployment and validation |

---

### Prerequisites

- Docker + Docker Compose
- A Linux or Ubuntu-based environment (tested on Ubuntu 22.04)
- Fedora CoreOS VM (optional for full simulation)

### Run the Stack:

```bash
chmod +x deploy.sh
./deploy.sh

