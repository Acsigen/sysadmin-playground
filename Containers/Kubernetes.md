# Kubernetes

## ToC

- [Prerequisites](#prerequisites)
- [Introduction](#introduction)
- [Create Kubernetes cluster locally](#create-kubernetes-cluster-locally)
- [Create and scale deployments](#create-and-scale-deployments)
- [Create services and deployment using YAML](#create-services-and-deployment-using-yaml)
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

**For this guide we use an alias `k="kubectl"` to make it easier to type.**

## Create Kubernetes cluster locally

To start the cluster you need to use the following command: `minikube start --driver=<driver_name>`

For `--driver` please check minikube documentation for compatible drivers (e.g. VirtualBox, Docker, Hyper-V, VMWare, none).

**Make sure that you have the driver packages installed on your system.**

You can access minikube node using SSH by running `minikube ip` to get the IP of the minikube and then run `ssh docker@<minikube_ip>`. The default password is `tcuser`.

### Basic commands

|Command|Action|
|---|---|
|`k cluster-info`|List the cluster informations|
|`k get nodes`|List the nodes. If you use *minikube* it will list only one|
|`k get pods`|List the pods. Append `-o wide` to get more info|
|`k get namespaces`|Will list the namespaces|
|`k get pods --namespace=kube-system`|List pods that are running in *kube-system* namespace|
|`k run nginx --image=nginx`|Run an Nginx pod named *nginx*|
|`k describe pod nginx`|Get more info about *nginx* pod created earlier|
|`k delete pod nginx`|Delete *nginx* pod|

## Create and scale deployments

The most common way to create multiple pods, for scaling purposes, is by using deployments.

To create an *nginx* deployment:

```bash
# Create deployment
k create deployment nginx-deployment --image=nginx

# Get info about deployment
k get deployments

# Get info about the pods
k get pods

# Get the details about the deployment
k describe deployment nginx-deployment
```

In this casem the pods are managed by the deployment.

### GUI/Web interface

Kubernetes dashboard provides a web interface to manage kubernetes.

In minikube it is quite easy to deploy, just use `minikube dashboard`.

For other environtments it might be more difficult because you need to secure access to the dashboard.

**Do not use dashboard on the public internet!**

### Scale the deployment

Scale out (up):

```bash
# Scale the deployment
k scale deployment nginx-deployment --replicas=5

# This will return 5 pods
k get pods
```

Scale in (down):

```bash
# To scale in, just change the replicas number
k scale deployment nginx-deployment --replicas=3

# This willr eturn 3 pods
k get pods
```

### Port mapping

Pods get their IPs dinamically, and those IP addresses are accessible only from inside the node.

To connect to specific deployments using specific IP addresses you need to create services and there are different options available:

- Create cluster IP (it will be assigned to a specific deployment)
- Create external IP address by:
  - Expose the deployment to the IP address of the node
  - Use a load balancer (**most common solution**)

#### Create service to expose a specific port with a *cluster IP*

This is usually used to allow services to talk to eachother inside a cluster.

```bash
# Expose internal port 80 of the container to external port 8080
k expose deployment nginx-deployment --port=8080 --target-port=80

# List the services. This will list the cluster IP and port that will be available only inside the cluster
k get services

# Get more details about the service
k describe service nginx-deployment
```

#### Create service to expose a specific port with a *NodePort*

This will map the port from the pod to the node IP, thus, making it accessible through the node address.

This option wil bind the desired pod port to a random port on the node.

```bash
k expose deployment nginx-deployment --type=NodePort --port=80
```

#### Create service to expose a specific port with *LoadBalancer*

This creates a service and uses the load balancer type to expose the port.

```bash
k expose deployment nginx-deployment --type=LoadBalancer --port=80
```

### Update deployment

By default, the strategy type is *RollingUpdate*. This means that **new pods will be created with the updated image while the current pods are still running**.

Set an image for a particular deployment:

```bash
# Set a new image for nginx-deployment deployment for nginx-deployment pods
k set image deployment nginx-deployment nginx-deployment=nginx/nginx:2.0
```

Always run the following command. This will return status messages related to the update:

```bash
k rollout status deployment nginx-deployment
```

#### Rollback

Well, sometimes things won't go as planned and you need to undo the update.

You can do this two ways. You can either use a replica set and rollback to the previous revision:

```bash
# Inspect the history of the deployment
k rollout history nginx-deployment

# Apply the rollback
k rollout undo nginx-deployment --to-revision=<x>
```

Or you can use an older image and just "update" it to the previous version of the image:

```bash
k set image deployment nginx-deployment nginx-deployment=nginx/nginx
```
 
### Clean-up

Delete pods, deployment, and service:

```bash
# Delete pod
k delete pod nginx-sfhskdjhfk-dsds

# Delete deployment
k delete deployment nginx-deployment

# Delete service
k delete service nginx-deployment
```

## Create services and deployment using YAML

Kubernetes documentation will help you build more complex configuration files.

For this case, the example below is more than enough.

Create two separate `.yaml` files to configure deployment and service:

- `deployment.yaml`
- `service.yaml`

In Visual Studio Code, the Kubernetes extension will help you create a deployment. Just type `deployment` and click on the suggestion. A template file will be generated automatically. Change it accordingly:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp
spec:
  selector:
    matchLabels:
      app: myapp
  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
      - name: myapp
        image: <Image>
        resources:
          limits:
            memory: "128Mi"
            cpu: "500m"
        ports:
        - containerPort: <Port>
```

It goes the same way for the service file:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: myapp
spec:
  selector:
    app: myapp
  ports:
  - port: <Port>
    targetPort: <Target Port>
```

Apply the YAML file:

```bash
k apply -f deployment.yaml
```

To delete deployments you can run `k delete -f deployment.yaml -f service.yaml`.

## Sources

- [FreeCodeCamp YouTube Channel](https://youtu.be/d6WC5n9G_sM?t=8879)
