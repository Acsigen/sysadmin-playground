# GitHub Actions

## Introduction

Github Actions is a platform to automate developer workflows (Mostly used for CI/CD pipelines).

A basic CI/CD workflow looks like this: Commit code &rarr; Test &rarr; Build &rarr; Push &rarr; Deploy.

## Syntax

Workflow files can be found in `your-repo/.github/workflows/` and are stored in YAML format.

GitHub also has the option to use a preconfigured template so you won't have to start from scratch.

The syntax looks like this:

|Element|Description|
|---|---|
|`name`|This is displayed on your repos action page [optional]|
|`on`|The name of GitHub event that triggers the workflow [required]. A list of events can be found [here](https://docs.github.com/cn/actions/using-workflows/events-that-trigger-workflows).|
|`jobs`|List of jobs such as *build*. These jobs are a sequence of `steps` that can run commands, setup tasks or run an action [required]|
|`uses`|Selects an action under path `action/` where the reusable code is hosted. You can find more actions [here](https://github.com/actions).|
|`with`|Select a specific version from an action such as `java-version: 1.8`|
|`run`|Run a shell command|

An example of a template that uses Java with Gradle looks like this:

```yml
name: Java CI with Gradle

on:
  push:
    branches: [ "main" ]
  pull_request:
    branches: [ "main" ]

permissions:
  contents: read

jobs:
  build:

    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v3
    
    - name: Set up JDK 11
      uses: actions/setup-java@v3
      with:
        java-version: '11'
        distribution: 'temurin'
    
    - name: Grant execute permission for gradlew
      run: chmod +x gradlew
    
    - name: Build with Gradle
      run: .gradlew build
    
    

  publish:
    needs: build
    
    - name: Build and Push Docker Image
      uses: mr-smithers-excellent/docker-build-push@v4
      with:
        image: my-docker-hub-repo/my-image-name
        registry: docker.io
        username: ${{ secrets.DOCKER_USERNAME }} # Configured in GitHub Settings -> Secrets
        password: ${{ secrets.DOCKER_PASSWORD }}
```

**Each job in a workflow will run in a fresh virtual environment.**

All jobs will run in parallel unless `needs` is specified.

If you want to use multiline `run` commands in YAML use `|` (straight bar) character like this:

```yml
run: |
  echo: Publishing image
  docker push
```

## Sources

- [TechWorld with Nana](https://www.youtube.com/watch?v=R8_veQiYBjI)
