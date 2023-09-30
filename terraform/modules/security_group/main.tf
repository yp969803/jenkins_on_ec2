#Variable where we will pass in the ID of our VPC

variable "vpc_id" {
  description = "ID of the VPC"
  type = string
}

#Variable where we will pass in our IP address from the secretd file

variable "my_ip" {
    description = "My IP address"
    type = string  
}

# Creating a security group named tutorial_jenkins_sg
# Remember, this security group is for our Jenkins EC2 instance
resource "aws_security_group" "tutorial_jenkins_sg" {
  name = "tutorial_jenkins_sg"
  description = "Security group for jenkins server"
  vpc_id = var.vpc_id
  ingress {
    description = "Allow all trafic through port 8080"
    from_port = "8080"
    to_port = "8080"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


ingress{
    description="Allow SSH from my computer"
    from_port="22"
    to_port="22"
    protocol="tcp"
    cidr_blocks=["${var.my_ip}/32"]
}

egress {
    description = "Allow all outbound traffic"
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}

tags = {
  Name="tutorial_jenkins_sg"
}
}