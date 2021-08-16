# IAC with Terraform 
![terraform_logo](img/1280px-Terraform_Logo.svg.png)

IaC has two parts:
- Configuartion Mangement: 
  - They help configure and test machines to a specific state.
  - Systems - Puppet, Chef and ansible
- Orchestration:
  - These tools focus on networking and architecture rather than the configuration of individual machines. 
  - Terraform, Ansible

## What is Terraform 
- Terraform is an open-source infrastructure as code software tool. 

- It is a tool for building, changing and versioning infrastructure safely and efficiently. 

- Terraform enables developers to use a high-level configuration language called HCL (HashiCorp Configuration Language) to describe the desired “end-state”

- Terraform files are created with a .tf extention

- Terraform allows for rapid create of instances using AMIs

## Why Terraform
There are a few key reasons developers choose to use Terraform over other Infrastructure as Code tools:

1. **Open source**: Terraform is backed by large communities of contributors who build plugins to the platform. 

2. **Platform agnostic**: Meaning you can use it with any cloud services provider. Most other IaC tools are designed to work with single cloud provider.

3. **Immutable infrastructure**: Terraform provisions immutable infrastructure, which means that with each change to the environment, the current configuration is replaced with a new one that accounts for the change, and the infrastructure is reprovisioned. Even better, previous configurations can be retained as versions to enable rollbacks if necessary or desired.

![img](img/Terraform-1.png)

## Terraform Installation 

- [Manual installation of terraform](https://www.terraform.io/downloads.html)

- Linux installation:

1. The Terraform packages are signed using a private key controlled by HashiCorp, so in most situations the first step would be to configure your system to trust that HashiCorp key for package authentication. For example:

```
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
```

2. After registering the key, you can add the official HashiCorp repository to your system:

```
sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
```
3. To install Terraform from the new repository:

```
sudo apt install terraform
```

## Terraform commands

- `terraform init`: Prepare your working directory for other commands
- `terraform validate`: Check whether the configuration is valid
- `terraform plan`: Show changes required by the current configuration
- `terraform apply`: Create or update infrastructure
- `terraform destroy`: Destroy previously-created infrastructure

## Creating a VPC using IaC Terraform

![img](img/Untitled-1.jpg)

#### Step 1: Create env variable
For mac users, use the following command: 

```
 sudo echo "export AWS_ACCESS_KEY_ID=<Your access key>" >> ~/.bashrc
  sudo echo "export AWS_SECRET_ACCESS_KEY=<Your secret key>" >> ~/.bashrc
 source ~/.bashrc

```
#### Step 2: Set provider 

Let's build a script to connect to AWS and download/setup all dependencies required 

- Specify a cloud provider and region 

```
# define the region to launch the ec2 instance in Ireland
provider "aws" {
	region = "eu-west-1"
}

```

- Initialize terraform: `terraform init`

*There is no need to specify access/secret keys, Terraform will look for the keys stored as environment variables*

#### Step 3: Launch EC2 instance with Resources 

Resources are the most important element in the Terraform language

Each resource block describes one or more infrastructure objects, such as

- virtual networks
- compute instances
- higher-level components such as DNS records

A resource block declares a resource of a given type, and a given local name which can be used to refer to the resource from elsewhere in the same Terraform module

The resource type and name together serve as an identifier for a given resource and so must be unique within a module

```
resource "aws_instance" "app_instance"{
	# add the AMI id between "" as below
	ami = "ami-038d7b856fe7557b3"

	# Let's add the type of instance we would like launch
	instance_type = "t2.micro"

    # Need to enable public IP for our app
    associate_public_ip_address = true
   
    # Tags is to give name to our instance
    tags = {
        Name = "eng89_brittany_terraform"
    } 

    key_name = "brittany_aws"
}

```
- Now run `terraform plan` the `terraform apply`