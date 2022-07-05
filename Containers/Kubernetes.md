# Kubernetes

## ToC

- [Prerequisites](#prerequisites)
- [Introduction](#introduction)
- [Create and scale deployments](#create-and-scale-deployments)
- [Create services, pods, and deployments using YAML](#create-services-pods-and-deployments-using-yaml)
- [Namespaces](#namespaces)
- [Networking](#networking)
- [Connect different deployments together](#connect-different-deployments-together)
- [Change container runtime from Docker to CRI-O](#change-container-runtime-from-docker-to-cri-o)
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

To run k8s locally you need to to use **microk8s** which is a *powerful, lightweight, reliable production-ready Kubernetes distribution* made by Canonical. The setup procedure is simple, just follow [these steps](https://microk8s.io/#install-microk8s).

**For this guide we use an alias `k="microk8s kubectl"` to make it easier to type.**

### Pods

**Pod** is the smallest unit in the k8s world. Containers are created inside the pod. A pod can run multiple containers withn a single namespace, exposed by a single IP address. Kubernetes doesn't manage containers directly, it manages containers through pods.

Although the standard is one container in a pod, multiple containers in a pod are used in specific cases such as logging and monitoring.

There is also the posibility to run *naked* pods, they are the pods that you can create directly through a definition file. Try to avoid these ones, they have many disadvantages (cannot be scaled, cannot be replaced automatically, etc.)

A pod contains:

- Containers
- Shared Volumes
- Shared IP Address

### Basic commands

|Command|Action|
|---|---|
|`k run nginx-abc-xyz --image=nginx`|Run an Nginx pod named *nginx-abc-xyz*|
|`k exec nginx-deployment-abc-xyz -- nslookup google.com`|Execute `nslookup google.com` command inside container|
|`k describe pod nginx-abc-xyz`|Get more info about *nginx-abc-xyz* pod created earlier|
|`k get pods`|List the pods. Append `-o wide` to get more info or `-o yaml` to get the yaml data. **Please specify the name of the pod and pipe it through `less` if you use `-o`, otherwise it will print a lot of data.**|
|`k get pods --namespace=kube-system`|List pods that are running in *kube-system* namespace|
|`k cluster-info`|List the cluster informations|
|`k get nodes`|List the nodes. If you use *microk8s* it will list only one|
|`k get namespaces`|Will list the namespaces. Also works with `k get ns`|
|`k get all --all-namespaces`|List all resources for all namespaces|
|`k delete pod nginx-abc-xyz`|Delete *nginx-abc-xyz* pod|

Just to clarify, ***namespaces** are a way to organize clusters into virtual sub-clusters, they can be helpful when different teams or projects share a Kubernetes cluster. Any number of namespaces are supported within a cluster, each logically separated from others but with the ability to communicate with each other.*

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

## Create services, pods, and deployments using YAML

### YAML Manifest file

Kubernetes documentation will help you build more complex configuration files.

A YAML Manifest file has the following structure:

- apiVersion: specifies which version of the API to use for this object
- kind: indicates the type of object (Deployment, Pod, Service, etc.)
- metadata: contains administrative information about the object
- spec: contains the specifics for the object

The *containers spec* requires different parts:

- name: name of container
- image: image used
- command: the command the container should run
- args: arguments that are used by the command
- env: environment variables that should be used by the container

**Use `kubectl explain` to get more information about the basic properties to build the YAML file.**

```bash
# Get info about pod properties
k explain pod

# Go deeper into the pod properties
k explain pod.spec

# Even more data
k explain --recursive pod.spec
```

### Basic YAML configuration

In Visual Studio Code, the Kubernetes extension will help you create a deployment. Just type `deployment`, `pod`, or `service` and click on the suggestion. A template file will be generated automatically. Change it accordingly:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: mypods
  namespace: default
spec:
  containers:
  - name: busybox
    image: busybox
    command:
      - sleep
      - "3600"
  - name: nginx
    image: nginx
```

Apply the YAML file:

```bash
# You can also use create instead of apply but if the resource already exists, it will return an error
k apply -f mypods.yaml
```

You can also use a single file and separate the *service*, *deployment*, and *pod* configuration using `---`

To delete deployments you can run `k delete -f mypods.yaml`.

### Generate config files

**It is considered a best practice to generate YAML files and not create them form scratch.** You can generate YAML files by using `--dry-run=client -o yaml > my.yaml` as an argument to `kubectl run` and `kubectl create` commands:

```bash
kubectl run mynginx --image=nginx --dry-run=client -o yaml > mynginx.yaml
```

### INIT containers

An init container is an additional container in a pod that completes a task before the main container is started. The main container will only be started once the init container has been started.

You can use `initContainers` argument in the YAML configuration file to declare the init container, the rest of the arguments underneath it are standard arguments for one or more containers.

## Namespaces

A Linux NameSpace implements kernel-level resource isolation. Kubernetes offers NameSpace resources that provide the same functionality. Different Namespaces can be used to strictly separate between customer resources.

You can tjink of namespaces as directories used to organise different applications and make sure that components for a specific application are found in the same namespace.

Kubernetes also uses namespaces as a security features such as:

- Role-Based Access Control (RBAC)
- Quota

You can manage a namespace by running:

```bash
# Create namespace
k create namespace mynamespace

# Work in a specific namespace
k <commands> -n mynamespace

# Delete a namespace
k delete namespace mynamespace

# Get configuration data of namespace such as quota and limits
k describe namespace mynamespace 
```

You can also use `ns` instead of `namespace` in the command to make it quicker to type.

## Networking

- **ClusterIP**: is the default Kubernetes service for internal communications. However, external traffic can access the default Kubernetes ClusterIP service through a proxy. This can be useful for debugging services or displaying internal dashboards. **Services are reachable by pods/services in the Cluster.**
- **NodePort**: opens ports on the nodes or virtual machines, and traffic is forwarded from the ports to the service. It is most often used for services that don’t always have to be available, such as demo applications. **Services are reachable by clients on the same LAN/clients who can ping the K8s Host Nodes.**
- **LoadBalancer**: is the standard way to connect a service externally to the internet. In this scenario, a network load balancer forwards all external traffic to a service. Each service gets its own IP address. **Services are reachable by everyone connected to the internet.**
- **Ingress**: acts as a router or controller to route traffic to services via a load balancer. It is useful if you want to use the same IP address to expose multiple services.

## Connect different deployments together

It is very common to connect multiple deployments together. Such as a web interface application to a database.

The web interface usually has a *LoadBalancer* type and the database has a *ClusterIP* type.

## Change container runtime from Docker to CRI-O

To change the container runtime you need to delete the current *minikube* setup and create a new one, then append `--container-runtime=cri-o` or `--container-runtime=containerd` to the `minikube start --driver=<driver_type>` command.

## Sources

- [FreeCodeCamp YouTube Channel](https://youtu.be/d6WC5n9G_sM)
- [VMWare GLossary](https://www.vmware.com/topics/glossary/content/kubernetes-networking.html#:~:text=Kubernetes%20networking%20allows%20Kubernetes%20components,host%20ports%20to%20container%20ports.)
