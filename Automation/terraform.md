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

erraform language defines several meta-arguments, which can be used with any resource type to change the behavior of resources.

- `depends_on`, for specifying explicit dependencies
- `count`, for creating multiple resource instances according to a count
- `for_each`, to create multiple instances according to a map, or set of strings
- `provider`, for selecting a non-default provider configuration
- `lifecycle`, for lifecycle customizations
- `provisioner` and connection, for taking extra actions after resource creation

When you execute an execution order via Terraform Apply it will perform one of the following to a resource:

- Create - resources that exist in the configuration but are not associated with a real infrastructure object in the state.
- Destroy - resources that exist in the state but no longer exist in the configuration.
- Update in-place - resources whose arguments have changed.
- Destroy and re-create - resources whose arguments have changed but which cannot be updated in-place due to remote API limitations.

Lifecycle block allows you to change what happens to resources e.g. create, update, destroy.

Lifecycle blocks are nested within resources

- `create_before_destroy` (bool) - When replacing a resource first create the new resource before deleting it (the default is destroy old first)
- `prevent_destroy` (bool) - Ensures a resource is not destroyed
- `ignore_changes` (list of attributes) - Don’t change the resource (create, update, destroy) if a change occurs for the listed attributes.

If you need to override the default provider for a resource you can create an alternative provider with alias.

You reference the alias under the attribute `provider` for a resource.

```terraform
provider "google" {
    region = "us-central1"
}

provider "google" {
    alias = "europe"
    region = "europe-west1"
}

resource "google_compute_instance" "example" {
    provider = google.europe

    ...
}
```

## Expressions

### Types and Values

Terraform has the following types of values:

- Primitives
  - string
  - number (float or int)
  - bool
- No Type
  - null (represents absence or omission, when you want to use the underlying default of a provider’s resource configuration option)
- Complex Types:
  - list (tuples, strings)
  - map (object)

### Strings and Strings Templates

When quoting strings it is mandatory to use doublequotes. Single quotes are no longer supported.

Double quoted strings can interpret escape sequences (`\n`, `\t`, `\\`, etc.).

Terraform also supports "heredoc" stype (`EOL`, `EOF` style from UNIX).

Terraform also supports string interpolation (like Python's f strings): `${ ... }`

There is also the possibility for string directive that allows you to evaluate a conditional logic between the markers: `%{ ... }`.

You can stripe whitespacing that would normally be left by directive blocks by providing a trailing tilde (`~`)

### Operators

- Multiplication `a * b`
- Division `a / b`
- Modulus `a % b`
- Addition `a + b`
- Subtraction `a – b`
- Flip to Negative (* -1) `-a`
- Equals `a == b`
- Does not Equal `a != b`
- Less Than `a < b`
- Less Than or Equal `a <= b`
- Greater Than `a > b`
- Greater Than or Equal `a >= b`
- Or `a || b`
- And `a && b`
- Flip Boolean `!a`

### Conditionals

Terraform support ternary if else conditions. This is the only way: `condition ? true_val : false_val`

```terraform
var.a != "" ? var.a : "default-a"
```

The return type must be the same type: `var.example ? tostring(12) : "hello"`.

### FOR Loops

For expressins allows you to iterate over a complex type and apply transformations.

A FOR expression can accept as input:

- list
- set
- tuple
- map
- object

FOR expression is different from `for_each`. For each can interate over a collection of resources while the FOR expression iterates over the data types that we presented above.

```terraform
# For a list
[ for s in var.list : upper(s)]

# For a map
[for k, v in var.map : length(k) + length(v)]

# For a list where you get the index
[for i,v in var.list : "${i} is ${v}"]
```

Return types:

- If we use `[ ... ]`, it will return a tuple
- If we use `{ ... }`, it will return an object

### Splat Expressions

A splat operator is represented by an asterisk (`*`), it originates from the ruby language.

Splats in Terraform are used to rollup or soak up a bunch of iterations in a for expression.

```terraform
# A FOR loop
[for o in var.list : o.id]
[for o in var.list : o.interfaces[0].name]

# A splat
var.list[*].id
var.list[*].interfaces[0].name
```

### Dynamic Blocks

Dynamic blocks allows you dynamically construct repeatable nested blocks.

This is quite common in Terraform configurations but can make the code a little bit harder to read.

An example is when you need to create a bunch of ingress rules for an EC2 Security Group.

```terraform
locals {
  ingress_rules = [{
    port = 443
  },
  {
    port = 80
  }]
}

resource "aws_security_group" "main" {
  name = "sg"
  vpc_id = data.aws_vpc.main.id

  dynamic "ingress" {
    for_each = local.ingress_rules

    content {
      from_port = ingress.value.port
      to_port = ingress.value.port
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
```

### Version Constraints

Terraform utilizes Semantic Versioning for specifying Terraform, Providers, and Modules versions.

Semantic Versioning is open-standard on how to define versioning for software management e.g. MAJOR.MINOR.PATCH.

1. MAJOR version when you make incompatible API changes,
2. MINOR version when you add functionality in a backwards-compatible manner, and
3. PATCH version when you make backwards-compatible bug fixes. Additional labels for pre-release and build metadata are available as extensions to the MAJOR.MINOR.PATCH format.

A version constraint is a string containing one or more conditions, separated by commas.

- `=` or no operator. Match exact version number e.g. “1.0.0”, “=1.0.0”
- `!=` Excludes an exact version number e.g. “!=1.0.0”
- `>`, `>=`, `<`, `<=` Compare against a specific version e.g. “>= 1.0.0”
- `~>` Allow only the rightmost version (last number) to increment e.g. ~> 1.0.0”

Progressive Versioning is the practice of using the latest version to keep a proactive stance of security, modernity, and development agility.

## Terraform State

The state is a particular condition of cloud resources at a specific time.

When you provision infrastructure via Terraform it will create a state file named `terraform.tfstate`.

This state file is a JSON data structure with a one-to-one mapping from resource instances to remote objects.

Terraform state CLI commands:

- `terraform state list` List resources in the state
- `terraform state mv` Move an item in the state
- `terraform state pull` Pull current remote state and output to stdout
- `terraform state push` Update remote state from a local state
- `terraform state replace-provider` Replace provider in the state
- `terraform state rm` Remove instances from the state
- `terraform state show` Show a resource in the state

The `terraform state mv` allows you to:

- rename existing resources
- move a resource into a module
- move a module into a module

If you were to just rename a resource or move it to another module and run terraform apply Terraform will destroy and create the resource. State mv allows you to just change the reference so you can avoid a create and destroy action.

All terraform state subcommands that modify state will write a backup file.

Terraform will take the current state and store it in a file called `terraform.tfstate.backup`.

Backups cannot be disabled.

## Initialising Working Directories

We talked about `terraform init` befote. Here we will look at some useful arguments for the init command:

- `terraform init -upgrade` Upgrade all plugins to the latest version that complies with the configuration's version constraint
- `terraform init -get-plugins-false` Skip plugin installation
- `terraform init -plugin-dir=PATH` Force plugin installation to read plugins only from the target directory
- `terraform init -lockfile=MODE` Set a dependency lock file mode

Dependencies are tracked with a lock file `.terraform.lock.hcl`.

**If you modify or change dependencies, run `terraform init` again to have it apply the changes.**

Make sure you do not mix `.terraform.lock.hcl` with `.terraform.tfstate.lock.hcl` which is the lock file for terraform state.

There is also `terraform get` command is used to download and update modules in the root module.

You may need to frequently pull updated modules but you do not want to initialize your state or pull new provider binaries.

In most cases, you want to use terraform init, with the exception of local module development.

## Writing and Modifying Terraform Code

Terraform has three CLI commands that improve debugging configuration scripts:

- `terraform fmt` rewrites Terraform configuration files to a standard format and style
- `terraform validate` validates the syntax and arguments of the Terraform configuration files in a directory
- `terraform console` an interactive shell for evaluating Terraform expressions

## Plan and Apply

A plan consists of:

- Reading the current state of any already-existing remote objects to make sure that the Terraform state is up-to-date.
- Comparing the current configuration to the prior state and noting any differences.
- Proposing a set of change actions that should, if applied, make the remote objects match the configuration.

A Terraform Plan file is a binary file.

When using save planed it will not prompt you to confirm and will act like `auto-approve`.

Terraform apply command executes the actions proposed in an execution plan.

Requires users to manually approve the plan by writing “yes”. `terraform apply –auto-approve` flag will automatically approve the plan.

When you provide a filename to terraform to saved plan file `terraform apply FILE`.

## Drift

Drift (Configuration or Infrastructure) is when your expected resources are in a different state than your expected state.

We can resolve Drift in three ways in Terraform:

- Replacing Resources - When a resource has become damaged or degraded that cannot be detected by Terraform we can use the `–replace` flag
- Importing Resources - When an approved manual addition of resource needs to be added to our state file. We use the `import` command.
- Refresh State - When an approved manual configuration of a resource has changed or removed. We use the `–refresh-only` flag to reflect the changes in our state file.

### Replacing Resources

Terraform used taint to mark a resource for replacement, the next time you run apply.

A cloud resource can become degraded or damaged and you want to return the expected resource to a healthy state.

It is recommended in 0.15.2+ to use the -replace flag and providing a resource address.

```terraform
terraform apply -replace="aws_instanec.example[0]"
```

### Resource Addressing

A resource address is a string that identifies zero or more resource instances in your configuration.

An address is composed of two parts: `[module path][resoource spec]`.

- `module.module_name[module index]`:
  - `module` A namespace for modules
  - `module_name` User-defined name of the module
  - `[module index]` When multiple specific an index
- `resource_type.resource _name[instance index]`
  - `resource_type` Type of the resource being addressed
  - `resource_name` User-defined name of the resource
  - `[instance index]` when multiple specific an index

### Terraform Import

The terraform import command is used to import existing resources into Terraform.

Define a placeholder for your imported resource in the configuration file.

```terraform
resource "aws_instance" "example" {
  # You can leave the body blank and fill it in after importing. It will not be autofilled.
}
```

To import the resource run `terraform import aws_instance.example i-abcd1234`.

Not all resources are importable.

### Terraform Refresh

The `terraform refresh` is basically an alias to `terraform apply -refresh-only -auto-approve`.

## Troubleshooting

There are 4 sources of possible errors:

- Language errors - Terraform encounters a syntax error in your configuration for the Terraform or HCL Language
  - `terraform fmt`
  - `terraform validate`
  - `terraform version`
- State errors - Your resources state has changed from the expected state in your configuration file
  - `terraform refresh`
  - `terraform apply`
  - `terraform –replace flag`
- Core errors - A bug has occurred with the core library
  - TF_LOG
  - Open GitHub Issue
- Provider errors - The provider’s API has changed or does not work as expected due to emerging edge cases
  - TF_LOG
  - Open GitHub Issue

### Terraform Logs

Terraform has detailed logs which can be enabled by setting the `TF_LOG` environment variable to:

- TRACE
- DEBUG
- INFO
- WARN
- ERROR
- JSON — outputs logs at the TRACE level or higher, and uses a parseable JSON encoding as the formatting.

Logging can be enabled separately:

- `TF_LOG_CORE`
- `TF_LOG_PROVIDER`

### Crash Logs

If Terraform ever crashes (a "panic" in the Go runtime), it saves a log file with the debug logs from the session as well as the panic message and backtrace to `crash.log`.

## Terraform Modules

The Standard Module Structure is a file and directory layout recommend for module development.

The primary entry point is the Root Module.

These are required files in the root directory:

- `main.tf` - the entry point file of your module
- `variables.tf` – variable that can be passed in
- `outputs.tf` – Outputed values
- `README` – Describes how the module works
- `LICENSE` – The license under which this module is available

Nested modules that are optional must be contained in the `modules/` directory:

- A submodule that contains a README is considered usable by external users
- A submodule that does not contain a README is considered internal use only
- Avoid using relative paths when sourcing module blocks.

## Terraform Workflows

The core Terraform workflow has three steps:

- Write
- Plan
- Apply

In most cases, you will work within a team. For teams the steps are the same, how they are performed varies. A common way looks like this:

- Write: The code is kept in a git repository. When you want to change something you create a branch from main, write your code, create a pull/merge request, it gets approved and merged into main.
- Plan: When a btanch is ready to be integrated on Pull Request, an execution plan can be generated and displayed within the pull request for review
- Apply: This is usually done through tools such as GitHub Actions which will run the steps to apply the configuration from the main branch.

It is very similar on Terraform Cloud. Since Terraform Cloud will integrate with git. The only change is who applies the configuration. In this case the Terraform Cloud Runtime.

## Backends

We talked about backends before. We will focus on protecting sensitive data here.

Terraform State file can contain sensitive data eg. long-lived AWS Credentials and is a possible attack vector for malicious actors.

- Local State
  - When using local backend, state is stored in plain-text JSON files.
  - You need to be careful you don’t share this state file with anyone
  - You need to be careful you don’t commit this file to your git repository
- Remote State with Terraform Cloud
  - That state file is held in memory and is not persisted to disk
  - The state file is encrypted-at-rest
  - The state file is encrypted-in-transit
  - With Terraform Enterprise you have detailed audit logging for tamper evidence
Remote State with Third-Party Storage
  - You can store state with various third-party backends.
  - You need to carefully review your backends capabilities to determine if will meet your security and compliance requirements.

When executing a remote plan or apply in a CLI-driven run, an archive of your configuration directory is uploaded to Terraform Cloud.

You can define paths to ignore from upload via a `.terraformignore` file at the root of your configuration directory.

If this file is not present, the archive will exclude the following by default:

- `.git`/ directories
- `.terraform`/ directories (exclusive of .terraform/modules)

`.terraformignore` works just like a .gitignore with the only difference is that you cannot have multiple .terraformignore files in subdirectories.

## Resources and Complex Types

## Built-In Functions

## Terraform Cloud 2

## Terraform Enterprise

## Workspaces

## Sentinel with Terraform

## HashiCorp Packer

## Consul

## Vault

## Misc

## Sources

- [ExamPro Certification Course](https://app.exampro.co/student/journey/terraform)
- [Terraform Best Practices](https://www.terraform-best-practices.com/)
