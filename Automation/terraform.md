# Terraform

## ToC

* [Authentication](#authentication)
* [Variables](#variables)
* [Looping with dynamic blocks](#looping-with-dynamic-blocks)
* [Destroy](#destroy)
* [Modules](#modules)
* [Reference resources](#reference-resources)
* [Build basic AWS infrastructure](#build-basic-aws-infrastructure)

## Authentication

**The authentication method used below is not recommended.**

1. Install the AWS CLI Console.
2. In VSCode create a configuration file with the following contents:

    ```terraform
    provider "aws" {
        region = "us-east-1"
        access_key = <access-key>
        secret_key = <secret-key>
    }
    resource "aws_vpc" "my_vpc" {
        cidr_block = "10.0.0.0/16"
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

There are three other ways to pass the credentials to terraform:

1. First method is using *AWS CLI*. Remove the `access_key` and `secret_key` from the terraform file and run `aws configure` where you will be prompted to insert your keys. Then, when you apply the terraform configurations, it will use the credentials from the CLI automatically.
2. Use environment variables: `export AWS_ACCESS_KEY_ID=<key>` and `export AWS_SECRET_KEY_ID-<key>` (on Windows is `setx`).
3. Use a vault provider

## Variables

### Define variables

Terraform supports variables. A good practice is to create a folder named *variables* and inside it put a *main.tf* file.

Variables have three parameters, they are all optional:

* description - A simple description
* default - Default value
* type - Value type (string, boolean, list, etc.)

The main variable types are presented here:

```terraform
# Define a string variable
variable "vpc_name" {
  type = string
  default = "myvpc"
}

# Define an integer variable
variable "ssh_port" {
  type = number
  default = 22
}

# Define a boolean variable
variable "enabled" {
  default = true
}

# Define a list variable
variable "my_list" {
  type = list(string) # The data type inside the list goes between ()
  default = ["value1","value2"] # The index starts at 0
}

# Define map variable (key:value pair)
variable "my_map" {
  type = map
  default = {
      key1 = "value1"
      key2 = "value2"
  }
}

# Define tuple variable
# A tuple is like a list that can hold multiple types of data
variable "my_tuple" {
  type = tuple([string, number, string])
  default = ["value1", 1, "value2"]
}

# Define object variable
# An object is like a map that can hold multiple types of data
variable "my_object" {
  type = object({name = string, port = list(number)})
  default = {
    name = "value1"
    port = [22, 80, 443]
  }
}
```

### Call variables

In this example we will set the VPC name by calling a variable we defined:

```terraform
# Variable callback
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/24"
  
  tags = {
    Name = var.vpc_name # or you can use "${var.vpc_name}" for versions <= 0.11
  }
}

# List variable callback
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/24"
  
  tags = {
    Name = var.my_list[0] # or you can use "${var.my_list[0]}" for versions <= 0.11
  }
}

# Map variable callback
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/24"
  
  tags = {
    Name = var.my_map["key1"] # or you can use "${var.my_map["key2"]}" for versions <= 0.11
  }
}
```

There is another type of variable called *input variable*, this will prompt the user to input the value of the variable when you run `terraform plan`:

```terraform
variable "input_name" {
  type = string
  description = "Enter VPC name"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/24"
  
  tags = {
    Name = var.input_name # or you can use "${var.input_name}" for versions <= 0.11
  }
}
```

Sometimes it is useful to print some data on the screen. For this, we use the *output* variable to display the VPC id that we just created:

```terraform
output "vpc_id" {
  value = aws_vpc.my_vpc.id
}
```

These values are called *Attribures References* and they can be found in [Terraform documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc#attributes-reference).

**The output variable will be prompted only for `terraform apply` because is a computed value.**

For any variable that does not have a default value, terraform will prompt the user to enter the value.  
This also happens when you want to destroy the resource, in that case just press ```Enter```.

Variables values can be passed as a command line argument:

```bash
terraform apply -var "subnet_prefix=10.0.1.0/24"
```

Variables values can also be stored inside a `.tfvar` file like this:

```terraform
subnet_prefix = "10.0.1.0/24"
```

## Looping with dynamic blocks

Use a FOR loop to iterate through a list and assign those values to a resource. In this case, define a list of ports and assign them dynamically to a security group by using a dynamic block.

```terraform
# Declare a variable containing the ports
variable "ingress_ports" {
  type = list(number)
  default = [80, 443]
}

# Create a dynamic block to add a security group that allows the ports specified in the variable
resource "aws_security_group" "allow_web" {
  name = "Allow Web traffic"
  dynamic "ingress" {
    # Declare an iterator operator
    iterator = port

    # The for loop
    for_each = var.ingress_ports
    
    # The contents of the block
    content {
      # Refference the current value
      from_port = port.value
      to_port = port.value
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
```

## Destroy

Run the following command to terminate the resources created with terraform's current configuration:

```bash
terraform destroy
```

## Modules

A module is a folder inside our project that contains code.

In this example we have a module namedm *ec2* in which we placed a file named `ec2.tf`. It contains the variables and the EC2 instance declaration.

The contents of `main.tf`:

```terraform
# Declare the module
module "ec2_module" {
  
  # Set the source to <current-folder/ec2>
  source = "./ec2"
  
  # Set the value for ec2_name variable wich will be passed to the ec2 resource
  ec2_name = "Ubuntu 20.04 Apache"
}
```

The contents of `ec2/ec2.tf`:

```terraform
variable "ec2_name" {
  # Do not set a default value
  type = stirng
}

resource "aws_instance" "my_ec2" {
  ami = "ami-032598fcc7e9d1c7a"
  instance_type = "t2.micro"

  tags = {
    # Set the name of the instance 
    Name = var.ec2_name
  }
}
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
# Create basic EC2 instance
resource "aws_instance" "my_ec2" {
  ami = "ami-032598fcc7e9d1c7a"
  instance_type = "t2.micro"
}

# Assign the IP
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

## Sources

* [Free Code Camp YouTube Channel](https://www.youtube.com/watch?v=SLB_c_ayRMo)
