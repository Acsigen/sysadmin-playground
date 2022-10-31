# Monitoring with Grafana and Prometheus

## Prerequisites

In this section of the repository you cand find a basic example of a Docker Compose file that is being used to deploy the following containers:

- Grafana
- Prometheus
- Node Exporter
- cAdvisor

## Grafana

*Grafana is a multi-platform open source analytics and interactive visualization web application. It provides charts, graphs, and alerts for the web when connected to supported data sources.*

The most common data source for Grafana is [Prometheus](#prometheus), but it supports all kinds of data sources.

In Grafana you can create Dashboards and Alerts based on the data that you read from the data sources.

You can also [import predefined dashboards](https://grafana.com/grafana/dashboards/) built by the community

## Prometheus

*Prometheus is a free software application used for event monitoring and alerting. It records real-time metrics in a time series database built using a HTTP pull model, with flexible queries and real-time alerting.*

In order to grab data from [exporters](#prometheus-exporters), Prometheus is requires a **job** to be defined in the configuration file.

## Prometheus Exporters

A Prometheus Exporter is a piece of software that can fetch statistics from another, non-Prometheus system and can turn those statistics into Prometheus metrics, using a client library. Then it starts a web server that exposes a metrics URL, and have that URL display the system metrics.

### Node Exporter

*The Prometheus Node Exporter exposes a wide variety of hardware and kernel-related metrics.*

### cAdvisor

*cAdvisor (short for container Advisor) analyzes and exposes resource usage and performance data from running containers. cAdvisor exposes Prometheus metrics out of the box.*

## Sources

- [Grafana Wikipedia](https://en.wikipedia.org/wiki/Grafana)
- [Prometheus Wikipedia](https://en.wikipedia.org/wiki/Prometheus_(software))
- [Node Exporter Prometheus Exporter](https://prometheus.io/docs/guides/node-exporter/#monitoring-linux-host-metrics-with-the-node-exporter)
- [cAdvisor Prometheus Exporter](https://prometheus.io/docs/guides/cadvisor/)
- [Christian Lempa YouTube Tutorial](https://www.youtube.com/watch?v=9TJx7QTrTyo)
