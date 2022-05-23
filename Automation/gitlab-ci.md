# Gitlab CI

Gitlab as a complete DevOps lifecycle application provides its users with an integrated CI/CD feature which is managed through a single file placed at the repository’s root.

In a nutshell, the users will put the CI/CD configuration in a file named `.gitlab-ci.yml` and every time a code change is pushed to the Gitlab repository, Gitlab with run the configured CI/CD script.

## GitLab Runner

Gitlab runner is an open-source project with various features on how to run the CI/CD script. Scripts configured for Gitlab CI/CD will be executed by the Gitlab runner.

## Pipelines

Pipelines are the top-level component of continuous integration, delivery, and deployment. A pipeline will be created when a new push is made to the Gitlab repository. The pipeline will run when there is an idle Gitlab runner.

## Jobs

Jobs is something that defines what will be run. By default, when running a job Gitlab will spawn a docker container, clone your repository inside the container, and run the specified script.

The script located in `.gitlab-ci.yml` can look like this:

```yaml
image: "ruby:2.6.3"test:
  script:
    - gem install bundler
    - bundle install
    - bundle exec rails spec
```

## Stages

Jobs can be grouped in stages. By default, a pipeline will have three stages: build, test, and deploy.

If we don’t specify a stage in a job, Gitlab will automatically put it under `test` stage.

An example with `test` and `build` stages is shown below:

```yaml
image: "ruby:2.6.3"

# specify commands that we want to run before each job
before_script: 
  - gem install bundler
  - bundle install

test:
  script:
    - bundle exec rails spec

build:
  stage: build
  script:
    - bundle package
```

Gitlab CI/CD also support the creation of custom stages:

```yaml
stages:
  - test
  - pre-build
  - build
  - deploy

backend-test:
  stage: test
  ...

backend-pre-build:
  stage: pre-build
  ...

backend-build:
  stage: build
  ...

backend-deploy:
  stage: deploy
  ...
```

By default, the next stage will run after the previous one has succeeded. So when the previous failed, the next stage will not run. We can change that behaviour by specifying `allow_failure: true`.

If you want your job not to run automatically, Gitlab provides the option to specify when to run the job. The options provided are `manual`, `always`, `on_success`, and `on_failure`.

## Syntax Error

To avoid getting errors you can try the following options:

- [Validate the syntax of your configuration before pushing](https://docs.gitlab.com/ee/api/lint.html)
- [Configure your own runner](https://docs.gitlab.com/ee/ci/runners/#shared-specific-and-group-runners)

## Optimisation

[You can cache](https://docs.gitlab.com/ee/ci/caching/) the files so that you don’t have to redownload everything everytime you pipeline runs. Another fix is to create your own docker image tailored for your own needs.

When you use Gitlab CI/CD to automate packaging and deployment for your application, you might encounter the need to pass files generated in one job to another job. To do this learn you should learn how to use [artifacts](https://docs.gitlab.com/ee/ci/pipelines/job_artifacts.html#create-job-artifacts).

When using at a larger scale, you might expect a queue if you don’t configure your runner wisely, look more into [shared, specific, and group runner](https://docs.gitlab.com/ee/ci/runners/#shared-specific-and-group-runners) to address that.

## Sources

- [faun.pub](https://faun.pub/gitlab-ci-cd-crash-course-6e7bcf696940)
- [GitLab docs](https://docs.gitlab.com/ee/ci/yaml/#when)
- [GitLab docs quickstart](https://docs.gitlab.com/ee/ci/quick_start/)
- [GitLab GI/CD keywords reference](https://docs.gitlab.com/ee/ci/yaml/)
- [Valentin Despa Course Notes](https://gitlab.com/gitlab-course-public/freecodecamp-gitlab-ci/-/blob/main/docs/course-notes.md)
