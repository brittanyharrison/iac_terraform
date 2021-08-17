# define the region to launch the ec2 instance in Ireland
provider "aws" {
	region = var.region
}

resource "aws_instance" "db_instance" {
	ami = var.db_ami
	subnet_id = var.private_subnet_id
	instance_type = var.instance_type
	key_name = var.aws_key_name
	associate_public_ip_address = false
	vpc_security_group_ids = [var.db_sg]
	tags = {
		Name = "eng89_brittany_db_terra"
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
   
   connection {
		type = "ssh"
		user = "ubuntu"
		private_key = "${file(var.aws_key_path)}"
		host = "${self.associate_public_ip_address}"
	} 

	# export private ip of mongodb instance and start app
	provisioner "remote-exec"{
		inline = [
            "echo \"export DB_HOST=${var.mongodb_private_ip}\" >> /home/ubuntu/.bashrc",
			"cd app",
            "pm2 start app.js"
		]
	}
}