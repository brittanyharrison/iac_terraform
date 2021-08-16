# define the region to launch the ec2 instance in Ireland
provider "aws" {
	region = var.region
}

resource "aws_instance" "app_instance"{
	# add the AMI id between "" as below
	ami = "ami-038d7b856fe7557b3"

	# Let's add the type of instance we would like launch
	instance_type = var.instance_type

    # Need to enable public IP for our app
    associate_public_ip_address = true
   
    # Tags is to give name to our instance
    tags = {
        Name = "eng89_brittany_terraform"
    } 

    key_name = var.aws_key_name
}

resource "aws_vpc" "main" {
  cidr_block = "10.104.0.0/16"

  tags = {
      Name = "eng89_brittany_vpc_terraform"
  }
}
