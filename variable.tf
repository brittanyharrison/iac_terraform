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

variable "db_ami"{
    default = "ami-03b79bde6be632efd"
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
variable "private_subnet_id" {
    default = "subnet-0143b0240ee1a7ca2" 
  
}
variable "app_sg" {
    default = "sg-0f9ee8580b0ff6179"
}

variable "db_sg"{
    default = "sg-0698bb1ccfd7a46fc"
}

variable "mongodb_private_ip" {
    default = "mongodb://10.104.2.175:27017/posts"
  
}