# define the region to launch the ec2 instance in Ireland
provider "aws" {
	region = var.region
}

resource "aws_vpc" "eng89_brittany_vpc_terra" {
  cidr_block = "10.104.0.0/16"

  tags = {
      Name = "eng89_brittany_vpc_terra"
  }
}


resource "aws_internet_gateway" "eng89_brittany_igw_terra" {
  vpc_id = aws_vpc.eng89_brittany_vpc_terra.id

  tags = {
    Name = "eng89_brittany_igw_terra"
  }
}


resource "aws_subnet" "eng89_brittany_subnet_public_terra" {
  vpc_id     = aws_vpc.eng89_brittany_vpc_terra.id
  cidr_block = "10.104.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-west-1a"

  tags = {
    Name = "eng89_brittany_subnet_public_terra"
  }
}


resource "aws_route_table" "eng89_brittany_rt_terra" {
  vpc_id = aws_vpc.eng89_brittany_vpc_terra.id

  route  {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.eng89_brittany_igw_terra.id
    }

  tags = {
    Name = "eng89_brittany_rt_terra"
  }
}


resource "aws_route_table_association" "eng89_brittany_subnet_assoc" {
  route_table_id = aws_route_table.eng89_brittany_rt_terra.id
  subnet_id = aws_subnet.eng89_brittany_subnet_public_terra.id
}


resource "aws_network_acl" "eng89_brittany_public_nacl_terra" {
	vpc_id = aws_vpc.eng89_brittany_vpc_terra.id

	# allow HTTP from all
	ingress {
		protocol = "tcp"
		rule_no = 100
		action = "allow"
		cidr_block = "0.0.0.0/0"
		from_port = 80
		to_port = 80
	}

	# allow HTTPS from all
	ingress {
		protocol = "tcp"
		rule_no = 110
		action = "allow"
		cidr_block = "0.0.0.0/0"
		from_port = 443
		to_port = 443
	}

	# allow SSH from home
	ingress {
		protocol = "tcp"
		rule_no = 120
		action = "allow"
		cidr_block = var.my_ip
		from_port = 22
		to_port = 22
	}

	# allow ephemeral from all
	ingress {
		protocol = "tcp"
		rule_no = 130
		action = "allow"
		cidr_block = "0.0.0.0/0"
		from_port = 1024
		to_port = 65535
	}
	
	# allow HTTP to all
	egress {
		protocol = "tcp"
		rule_no = 100
		action = "allow"
		cidr_block = "0.0.0.0/0"
		from_port = 80
		to_port = 80
	}

	# allow HTTPS to all
	egress {
		protocol = "tcp"
		rule_no = 110
		action = "allow"
		cidr_block = "0.0.0.0/0"
		from_port = 443
		to_port = 443
	}

	# allow SSH to home
	egress {
		protocol = "tcp"
		rule_no = 120
		action = "allow"
		cidr_block = var.my_ip
		from_port = 22
		to_port = 22
	}

	# allow ephemeral to all
	egress {
		protocol = "tcp"
		rule_no = 130
		action = "allow"
		cidr_block = "0.0.0.0/0"
		from_port = 1024
		to_port = 65535
	}

	# allow 27017 to private subnet
	egress {
		protocol = "tcp"
		rule_no = 140
		action = "allow"
		cidr_block = "10.104.2.0/24"
		from_port = 27017
		to_port = 27017
	}

	tags = {
		Name = "eng89_brittany_nacl_public_terra"
	}
}


resource "aws_security_group" "eng89_brittany_sg_app_terra"{
	name = "eng89_brittany_sg_app_terra"
	description = "Allow public access for nodejs instnace"
	vpc_id = var.vpc_id

	ingress {
		description = "HTTP from all"
		from_port = 80
		to_port = 80
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	ingress {
		description = "HTTPS from all"
		from_port = 443
		to_port = 443
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	ingress {
		description = "SSH from home"
		from_port = 22
		to_port = 22
		protocol = "tcp"
		cidr_blocks = [var.my_ip]
	}

    ingress {
        description = "Allow access to port 3000"
        from_port =  3000
        to_port = 3000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

	tags = {
		Name = "eng89_brittany_sg_app_terra"
	}
}


resource "aws_instance" "app_instance"{
	ami = var.app_ami
	instance_type = var.instance_type
    associate_public_ip_address = true
    key_name = var.aws_key_name
    subnet_id = var.subnet_id
    vpc_security_group_ids = [var.app_sg]
    tags = {
        Name = "eng89_brittany_app_terra"
    } 

   
}


