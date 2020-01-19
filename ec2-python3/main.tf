# Specify the provider and access details
provider "aws" {
  region = var.aws_region
  version = "~> 2.45"  
}

# A security group to make EC2 accessible via ssh
resource "aws_security_group" "py3_ssh" {
  name        = "python3_ssh_sec_group"
  description = "Used in the terraform for python3 ec2"
  vpc_id      = lookup(var.default_vpc_ids, var.aws_region)

  # SSH access from anywhere                                                                                                           
  ingress {                                                                                                                            
    from_port   = 22                                                                                                                   
    to_port     = 22                                                                                                                   
    protocol    = "tcp"                                                                                                                
    cidr_blocks = ["0.0.0.0/0"]                                                                                                        
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_key_pair" "py3_key" {
  key_name   = "py3_key_pair"
  public_key = file(var.public_key_path)
}

resource "aws_instance" "py3" {
  # The connection block tells our provisioner how to
  # communicate with the instance
  connection {
    # The default username for our AMI
    user = "ec2-user"
    host = self.public_ip
    # The connection will use the local SSH agent for authentication.
  }

  instance_type = "t2.micro"

  # Lookup the correct AMI based on the region
  # we specified
  ami = lookup(var.aws_amis, var.aws_region)

  # The name of our SSH keypair we created above.
  key_name = aws_key_pair.py3_key.id

  # Our Security group to allow SSH access
  vpc_security_group_ids = ["${aws_security_group.py3_ssh.id}"]

  # We run a remote provisioner on the instance after creating it.
  # In this case, we just install git and python3
  provisioner "remote-exec" {
    inline = [
      "sudo yum -y update",
      "sudo yum -y git python3"
    ]
  }
}
