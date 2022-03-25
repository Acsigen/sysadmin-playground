# Kubernetes

## ToC

- [Prerequisites](#prerequisites)
- [Introduction](#introduction)
- [Create Kubernetes cluster locally](#)
- [Create and scale deployments](#)
- [Build custom docker image and deploy](#)
- [Create services and deployment using YAML](#)
- [Connect different deployments together](#)
- [Change container runtime from Docker to CRI-O](#)
- [Sources](#sources)

## Prerequisites

Kubernetes is a container orchestration system.

Kubernetes supports the following container runtimes:

- Docker
- CRI-OI
- containerd

Kubernetes are also found as K8S, or k8s (there are 8 characters between k and s in kubernetes)

## Introduction

### Basics

K8s can be used for the following actions:

- Automatic deployment
- Load Distribution
- Auto-scaling
- Monitorinc and health Check
- Replacement of failed containers

**Pod** is the smallest unit in the k8s world. Containers are created inside the pod.

A pod can contain:

- Containers
- Shared Volumes
- Shared IP Address

Commonly, there is only one container in a single pod.

Anatomy of k8s:

- Cluster
  - Node (baremetal or virutal server)
    - Pod
      - Container

**Multiple nodes will not automatically form a cluster. You need to group them manually.**

Usually there is a *master node* and multiple *worker nodes*.

The master node runs only system pods, the deployment takes place only in worker nodes.

Each node contains multiple services:

- kubelet
- kube-proxy
- Container Runtime (Docker, CRI-O, containerd)

The master node also contains:

- **API Server** service which makes communications between the nodes possible
- **Scheduler** is responsible for load distribution
- **Kube Controller Manager** controlls what happends on each node of the cluster
- **Cloud Controller Manager** interacts with cloud service providers
- **etcd** stores all logs of the operation of k8s cluster (key-value pairs format)
- **DNS** service to connect deployments by names

The command line tool to connect to a cluster is `kubectl`.

### Dependencies and Installation

## Sources

- [FreeCodeCamp YouTube Channel](https://youtu.be/d6WC5n9G_sM?t=1047)
