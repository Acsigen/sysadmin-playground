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

### Resources

Resources in configuration files represent infrastructure objects e.g. Virtual Machines, Databases, Virtual Network Components, Storage.

A resource belongs to a provider.

Some resource types provide a special timeouts nested block argument that allows you to customize how long certain operations are allowed to take before being considered to have failed.

### Complex Types

A complex type is a type that groups multiple values into a single value.

Complex types are represented by type constructors, but several of them also have shorthand keyword versions.

There are two categories of complex types:

- Collection types (for grouping similar values)
  - List, Map, Set
- Structural types (for grouping potentially dissimilar values)
  - Tuple, Object

### Collection Types

A collection type allows multiple values of one other type to be grouped together as a single value.

The type of value within a collection is called its element type.

The three kinds of collection type list, map, set.

- List – It's like an array, you use an integer as the index to retrieve the value
- Map – It's like a ruby hash or single nested JSON object. You use a key as the index to retrieve the value
- Set – Is similar to a list but has no secondary index or preserved ordering, all values must be of the same type and will be cast to match based on the first element

### Structural Types

A structural type allows multiple values of several distinct types to be grouped together as a single value.

Structural types require a schema as an argument, to specify which types are allowed for which elements.

The two kinds of structural type: object and tuple

- Object is a map with more explicit keying `object({ name=string, age=number })`
- Tuple. Multiple return types with parameters `tuple([string, number, bool])`

## Built-In Functions

Terraform language includes a number of built-in functions that you can call from within expressions to transform and combine values:

- Numeric Functions
- String Functions
- Collection Functions
- Encoding Functions
- Filesystem Functions
- Date and Time Functions
- Hash and Crypto Functions
- IP Network Functions
- Type Conversion Functions

### Numeric Functions

- `abs` returns the absolute value of the given number
- `floor` returns the closest whole number that is less than or equal to the given value, which may be a fraction
- `Log` returns the logarithm of a given number in a given base
- `ceil` returns the closest whole number that is greater than or equal to the given value
- `min` takes one or more numbers and returns the smallest number from the set
- `max` takes one or more numbers and returns the greatest number from the set
- `parseint` parses the given string as a representation of an integer in the specified base and returns the resulting number
- `pow` calculates an exponent, by raising its first argument to the power of the second argument.
- `signum` determines the sign of a number, returning a number between -1 and 1 to represent the sign

### String Functions

- `chomp` removes newline characters at the end of a string.
- `format` produces a string by formatting a number of other values according to a specification string
- `formatlist` produces a list of strings by formatting a number of other values according to a specification string
- `indent` adds a given number of spaces to the beginnings of all but the first line in a given multi-line string
- `join` produces a string by concatenating together all elements of a given list of strings with the given delimiter
- `lower` converts all cased letters in the given string to lowercase.
- `regex` applies a regular expression to a string and returns the matching substrings
- `regexall` applies a regular expression to a string and returns a list of all matches
- `replace` searches a given string for another given substring, and replaces each occurrence with a given replacement string
- `split` produces a list by dividing a given string at all occurrences of a given separator.
- `strrev` reverses the characters in a string
- `substr` extracts a substring from a given string by offset and length
- `title` converts the first letter of each word in the given string to uppercase
- `trim` removes the specified characters from the start and end of the given string
- `trimprefix` removes the specified prefix from the start of the given string. If the string does not start with the prefix, the string is returned unchanged
- `trimsuffix` removes the specified suffix from the end of the given string
- `trimspace` removes all types of whitespace from both the start and the end of a string
- `upper` converts all cased letters in the given string to uppercase

### Collection Functions

- `alltrue` returns true if all elements in a given collection are true or "true". It also returns true if the collection is empty.
- `anytrue` returns true if any element in a given collection is true or "true". It also returns false if the collection is empty
- `chunklist` splits a single list into fixed-size chunks, returning a list of lists
- `coalesce` takes any number of arguments and returns the first one that isn't null or an empty string
- `coalescelist` takes any number of list arguments and returns the first one that isn't empty
- `compact` takes a list of strings and returns a new list with any empty string elements removed
- `concat` takes two or more lists and combines them into a single list
- `contains` determines whether a given list or set contains a given single value as one of its elements
- `distinct` takes a list and returns a new list with any duplicate elements removed
- `element` retrieves a single element from a list
- `index` finds the element index for a given value in a list
- `flatten` takes a list and replaces any elements that are lists with a flattened sequence of the list contents
- `keys` takes a map and returns a list containing the keys from that map
- `length` determines the length of a given list, map, or string
- `lookup` retrieves the value of a single element from a map, given its key. If the given key does not exist, the given default value is returned instead.
- `matchkeys` constructs a new list by taking a subset of elements from one list whose indexes match the corresponding indexes of values in another list
- `merge` takes an arbitrary number of maps or objects, and returns a single map or object that contains a merged set of elements from all arguments
- `one` takes a list, set, or tuple value with either zero or one elements. If the collection is empty, one returns null. Otherwise, one returns the first element. If there are two or more elements then one will return an error
- `range` generates a list of numbers using a start value, a limit value, and a step value
- `reserve` takes a sequence and produces a new sequence of the same length with all of the same elements as the given sequence but in reverse order
- `setintersection` function takes multiple sets and produces a single set containing only the elements that all of the given sets have in common. In other words, it computes the intersection of the sets
- `setproduct` function finds all of the possible combinations of elements from all of the given sets by computing the Cartesian product.
- `Setsubtract` function returns a new set containing the elements from the first set that are not present in the second set. In other words, it computes the relative complement of the first set in the second set
- `setunion` function takes multiple sets and produces a single set containing the elements from all of the given sets. In other words, it computes the union of the sets
- `slice` extracts some consecutive elements from within a list
- `sort` takes a list of strings and returns a new list with those strings sorted lexicographically
- `sum` takes a list or set of numbers and returns the sum of those numbers
- `transpose` takes a map of lists of strings and swaps the keys and values to produce a new map of lists of strings
- `values` takes a map and returns a list containing the values of the elements in that map
- `zipmap` constructs a map from a list of keys and a corresponding list of values

### Encoding and Decoding Functions

- encode
  - base64encode
  - jsonencode
  - textencodebase64
  - Yamlencode
  - base64gzip
  - urlencode
- decode
  - base64decode
  - csvdecode
  - jsondecode
  - textdecodebase64
  - yamldecode

### Filesystem Functions

- `abspath` takes a string containing a filesystem path and converts it to an absolute path. That is, if the path is not absolute, it will be joined with the current working directory
- `dirname` takes a string containing a filesystem path and removes the last portion from it.
- `pathexpand` takes a filesystem path that might begin with a ~ segment, and if so it replaces that segment with the current user's home directory path
- `basename` takes a string containing a filesystem path and removes all except the last portion from it
- `file` reads the contents of a file at the given path and returns them as a string
- `fileexists` determines whether a file exists at a given path
- `fileset` enumerates a set of regular file names given a path and pattern
- `filebase64` reads the contents of a file at the given path and returns them as a base64-encoded string
- `templatefile` reads the file at the given path and renders its content as a template using a supplied set of template variables

### Date and Time Functions

- `formatdate` converts a timestamp into a different time format
- `timeadd` adds a duration to a timestamp, returning a new timestamp
- `timestamp` returns a UTC timestamp string in RFC 3339 format

### Hash and Crypto Functions

- `base64sha256`
- `base64sha512`
- `bcrypt`
- `filebase64sha256`
- `filebase64sha512`
- `filemd5`
- `filesha1`
- `filesha256`
- `filesha512`
- `md5`
- `rsadecrypt`
- `sha1`
- `sha256`
- `sha512`
- `uuid`
- `uuidv5`

### IP Network Functions

- `cidrhost` calculates a full host IP address for a given host number within a given IP network address prefix
- `cidrnetmask` converts an IPv4 address prefix given in CIDR notation into a subnet mask address
- `cidrsubnet` calculates a subnet address within given IP network address prefix
- `cidrsubnets` calculates a sequence of consecutive IP address ranges within a particular CIDR prefix.

### Type Conversion Functions

- `can` evaluates the given expression and returns a boolean value indicating whether the expression produced a result without any errors
- `defaults` a specialized function intended for use with input variables whose type constraints are object types or collections of object types that include optional attributes
- `nonsensitive` takes a sensitive value and returns a copy of that value with the sensitive marking removed, thereby exposing the sensitive value
- `sensitive` takes any value and returns a copy of it marked so that Terraform will treat it as sensitive, with the same meaning and behavior as for sensitive input variables.
- `tobool` converts its argument to a boolean value
- `tomap` converts its argument to a map value
- `toset` converts its argument to a set value.
- `tolist` converts its argument to a list value
- `tonumber` converts its argument to a number value
- `tostring` converts its argument to a set value
- `try` evaluates all of its argument expressions in turn and returns the result of the first one that does not produce any errors

## Terraform Cloud 2

- Organizations
  - An organization is a collection of workspaces
- Workspaces
  - A workspace belongs to an organization
  - A workspace represents a unique environment or stack.
- Teams
  - A team is composed of multiple members (users).
  - A team can be assigned to workspaces
- Runs
  - A run represents a single run of the terraform run environment that is operating on an execution plan.
  - Runs can be UI/VCS driven API driven or CLI driven

### Workflows

Terraform Cloud offers 3 types of Cloud Run Workflows:

- UI/VCS Driven (User Interface and Version Control System)
  - Terraform Cloud is integrated with a specific branch in your VCS eg. Github via webhooks.
  - Whenever pull requests are submitted for the branch speculative plans are generated
  - Whenever a merge occurs to that branch, than a run is triggered on Terraform Cloud
- API-Driven (Application Programming Interface)
  - Workspaces are not directly associated with a VCS repo, and runs are not driven by webhooks on your VCS provider
  - A third-party tool or system will trigger runs via upload a configuration file via the Terraform Cloud API
  - The configuration file is a bash script that is packaged in an archive (.tar.gz). You are pushing a Configuration Version
- CLI-Driven (Command Line Interface)
  - Runs are triggered by the user running terraform CLI commands e.g. terraform apply and plan locally on their own machine.

### Permissions

- Organization-Level Permissions manage certain resources or settings across an organization
  - Manage Policies - create, edit, and delete the organization's Sentinel policies
  - Manage Policy Overrides - override soft-mandatory policy checks.
  - Manage Workspaces - create and administrate all workspaces within the organization
  - Manage VCS Settings - set of VCS providers and SSH keys available within the organization
- Workspace-Level Permissions manage resources and settings for a specific workspace
  - Granular permissions you can apply to a user via custom workspace permissions
    - Read runs
    - Queue plans
    - Apply runs
    - Lock and unlock workspaces
    - Download sentinel mocks
    - Read variable
    - Read and write variables
    - Read state outputs
    - Read state versions
    - Read and write state versions
  - Fixed Permission Sets
    - Read
      - Read runs
      - Read variables
      - Read state versions
    - Plan
      - Queue Plans
      - Read variables
      - Read state versions
    - Write
      - Apply runs
      - Lock and unlock workspaces
      - Download Sentinel mocks
      - Read and write variables
      - Read and write state versions

### API Tokens

Terraform Cloud supports three types of API Tokens. User, Team, and Organization Tokens.

- Organization API Tokens
  - Have permissions across the entire organization
  - Each organization can have one valid API token at a time
  - Only organization owners can generate or revoke an organization's token.
  - Organization API tokens are designed for creating and configuring workspaces and teams. 
    - Not recommended as an all-purpose interface to Terraform Cloud
- Team API Tokens
  - allow access to the workspaces that the team has access to, without being tied to any specific user
  - Each team can have one valid API token at a time
  - any member of a team can generate or revoke that team's token
  - When a token is regenerated, the previous token immediately becomes invalid
  - designed for performing API operations on workspaces.
  - same access level to the workspaces the team has access to
- User API Tokens
  - Most flexible token type because they inherit permissions from the user they are associated with
  - Could be for a real user or a machine user.

### Cost Estimation

- Cost Estimation is a feature to get a monthly cost of resources to display alongside your runs.
- Cost Estimation is available with Teams and Governance plan and above
- Cost Estimation is only for specific cloud resources for AWS, Azure, and GCP.
- You can use a Sentinel Policy to assert the expectation that resources are under a particular cost.

### Terraform Cloud Agents

- Terraform Cloud Agents is a paid feature of the Business plan to allow Terraform Cloud to communicate with isolated, private, or on-premise infrastructure.
- This is useful for on-premise infrastructure types such as vSphere, Nutanix, or OpenStack
- The agent architecture is pull-based, so no inbound connectivity is required
- Any agent you provision will poll Terraform Cloud for work and carry out the execution of that work locally.

## Terraform Enterprise

Terraform Enterprise is the self-hosted distribution of Terraform Platform

Terraform Enterprise offers a private instance of the Terraform Platform application with benefits such as:

- no resource limits
- with additional enterprise-grade architectural features
- Audit logging
- SAML single sign-on (SSO)

## Workspaces

Workplaces allow you to manage multiple environments or alternate state files. eg. Development, Production

There are two variants of workspaces:

- CLI Workspaces – A way of managing alternate state files (locally or via remote backends)
- Terraform Cloud Workspaces – acts like completely separate working directories

By default, you already have a single workspace in your local backend called default

Depending on if a local or remote backend changes how the state file is stored

- Local State
  - Terraform stores the workspace states in a folder called terraform.tfstate.d
  - In practice, individuals or very small teams will have been known to commit these files to their repositories.
  - Using a remote backend instead is recommended when there are multiple collaborators
- Remote State
  - The workspace files are stored directly in the configured backend.

You can reference the current workspace name via `terraform.workspace`.

## Sentinel with Terraform

Sentinel is an embedded policy-as-code framework integrated with the Terraform Platform.

- Benefits of Policy as Code
  - Sandboxing – The ability to create guardrails to avoid dangerous actions or remove the need for manual verification
  - Codification – The policies are well documented and exactly represent what is enforced
  - Version Control – Easy to modify or iterate on policies, with a chain of history of changes over time
  - Testing - syntax and behavior can be easily validated with Sentinel, ensuring policies are configured as expected
  - Automation – policies existing as code allow you direct integrate policies in various systems to auto-remediate, notify.
- Sentinel and Policy as Code
  - Language - All Sentinel policies are written using the Sentinel language
  - Designed to be non-programmer and programmer-friendly, embeddable and safe.
  - Development - Sentinel provides a CLI for development and testing.
  - Testing - Sentinel provides a test framework designed specifically for automation.

A Sentinel with Terraform workflow looks like this: SCM (GitHub) &rarr; Terraform Cloud &rarr; `plan` &rarr; Sentinel Policies &rarr; `apply` &rarr; New Infrastructure

Within Terraform Cloud you can create a Policy Set and apply these to a Terraform Cloud Workspace

## HashiCorp Packer

Packer is a developer tool to provision a build image that will be stored in a repository.

Using a build image before you deploy provides:

- immutable infrastructure
- your VMs in your fleet are all one-to-one in configuration
- Faster deploys for multiple servers after each build
- Earlier detection and intervention of package changes or deprecation of old technology

A workflow looks like this:

- Commit changes to a git repo which triggers a CI/CD process
- The CI/CD runs on a worker with Packer installed which builds the image
- Packer uses a provisioner (usually Ansible) to provision the image
- The image is then stored in a cloud storage solution (e.g. AWS S3)
- We then use Terraform to reference that image in our code and deploy the infrastructure

Packer is not a service but a development tool so you need to manually run packer or automate the building of images with a build server running packer.

## Consul

Consul is a service networking platform that provides:

- service discovery – central registry for services in the network
  - Allows for direct communication, no single point of failure via load balancers
- service mesh – managing network traffic between services
  - A communication layer on top of your container application, think middleware
- application configuration capabilities

Consul is useful when you have a micro-service or service-oriented architecture with hundred or thousands of services (containerized apps or workloads).

Consul integrates with Terraform in the following ways:

- Remote backend
  - Consul has a Key Value (KV) Store to store configurations
- Consul Provider

## Vault

Vault is a tool for securely accessing secrets from multiple secrets data stores.

Vault is deployed to a server where:

- Vault Admins can directly manage secrets
- Operators (developers) can access secrets via an API

Vault provides a unified interface:

- to any secret
  - AWS Secrets, Consul Key Value, Google Cloud KMS, Azure Service principles.
- providing tight access control
  - Just-in-Time (JIT) - reducing surface attack based on range of time
  - Just Enough Privilege (JeP) - reducing service attack by providing least-permissive permissions
- recording a detailed audit log – tamper evidence

## Misc

### Atlantis

[Atlantis](https://www.runatlantis.io) is an open-source developer tool to automate Terraform Pull Requests. Atlantis was built as an alternative to Terraform Cloud automation.

### Terragrunt

Terragrunt is a thin wrapper for Terraform that provides extra tools for:

- keeping your configurations DRY
- working with multiple Terraform modules
- managing remote state.

Don’t-Repeat-Yourself (DRY) is a programming methodology to abstract repeated code into functions, modules, or libraries and often isolate files to reduce code complexity effort and errors.

Terragrunt can work around the limitations of Terraform in a variety of ways.

- One example is providing dynamic values to a provider on the definition which cannot be done with Terraform.
- Terragrunt supports better granularity for modules by reducing lots of boilerplate.
- This is important when you need to start writing UnitTests for your infrastructure

## Sources

- [ExamPro Certification Course](https://app.exampro.co/student/journey/terraform)
- [Terraform Best Practices](https://www.terraform-best-practices.com/)
