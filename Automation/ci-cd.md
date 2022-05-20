# CI/CD

## ToC

- [Build Automation](#build-automation---gradle)
- [Continuous Integration](#continuous-integration---jenkins)
- [Monitoring](#monitoring)

## Build Automation - Gradle

Gradle is a build tool. The installation steps 
can be found on their [website](https://gradle.org).

Gradle also has a tool called Gradle Wrapper. 
"*The Gradle Wrapper is a script that invokes a 
declared version of Gradle, downloading it 
beforehand if necessary.*"

If you already have Gradle installed on your 
computer, just `cd` into your project folder 
and run `gradle wrapper`.

This will place some script files inside your 
project folder.

**Please add `.gradle` to your `.gitignore` 
file so it won't be pushed to the repository.**

To run Graddle commands on your project use `./
gradlew build`

Gradle executes tasks. You can specify the 
tasks in *build.gradle* file and call them like 
this `./gradlew my_task`.

Gradle also supports plugins.

## Continuous Integration - Jenkins

To provide continuous integration we use a CI server that automatically compiles the code and runs automated tests.

A popular open source automation server is Jenkins.

The configuration which controls what a piece of Jenkins automates is called a *project* or a *job* (Job is an older terminology but they mean the same thing).

The easieas way to implement a CI build is to use a *freestyle project*.

Jenkins comes with a web interface, please read the documentation for further details.

In order to make Docker work with Jenkins, on the Jenkins machine install `docker` and run the following commands:

```bash
# Create group docker
groupadd docker

# Add the user jenkins to the docker group
usermod -aG docker jenkins

# Restart the services
systemctl restart jenkins
systemctl restart docker
```

## Monitoring

The monitoring process is made using Prometheus and Grafana.

Prometheus collects data and Grafana builds a dashboard to visualise that data.

To install Prometheus and Grafana in k8s, we will use *Helm*. With Helm we will be able to deploy preconfigured instances of Prometheus and Grafana inside a k8s cluster.

In Grafana you can either download community dashboards or create one yourself.
