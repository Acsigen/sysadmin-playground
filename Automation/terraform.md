# Terraform

## ToC

* [Intro](#intro)
* [Basic AWS EC2 deployment](#basic-aws-ec2-deployment)
* [Modify EC2 resources](#modify-ec2-resources)
* [Terminate EC2 instances](#terminate-ec2-instances)
* [Reference resources](#reference-resources)

## Intro

Terraform files have the ```.tf``` extension.

## Basic AWS EC2 deployment

**The authentication method used below is not recommended.**

1. Install the AWS CLI Console.
2. In VSCode create a configuration file with the following contents:

    ```terraform
    provider "aws" {
        region = "us-east-1"
        access_key = <access-key>
        secret_key = <secret-key>
    }
    resource "aws_instance" "New-EC2-instance" {
        ami = "<aws-ami-id>"
        instance_type = "t2.micro"
    }
    ```

3. Open the terminal (```Terminal -> New Terminal```) and run:

    ```bash
    # Prepare environment
    terraform init
    
    # Test configuraiton
    terraform plan
    
    # This will take a while
    terraform apply
    ```

**By default these commands will apply all the ```.tf``` files in that folder and for each resource in those files.**

## Modify EC2 resources

If you run the same commands with the same config file, it will only update that specific instance.

In order to modify the instance, just change the parameters in the config file.

**If you comment out the parameters of a resource, or an entire resource, when you run ```terraform apply``` that resource will be deleted/terminated.**

## Terminate EC2 instances

Run the following command:

```bash
terraform destroy
```

## Reference resources

In this example we will create a VPC and assign a subnet.

In order to assign a subnet to a VPC, we need the ID of the VPC, but since it is not created yet, we will reference it.

```terraform
resource "aws_vpc" "main-vpc" {
    cidr_block = "10.0.0.0/16"
    
    tags = {
      "Name" = "Production-VPC"
    }
}

resource "aws_subnet" "subnet1" {
    # Reference aws_vpc id from main-vpc
    vpc_id = aws_vpc.main-vpc.id
    cidr_block = "10.0.0.0/24"
    
    tags = {
      "Name" = "production-subnet"
    }
}
```

