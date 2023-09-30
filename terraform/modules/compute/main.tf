variable "security_group" {
  description = "The security groups assigned to the jenkins server"
}

variable "public_subnet" {
  description="This public subnet IDs assigned to the jenkins server"
}

#This data store is holding the most recent ubuntu 20.04 image
data "aws_ami" "ubuntu" {
  most_recent = "true"
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}

#Creating an ec2 instance called jenkins_Server

resource "aws_instance" "jenkins_server" {
  # ami = data.aws_ami.ubuntu.id 
  ami= "ami-0f5ee92e2d63afc18"
  subnet_id = var.public_subnet
  instance_type = "t2.micro"
  vpc_security_group_ids = [var.security_group]
  key_name = "yash2"
  tags={
    Name="jenkins_server"
  }

}

resource "aws_eip" "jenkins_eip" {
  #Attching it to the jenkins server ec2 intance
  instance = aws_instance.jenkins_server.id 
  #Making sure it is inside the vpc
  vpc=true
  tags = {
    Name="jenkins_eip"
  }
}