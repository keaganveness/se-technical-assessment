# Systems Engineer Technical Assessment

## 1. Summary

This repository contains a containerized web application, deployed on a lightweight Kubernetes distribution (k3s) and fronted by an NGINX load balancer with basic caching and security controls.

The goal of this project is to demonstrate:

* Automated provisioning of a server
* Containerization of the application
* An orchestrated, scalable deployment
* Load balancing and caching at the edge
* Practical security hardening
* Clear documentation and reproducible steps

Everything in this repo works end-to-end against a fresh `Ubuntu 22.04` server.

You can see a live demo here: http://demo.keaganveness.com:30080

## 2. Repository Structure

```
├── README.md
├── provision.sh
├── deploy.sh
├── destroy.sh
├── app/
│   ├── index.js
│   └── Dockerfile
└── k8s/
    ├── namespace.yaml
    ├── app-deployment.yaml
    ├── app-service.yaml
    ├── nginx-configmap.yaml
    ├── nginx-deployment.yaml
    └── nginx-service.yaml
```

## 3. Architecture Overview

### 1) The Web Application

A simple Node.js HTTP server (provided in the assessment) that returns:

* The container hostname -> to demonstrate loadbalancing
* The server time -> to demonstrate caching

It runs inside Kubernetes as the `web-app` deployment using a ClusterIP service.

### 2) The k3s Kubernetes Cluster

A lightweight Kubernetes distribution. This is installed by the provisioning script (`provision.sh`) on the target server. k3s provides:

* Deployment scaling
* Pod restarts and health checks
* Service discovery
* Cluster networking 

### 3) The NGINX Load Balancer

This runs inside Kubernetes as the `nginx-lb` deployment and is exposed using a NodePort service on port `30080`. 

Nginx provides:

* Reverse proxying to the web-app service
* Load balancing across multiple web-app replicas
* Caching of HTML responses (with a 10 second TTL)
* Basic HTTP security headers

The deployment script (`deploy.sh`) installs the necessary Kubernetes manifests for the web application and NGINX load balancer.

## 4. Prerequisites

You will need a Linux server (it can be bare metal/VM/cloud) running:

* Ubuntu 22.04+
* Outbound internet access
* Sudo privileges

This deployment has been tested on an AWS Lightsail instance.

## 5. Provision the Server

Run the provisioning script from inside the repo's root to install k3s and configure kubectl:

```
chmod +x provision.sh
sudo ./provision.sh
```

Reload your shell or run:

```
source /etc/profile.d/k3s-kubectl.sh
```

Verify that the cluster is up and running:

```
kubectl get nodes
```

You should see one node in a `Ready` state.

## 6. Deploy the Application Stack

Run the deploy script from inside the repo's root:

```
chmod +x deploy.sh
./deploy.sh
```

This applies the Kubernetes manifests for:

* The `web-app` namespace
* The `web-app` deployment and service
* The `nginx-lb` deployment and service

Verify that everything is up and running:

```
kubectl -n webapp get pods,svc
```

You should see the following:

* A single `web-app-*` pod.
* A single `nginx-lb-*` pod.
* A ClusterIP `web-app` service.
* A NodePort `nginx-lb` service on port `30080`.

## 7. Accessing the Application

