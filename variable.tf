variable "aws_key_name" {
    default = "eng89_brittany"
}

variable "aws_key_path" {
    default = "~/.ssh/eng89_brittany.pem"
}

variable "region" {
    default = "eu-west-1"
}

variable "instance_type"{
    default = "t2.micro"
}

variable "app_ami" {
    default = "ami-0f18a434af2396095"
}

variable "my_ip" {
    default = "81.134.180.37/32"

}

variable "vpc_id" {
    default = "vpc-0751802e1288b4dea"
  
}

variable "subnet_id" {
    default = "subnet-0cb055a0863f12127"
  
}

variable "app_sg" {
    default = "sg-0f9ee8580b0ff6179"
}