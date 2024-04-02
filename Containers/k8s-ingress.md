# Kubernetes Ingress Controllers and Ingress Resources

## Prerequisites

Ingress Controllers and Ingress Resources are core elements of a Kubernetes infrastructure serving as an entrypoint for the public to your applications. They mostly act as a reverse proxy which can do:

- Load Balancing
- SSL Termination
- Path-based Routiung

For this guide consider an e-commerce platform with distinct services for product listings (`service1`) and customer reviews (`service2`). The purpose is to configure ingress to route traffic to the proper service based on the URL path.

## Ingress Controllers

A configuration for a basic NGINX Ingress Controller is presented below:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-ingress-controller
  namespace: ingress-nginx
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx-ingress
  template:
    metadata:
      labels:
        app: nginx-ingress
    spec:
      containers:
      - name: nginx-ingress
        image: nginx/nginx-ingress:latest
        ports:
        - name: http
          containerPort: 80
        - name: https
          containerPort: 443
```

**Most of the time you won't need to deploy the controller yourself. This is usually already included with the Kubernetes deployment that you use (AKS, EKS, Microk8s, Rancher, etc.).**

To make the Ingress Controller accessible to external traffic, expose it as a service:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-ingress
  namespace: ingress-nginx
spec:
  type: LoadBalancer
  ports:
  - name: http
    port: 80
    targetPort: http
  - name: https
    port: 443
    targetPort: https
  selector:
    app: nginx-ingress
```

### Customize Ingress Controller behaviour

Annotations allow you to customize the behaviour of your Ingress Controller. However, use them with care to avoid overcomplicating your configuration. For example, to rewrite the target path:

```yaml
metadata:
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /$1
```

### Monitoring and logging

Monitoring and logging are critical for troubleshooting and performance optimization. Use Prometheus for metrics and fluentd or a similar tool for logging. Ensure your Ingress Controller exposes the necessary metrics:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-ingress-controller
spec:
  template:
    spec:
      containers:
      - name: nginx-ingress
        args:
          - /nginx-ingress-controller
          - --publish-service=$(POD_NAMESPACE)/nginx-ingress
          - --metrics-per-host=false
```

### Caching

For applications serving static content, configure your Ingress Controller to cache content at the edge, reducing load times and backend load:

```yaml
metadata:
  annotations:
    nginx.ingress.kubernetes.io/enable-caching: "true"
    nginx.ingress.kubernetes.io/cache-duration: "10m"
```

## Ingress Resources

With the Ingress Controller deployed, define resources to route `/service1` and `/service2` paths to their respective backend services.

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ecommerce-ingress
  namespace: default
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - host: www.example-ecommerce.com
    http:
      paths:
      - path: /service1
        pathType: Prefix
        backend:
          service:
            name: product-listing-service
            port:
              number: 80
      - path: /service2
        pathType: Prefix
        backend:
          service:
            name: customer-review-service
            port:
              number: 80
```

This configuration directs requests to <www.example-ecommerce.com/service1> and <www.example-ecommerce.com/service2> to the appropriate services.

### Better organise resources

Structure your Ingress Resources logically. Group them by domain or application function to make management easier. Use Kubernetes namespaces to separate environments or applications:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: payment-ingress
  namespace: finance-app
spec:
  rules:
  - host: payments.example.com
    http:
      paths:
      - path: /checkout
        pathType: Prefix
        backend:
          service:
            name: checkout-service
            port:
              number: 80
```

### Implement TLS/SSL

Always secure your Ingress with TLS/SSL, especially if you’re handling sensitive data. You can manage certificates manually or use cert-manager for automated certificate provisioning:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: secure-app-ingress
spec:
  tls:
  - hosts:
    - secure.example.com
    secretName: secure-example-tls
  rules:
  - host: secure.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: secure-app-service
            port:
              number: 443
```

### Automate DNS

Integrate with ExternalDNS to automatically manage DNS records based on Ingress Resources, simplifying the mapping between hosted domains and your services:

```yaml
metadata:
  annotations:
    external-dns.alpha.kubernetes.io/hostname: app.example.com.
```

## Sources

- [overcast.blog](https://overcast.blog/kubernetes-ingress-controllers-and-ingress-resources-a-practical-guide-7a709dec3e4b)
- [kubernetes.io](https://kubernetes.io/docs/concepts/services-networking/ingress/)
- [Nginx Ingress Controller GitHub Repository](https://github.com/kubernetes/ingress-nginx)
- [Official Nginx Ingress Controller Documentation](https://docs.nginx.com/nginx-ingress-controller/)
