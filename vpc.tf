resource "aws_vpc" "eng89_brittany_vpc_terra" {
  cidr_block = "10.104.0.0/16"

  tags = {
      Name = "eng89_brittany_vpc_terra"
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

resource "aws_subnet" "eng89_brittany_subnet_private_terra" {
  vpc_id     = aws_vpc.eng89_brittany_vpc_terra.id
  cidr_block = "10.104.2.0/24"
  map_public_ip_on_launch = false
  availability_zone = "eu-west-1a"

  tags = {
    Name = "eng89_brittany_subnet_private_terra"
  }
}
