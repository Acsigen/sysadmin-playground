# Terraform

## ToC

* [Intro](#intro)
* [Basic AWS EC2 deployment](#basic-aws-ec2-deployment)
* [Modify EC2 resources](#modify-ec2-resources)

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

## Modify EC2 resources

If you run the same commands with the same config file, it will only update that specific instance.

In order to modify the instance, just change the parameters in the config file.
