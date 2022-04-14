# CI/CD

## ToC

- [Source Control Management - Git](#source-control-management---git)
- [Build Automation](#build-automation---gradle)
- [Continuous Integration](#continuous-integration---jenkins)
- [Monitoring](#monitoring)

## Source Control Management - Git

Git steps:

- Clone
- Add
- Commit
- Push
- Branch
- Merge
- Pull Request

After installing *git* it is best to configure the following settings:

```bash
git config --global user.name "<your_name>"
git config --global user.email <your_email>
```

The easiest and safest way to authenticate to remote git servers is to use key pairs (SSH key pairs).

If a repository already has some code in it, you can use `git clone <repo_link>` to download the files locally or, if there is no code, you can initialise a repository using `git init` command.

To get more information about the local repository you can use `git status` command.

To stage the commit (tell git what file to change for the next commit) you can use `git add <file>` you can also use wildcards `git add .` or `git add -A`.

To commit the files you can use `git commit -m "your_message_or_description"`. **This will only commit changes to your local copy.**

To upload the commits, you will use `git push`. It will automatically push the changes to the branch configured in your local repository. If the branch is different, use `git push -u <remote_name> <branch_name>`.

To check what branches are available use `git branch`.

To change the branch use `git checkout <branch>`.

You can also create a new branch and checkout immediately using `git checkout -b <new_branch>`.

Tags are used, commonly, to indicate the version of the commit. You can use it like this `git tag <my_tag>`.

Pull requests are available only on GitHub. They allow review of merges from other users.

## Build Automation - Gradle

Gradle is a build tool. The installation steps 
can be found on their [website](https://gradle.
org).

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
systemctl jenkins
systemctl docker
```

## Monitoring

The monitoring process is made using Prometheus and Grafana.

Prometheus collects data and Grafana builds a dashboard to visualise that data.

To install Prometheus and Grafana in k8s, we will use *Helm*. With Helm we will be able to deploy preconfigured instances of Prometheus and Grafana inside a k8s cluster.

In Grafana you can either download community dashboards or create one yourself.
