# # SSL Certificate Expiry Checker

A portable Bash-based tool to check SSL/TLS certificate expiration dates for a list of websites.

## Features
- Reads hostnames from a config file
- Displays certificate expiry dates
- Warns when certificates are near expiration
- Runs locally, in Docker, or Kubernetes

## Requirements
- Docker (recommended)
- Kubernetes / Minikube (optional)

## Local Docker Usage

```bash
git clone https://github.com/<your-username>/cert-expiry-checker.git
cd cert-expiry-checker

docker build -t cert-expiry-checker .
docker run --rm cert-expiry-checker
