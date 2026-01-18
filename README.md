
# SSL Certificate Expiry Checker

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

git clone https://github.com/kaloqnnikolov26-maker/SSL_cert_check


docker build -t SSL_cert_check .

docker run --rm SSL_cert_check

