variable "aws_key_name" {
    default = "eng89_brittany"
}

variable "aws_key_path" {
    default = "~/.ssh/eng89_brittany.pem"
}

variable "region" {
    default = "eu-west -1"
}

variable "instance_type"{
    default = "t2.micro"
}

variable "app_ami" {
    default = ""
}

variable "db_ami" {
    default = ""
}
