# Jenkins

## Introduction

### What is Jenkins?

According to [this Reddit answer](https://www.reddit.com/r/devops/comments/3vdemi/comment/cxmxoje/?utm_source=share&utm_medium=web2x&context=3) *Jenkins is just a thing that does things. On a schedule, on code change detections, or on triggers. Those things can be running tests, doing maintenance tasks (like removing cloud artifacts), or literally anything. Builds that call builds. It's a toolbox with a few very basic tools in it that you can do almost anything with. Just don't abuse it.*

### Quick Start

In Jenkins a task is called a job. You can create your first job by clicking on **New Item** &rarr; **Freestyle Project** and under **Build** add a build step and input your command under **Execute shell** such as `echo "Current date is $(date)"`. You can now click **Build now** to run the command.

You can also add parameters to the project, these parameters will be passed as variables to the shell command. Now the *Build* button changed to *Build with Parameters*. Even if you configured the default values for the parameters, you will be asked to confirm or edit the default parameters before starting the build.

When adding a *Boolean Parameter* you have a checkbox with *Default value*, if that is checked the value is `true` and `false` if not checked.

## Execute remote jobs using SSH

In order to achieve that you will need to instal the SSH plugin and configure credentials from **Manage Jenkins** menu.

You need to configure SSH hosts from **Manage Jenkins** &rarr; **Configure System**.

From **Build** you need to select **Execute shell script on remote host using ssh**, select the host you configured and the rest is the same.

## Ansible integration

To integrate Jenkins with Ansible, you need to perform the following actions:

- Install `ansible` on the Jenkins host/container
- Configure an inventory
- Create a playbook
- Install the Ansible module for Jenkins.

After all the steps are done, you can use **Ansible Playbooks** inside the **Build** menu.

You can also use Jenkins Parameters to pass values inside Ansible:

- Set a parameter in Jenkins
- Click **Advanced** on Ansible Playbook configuration and **Add Extra Variable**
- Key should be the name of the variable from the playbook
- Value should be the name of the Jenkins Parameter with the format `$FOO`

## Security

Jenkins has authentication enabled by default. **Do not disable it!**

You can access security settings from **Manage Jenkins** &rarr; **Configure Global Security**.

You can improve security by installing **Role-based Authorization Strategy** plugin. Activate it from **Configure Global Security** then go to **Manage Jenkins** &rarr; **Manage and Assign Roles** to configure the roles.

## Jenkinsfile

A *Jenkinsfile* is a way to create pipelines in a declarative way.

We can use a *declarative pipeline* or a *scripted pipeline*. In this guide we will use the *declarative pipeline* since the *scripted pipeline*, which uses Groovy, is out of scope.

A sample of  a Jenkinsfile looks like this:

```jenkinsfile
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                //
            }
        }
        stage('Test') {
            steps {
                //
            }
        }
        stage('Deploy') {
            steps {
                //
            }
        }       
    }
}
```
