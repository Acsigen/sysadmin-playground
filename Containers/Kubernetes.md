# Kubernetes

## ToC

- [Prerequisites](#prerequisites)
- [Introduction](#introduction)
- [Create Kubernetes cluster locally](#create-kubernetes-cluster-locally)
- [Create and scale deployments](#create-and-scale-deployments)
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

Kubernetes are also known as K8S, or k8s (there are 8 characters between k and s in kubernetes)

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

To run k8s locally you need to install the following:

- `minikube` to run a single node cluster
- `kubectl` to manage the cluster

## Create Kubernetes cluster locally

To start the cluster you need to use the following command: `minikube start --driver=<driver_name>`

For `--driver` please check minikube documentation for compatible drivers (e.g. VirtualBox, Docker, Hyper-V, VMWare, none).

**Make sure that you have the driver packages installed on your system.**

You can access minikube node using SSH by running `minikube ip` to get the IP of the minikube and then run `ssh docker@<minikube_ip>`. The default password is `tcuser`.

### Basic commands

|Command|Action|
|---|---|
|`kubectl cluster-info`|List the cluster informations|
|`kubectl get nodes`|List the nodes. If you use *minikube* it will list only one|
|`kubectl get pods`|List the pods. Append `-o wide` to get more info|
|`kubectl get namespaces`|Will list the namespaces|
|`kubectl get pods --namespace=kube-system`|List pods that are running in *kube-system* namespace|
|`kubectl run nginx --image=nginx`|Run an Nginx pod named *nginx*|
|`kubectl describe pod nginx`|Get more info about *nginx* pod created earlier|
|`kubectl delete pod nginx`|Delete *nginx* pod|

## Create and scale deployments

## Sources

- [FreeCodeCamp YouTube Channel](https://youtu.be/d6WC5n9G_sM?t=3318)
