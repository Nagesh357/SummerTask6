provider "aws" {

region = "us-east-1"
profile = "default"
access_key = "XXXXXXXXXXXXXX"
secret_key = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

resource "aws_instance" "os1"{

ami = "ami-0d5eff06f840b45e9"
instance_type = "t2.micro"
tags = {
 Name = "FaceR-check-instance"
  }
}


output "my_os1_public_ip_is" {
value = aws_instance.os1.public_ip
}

resource "aws_ebs_volume" "st1" {
  availability_zone = aws_instance.os1.availability_zone
  size              = 5

  tags = {
    Name = "CV-check-Volume"
  }
}


resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.st1.id
  instance_id = aws_instance.os1.id
}