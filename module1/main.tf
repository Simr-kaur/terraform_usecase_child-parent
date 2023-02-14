resource "aws_instance" "ec2_example" {
	ami = var.ami_id
	instance_type = var.web_instance_type
	key_name = "aws_key"
	vpc_security_group_ids = [aws_security_group.main.id]


	user_data = <<-EOF
	#!/bin/sh
	sudo apt-get update
	sudo apt-get install -y apache2
	sudo systemctl status apache2
	sudo systemctl start apache2
	sudo chown -R $USER:$USER /var/www/html
	sudo echo "<html><body><h1>Hello this is module 1 instance"
	EOF
}

resource "aws_security_group" "main" {
	name = "EC2_webserver_SG_1"
	description = "Webserver for ec2 instances"

	ingress {
		from_port = 80
		protocol = "TCP"
		to_port = 80
		cidr_blocks = ["0.0.0.0/0"]
	}

	ingress {
                from_port = 22
                protocol = "TCP"
                to_port = 22
                cidr_blocks = ["0.0.0.0/0"]
        }

	egress {
                from_port = 0
                protocol = "-1"
                to_port = 0
                cidr_blocks = ["0.0.0.0/0"]
        }
}

resource "aws_key_pair" "deployer" {
        key_name = "aws_key"
        public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDFTOjeW4YpvXCvrpCjYRjjntLb8onkzbG7V0zB+8BB/aRtZOcXrI3vV11U0rDKm6pIGeAsDYo4z+TQVFFKMIuhzgVTybpkKsuTXpCvlYhz7fT/kptZCR2NwJdzlU4wRnZtcvhKM11YtWJKJ3bvemacL/pgI/Krt3X8LEyojVtQ9FzTrsBTDr8OaAayHQMeGs2jJvp2BdY3zUsNcq003Jxw30LQb6wDNOzCBxXln++mpmE6hPMzokAQUVaeGSlLlhLrBQ+IKf8u0KObf6wfEENZ0tja1b4cXm4FQ4E7B88hICKpd1d4qkAPNYLVfKukLCdaOl66OnhZCI6K2uKiqsZ1 simran.sk2904@gmail.com"

}


