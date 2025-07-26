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

HashiCorp is a company specializing in managed open-source tools used to support the development and deployment of large-scale service-oriented software installations​.

Hashicorp offers a variety of products:

- Boundary: Secure remote access to systems based on trusted identity
- Consul: Service discovery platform. Provides a full-featured service mesh for secure service segmentation across any cloud or runtime environment, and distributed key-value storage for application configuration
- Nomad: Scheduling and deployment of tasks across worker nodes in a cluster
- Packer: Tool for building virtual machine images for later deployment
- Terraform: IaC Software
- Terraform Cloud: A place to store and manage IaC in the cloud
- Vagrant: Building and maintainance of reproducible software-development environments via virtualization technology
- Vault: Secrets management
- Waypoint: Modern workflow to build, deploy, and release across platforms

Terraform is an open-source and cloud-agnostic Infrastructure as Code (IaC) tool.​ Terraform uses declarative configuration files. The configuration files are written in HashiCorp Configuration Language (HCL).​

Terraform Cloud is a Software as Service (SaaS) offering for:​

- Remote state storage​
- Version Control integrations​
- Flexible workflows​
- Collaborate on Infrastructure changes​

## Terraform Basics

### Terraform Lifecycle

- Code: Wirte or update your Terraform configuration file
- Init: Initialise your project
- Plan: Speculate what will change or generate a saved execution plan
- Validate (Automatic or Manual): Ensure types and values are valid
- Apply: Execute the terraform plan provisioning the infrastructure
- Destroy (When necessary): Destroy the remote infrastructure

### Change Automation

- Change Management: A standard approach to apply change, and resolving conflicts brought about by change.​ In the context of Infrastructure as Code (IaC), Change management is the procedure that will be followed when resources are modified and applied via configuration script.
- Change Automation: A way of automatically creating a consistent, systematic, and predictable way of managing change requests via controls and policies​. Terraform uses Change Automation in the form of Execution Plans and Resources graphs to apply and review complex changesets​
- ChangeSet: A collection of commits that represent changes made to a versioning repository. IaC uses ChangeSets so you can see what has changed by who over time.​

Change Automation allows you to know exactly what Terraform will change and in what order, avoiding many possible human errors.​

### Execution Plans

An Execution Plan is a manual review of what will add, change or destroy before you apply changes, eg. `terraform apply​`, resources and configuration settings will be listed.​

It will indicate will be added, changed​ or destroyed if this plan is approved. A user must approve changes by typing: `yes​`.

You can visualize an execution plan as a graph using the `terraform graph` command​. Terraform will output a GraphViz file (you’ll need GraphViz installed to view the file)​

GraphViz is an open-source tool for drawing graphs specified in DOT language scripts having the file name extension `.gv`.

```bash
terraform graph | dot -Tsvg > graph.svg
```

### Terraform Core vs. Terraform Plugins

Terraform is logically split into two main parts:

- Terraform Core: uses remote procedure calls (RPC) to communicate with Terraform Plugins
- Terraform Plugins: expose an implementation for a specific service, or provisioner​

Terraform Core is a statically-compiled binary written in the Go programming language.​

### Terraform Init

To initialise a Terraform project, you must create a `main.tf` file containing the provider configuration.

Inside `main.tf` file you can place all your code for resource definitions, but that is not mandatory. I like to split that file so only th provider sits inside it and the rest of resources will have a dedicated file.

After you create the file, run `terraform init` in order to download and configure all dependencies.

Some other useful commands at this stage are:

- `terraform fmt`: Will autoformat/indent the contents of the files (Terraform users are quite picky about this)
- `terraform validate`: Will check if the files are valid (acts more like a linter for types and required arguments)

### Terraform Plan and Apply

Terraform has a functionality named "Plan". When you run `terraform plan`, it will display a list of resources that should be created, changed, or deleted with the current configuration (like a dry run).

A best practice is to place the plan in a file with `terraform plan -out myplan.tfplan` and use that file to apply the changes. This helps with unwanted changes in the configuration being applied by accident.

`terraform apply` is being used to apply the current configuration. As mentioned before, we can use a plan generated earlier to apply the configuration with `terraform apply terraform.tfplan`.

### Input Variables

Terraform can use variables to make it more configurable.

Define and reference a variable:

```terraform
variable "ami_id" {
    type = "string"
}

resource "aws_instance" {
    ami = var.ami_id
    instance_type = "t2.nano"
}
```

To set the value we have three methods,

- Use the `-var` argument `terraform plan -var=ami_id="a34234fcg54"`
- Use the `terraform.tfvars` file
- Use the `default` key inside the variable declaration block

A best practice is to use `variables.tf` to configure all variables. Even though terraform has the `terraform.tfvars` option, that is best used for composition.

If you decide to use `terraform.tfvars`, the definition of variables is just a key-value pair:

```tfvars
ami_id="23134hfsdkh4"
```

Putting all code in `main.tf` is a good idea when you are getting started or writing an example code. In all other cases you will be better having several files split logically like this:

- `main.tf` - call modules, locals, and data sources to create all resources
- `variables.tf` - contains declarations of variables used in `main.tf`
- `outputs.tf` - contains outputs from the resources created in `main.tf`
- `versions.tf` - contains version requirements for Terraform and providers

This is recommended for small projects. When things get more complex, you can split `main.tf` even more

### Locals

Locals are hardcoded variables:

```terraform
# Definition
locals {
    ami_id="34234jkhfdskj4"
}

# Reference
resource "aws_instance" {
    ami = local.ami_id
    instance_type = "t2.nano"
}
```

### Outputs

Outputs helps you print on the screen the value of a specific resource (e.g. IP of an EC2 instance).

```terraform
output "instance_ip" {
    value = aws_instance.server.private_ip
}
```

### Modules

Modules are the main way to package and reuse resource configurations with Terraform.

A module is a group of configuration files that provide common configuration functionality.

- Enforces best practices
- Reduce the amount of code
- Reduce time to develop scripts

An example is the AWS VPC module in which we configure much less resources than we would do if we would deploy a VPC from scratch.

We can also create or own modules.

### Terraform Cloud

All we did until now is stored inside a tfstate file on our local machine. A common practice is to store that file on a cloud backend such as Terraform Cloud or AWS S3.

To configure that backend we need to configure terraform with the settings:

```terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "my-tf-bucket"
    key    = "terraform.tfstate"
    region = "eu-central-1"
    profile = "dev-my-aws"
    # Optional: dynamodb_table = "terraform-lock" # Activate this to avoid issues with multiple team members working on the same project
  }
}

provider "aws" {
    region  = "eu-central-1"
    profile = "dev-my-aws"
}
```

When using Terraform Cloud, the runtime is in the cloud so variables values might not be available from local machine so we need to configure them inside the cloud workspace.

## Provisioners

Terraform Provisioners install software, edit files, and provision machines created with Terraform.

Terraform uses two provisioners:

- CloudInit
- Packer

**Provisioners should only be used as a last resort. For most common situations there are better alternatives.**

### Local-Exec

Local-exec allows you to execute local commands after a resource is provisioned.

The machine that is executing Terraform eg. terraform apply is where the command will execute.

An example is after you provision a VM you need to supply the Public IP to a third-party security service to add the VM IP address and you accomplish this by using locally installed third-party CLI on your build server.​

### Remote-Exec

Remote-exec allows you to execute commands on a target resource after a resource is provisioned.

For more complex tasks its recommended to use Cloud-Init, and strongly recommended in all cases to bake Golden Images via Packer or EC2 Image Builder.

Remote Command has three different modes:

- Inline - list of command strings
- Script - relative or absolute local script that will be copied to the remote resource and then executed
- Scripts - relative or absolute local scripts that will be copied to the remote resource and then executed and executed in order.

### File

File provisioner is used to copy files or directories from our local machine to the newly created resource

- Source – the local file we want to upload to the remote machine​
- Content – a file or a folder
- Destination – where you want to upload the file on the remote machine

You may require a connection block within the provisioner for authentication

The connection has two protocols available:

- SSH
- WINRM

### Null Resources

`null_resource` is a placeholder for resources that have no specific association with a provider's resources.

You can provide a connection and triggers to a resource.

Triggers is a map of values that should cause this set of provisioners to re-run.

​Values are meant to be interpolated references to variables or attributes of other resources.

### Terraform Data

Terraform Data is similar to `null_resources` but does not require or the configuration of a provider.

Most of the time you will use Terraform Data instead of Null Resource since is easier to setup and you do not need a provider for it.

## Providers

Providers are Terraform Plugins that allow you to interact with:

- Cloud Service Providers (CSPs) eg. AWS, Azure, GCP
- Software as a Service (SaaS) Providers eg. Github, Angolia, Stripe
- Other APIs eg. Kubernetes, Postgres

Providers come in three tiers:

- Official — Published by the company that owns the provider technology or service
- Verified — actively maintained, up-to-date, and compatible with both Terraform and Provider
- Community — published by a community member but no guarantee of maintenance, up-to-date, or compatibility

### Terraform Registry

[Terraform Registry](https://registry.terraform.io/) is a website portal to browse, download or publish available Providers or Modules.

Terraform Cloud allows you to publish private modules for your Organization within the Terraform Cloud Private Registry.

To get a list of current providers that you are using run `terraform providers`.

## Terraform Language

Terraform files end in the extension of `.tf` or either `.tf.json`.

Terraform files are written in the Terraform Language and is the extension of HCL.

Terraform language consists of only a few basic elements:

- Blocks — containers for other content, represent an object
  - block type — can have zero or more labels and a body
  - block label — name of a block
- Arguments — assign a value to a name
  - They appear within blocks
- Expressions — represent a value, either literally or by referencing and combining other values
  - They appear as values for arguments, or within other expressions.​

Terraform also supports an alternative syntax that is JSON-compatible.

Terraform expects JSON syntax files to be named with `.tf.json`.

This syntax is useful when generating portions of a configuration programmatically, since existing JSON libraries can be used to prepare the generated configuration files.

### Environment Variables

We talked before how to use variables. But we can also make use of environment variables.

Variable starting with `TF_VAR_` such as `TF_VAR_AWS_SECRET_KEY` will be read and loaded as `AWS_SECRET_KEY`.

### Variables Priority

The definition precedence is the order in which Terraform will read variables and as it goes down the list it will override variables.

- Environment Variables
- `terraform.tfvars` or `terraform.tfvars.json` - Default Autoloaded Variables file
- `*.auto.tfvars` or `*.auto.tfvars.json` - Additional Variables Files (autoloaded)
- `-var` and `-var-file`

You can create additional variables files eg. `dev.tfvars`, `prod.tfvars`. They will not be autoloaded (you’ll need to specific them in via command line).

### Data Sources

Data sources allow Terraform to use information defined outside of Terraform, defined by another separate Terraform configuration, or modified by functions.

- You specify what kind of external resource you want to select
- You use filters to narrow down the selection
- You use `data.` to reference data sources

## Resource Meta-Arguments



## Sources

- [ExamPro Certification Course](https://app.exampro.co/student/journey/terraform)
- [Terraform Best Practices](https://www.terraform-best-practices.com/)
