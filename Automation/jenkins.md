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
