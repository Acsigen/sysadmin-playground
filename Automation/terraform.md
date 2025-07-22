# Terraform

## IaC Concepts

With IaC (infrastructure as code) you write a configuration script to automate creating, updating or destroying cloud infrastructure.

- IaC is a blueprint of your infrastructure
- IaC allows you to easily share, version or inventory your cloud infrastructure.

There are multiple types of IaC tools:

- Declarative
  - What you see is what you get. Explicit
  - More verbose, but zero chance of misconfiguration
  - Uses scripting languages such as JSON, YAML, XML
  - Examples:
    - ARM Templates (Azure)
    - Azure Blueprints (Manages relationship between services)
    - CloudFormation (AWS)
    - Cloud Deployment Manager (Google Cloud Platform)
    - Terraform (Supports multiple cloud providers)
- Imperative
  - You say what you want, and the rest is filled in. Implicit
  - Less verbose, you could end up with misconfigurations
  - Does more than Declarative
  - Uses programming languages such as Python, Ruby, JavaScript
  - Examples:
    - AWS Cloud Development Kit (CDK)
    - Pulumi (AWS, Azure, GCP, K8S)

Terraform, even though it is declarative, it also has some imperative functionality due to the HCL language (loops, dynamic blocks, locals, complex data structures, etc.).

An infastructure lifecycle is a number of clearly defined and distinct work phases which are used bby DevOps Engineers to plan, design, build, test, deliver, maintain and retire cloud infrastructure.

- Day 0 - Plan and Design
- Day 1 - Develop and Iterate
- Day 2 - Go live and maintain

IaC brings reliability into infrastructure lifecycle, no matter how many times you run IaC, you will always end up with the same state that is expected.

There are 3 concepts that need not to be confused:

- Provisioning: When you launch a cloud service and configure it, you are provisioning
- Deployment: The act of delivering a version of your application to run on a provisioned server
- Orchestration: The act of coordinating multiple systems or services (microservices, containers, kubernetes)

Configuration drift is when provisioned infrastructure has an unexpected configuration change due to:

- Team members manually adjusting configuration options
- Malicious actors
- Side effects from APIs, SDKs, or CLIs

Configuration drift is usually detected through a compliance tool such as: AWS Config, Azure Policies, GCP Security Health Analytics, CloudFormation Drift Detection. Terraform does this with state files.

Compliance tools can remediate misconfigurations.

To prevent configuration drift:

- Use immutable infrastructure, always create and destroy, never reuse, Blue-Green deployment strategy
- Use GitOps to versioun control your IaC and peer review every single change.

Mutable vs. Immutable infrastructure:

- Mutable: A VM is deployed and then Configuration Management tool like Ansible, Puppet, Chef, Salt or Cloud-Init is used to configure the state of the server
- Immutable: A VM is launched and provisioned, and then it is turned into a Virtual Image, stored in image repository, that image is used to deploy VM instances.

GitOps is when you take IaC and you use a git repository to introduce a formal process to review and accept changes to infrastructure code, once that code is accepted, it automatically triggers a deploy.

## HashiCorp Introduction
