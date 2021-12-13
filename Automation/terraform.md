# Terraform

## ToC

* [Intro](#intro)
* [Basic AWS EC2 deployment](#basic-aws-ec2-deployment)
* [Modify EC2 resources](#modify-ec2-resources)
* [Terminate EC2 instances](#terminate-ec2-instances)
* [Reference resources](#reference-resources)
* [Build basic AWS infrastructure](#build-basic-aws-infrastructure)
* [Output and Variables](#output-and-variables)

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
    
    # Test configuraiton (Dry run)
    terraform plan
    
    # This will take a while
    terraform apply
    ```

**By default these commands will apply all the ```.tf``` files in that folder and for each resource in those files.**

## Modify EC2 resources

If you run the same commands with the same config file, it will only update that specific instance.

In order to modify the instance, just change the parameters in the config file.

You can also change only specific resources of the config file with ```-target``` option.

```bash
terraforn apply -target aws_instance.New-EC2-instance
```

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

## Build basic AWS infrastructure

### Create a VPC

```terraform
resource "aws_vpc" "main-vpc" {
    cidr_block = "10.0.0.0/16"
    
    tags = {
      "Name" = "Production-VPC"
    }
}
```

### Create Internet Gateway

```terraform
resource "aws_internet_gateway" "main-internet-gateway" {
    vpc_id = aws_vpc.main-vpc.id
    
    tags = {
      "Name" = "Main Internet Gateway"
    }
}
```

### Create Custom Route Table

```terraform
resource "aws_route_table" "routing-table" {
    vpc_id = aws_vpc.main-vpc.id

    route = {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main-internet-gateway.id
    }

    route = {
        ipv6_cidr_block = "::/0"
        gateway_id = aws_internet_gateway.main-internet-gateway.id
    }

    tags = {
      "Name" = "Main routing table"
    }
}
```

### Create a subnet

```terraform
resource "aws_subnet" "main-subnet" {
    vpc_id = aws_vpc.main-vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"

    tags = {
      "Name" = "Main subnet"
    }
}
```

### Associate subnet with routing table

```terraform
resource "aws_route_table_association" "main-subnet-rt" {
    subnet_id = aws_subnet.main-subnet.id
    route_route_table_id = aws_route_table.routing-table.id 
}
```

### Create and configure security group

```terraform
resource "aws_security_group" "web" {
  name = "allow_tls"
  description = "Allow inbound traffic"
  vpc_id = aws_vpc.main-vpc.id

  ingress {
    description = "TLS from anywhere"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_block  = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description = "SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_block  = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Web"
  }
}
```

### Create a network interface

```terraform
resource "aws_network_interface" "main-nic" {
  subnet_id = aws_subnet.main-subnet.id
  private_ips = ["10.0.1.50"]
  security_groups = [aws_security_group.web.id]
  }
}
```

### Assign an elastic IP

You can assign an Elastic IP only if an internet gateway is already defined.

```terraform
resource "aws_eip" "elastic_ip" {
  instance = aws_instance.web.id
  vpc = true
  network_interface = aws_network_interface.main-nic.id
  associate_with_private_ip = "10.0.1.50"
  depends_on = [aws_internet_gateway.main-internet-gateway]
}
```

### Create AWS Ubuntu Linux server and install Apache2

```terraform
resource "aws_instance" "ubuntu-server" {
  ami = ami-0a49b025fffbbdac6
  instance_type = "t2.micro"
  availability_zone = "us-east-1a" # EC2 instance and subnet must be in the same Availability Zone
  key_name = "main-key" # SSH Key
  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.main-nic.id
  }
  
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update && sudo apt -y upgrade
              sudo apt install apache2 -y
              sudo systemctl start apache2
              sudo systemctl enable apache2
              EOF
  
  tags = {
    Name = "Ubuntu Server"
  }
}
```

## Output and Variables

### Output

To display a value at the end of the execution you can use the output command:

```terraform
output "server_public_ip" {
  value = aws_instance.ubuntu-server.public_ip
}
```

### Variables

Variables have three parameters:

* description - A simple description
* default - Default value (optional)
* type - Value type (String, Boolean, List, etc.)

Declare variable:

```terraform
variable "subnet_prefix" {
  description = "CIDR Block"
  default = "10.0.1.0/24"
  type = string
}
```

Reference a variable:

```terraform
cidr_block = var.subnet_prefix
```

For any variable that does not have a default value, terraform will prompt the user to enter the value.  
This also happens when you want to destroy the resource, in that case just press ```Enter```.

Variables values can also be stored inside a file. That file has the extension ```.tfvars``` and can have the following content:

```terraform
subnet_prefix = "10.0.1.0/24"
```

## Sources

* [Free Code Camp YouTube Channel](https://www.youtube.com/watch?v=SLB_c_ayRMo)
