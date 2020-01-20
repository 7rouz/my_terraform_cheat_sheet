variable "public_key_path" {
  description = <<DESCRIPTION
Path to the SSH public key to be used for authentication.
Ensure this keypair is added to your local SSH agent so provisioners can
connect.

Example: ~/.ssh/terraform.pub
DESCRIPTION
  default = "/home/ec2-user/.ssh/id_rsa.pub" 
}

variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "us-east-1"
}

variable "default_vpc_ids" {
    description = "AWS VPC to launch server in."
    default = {
        us-east-1 = "vpc-e2e0aa98"
        # need to update AMI ids for other regions 
        # eu-west-1 = "vpc-674cbc1e"
        # us-east-2 = "vpc-1d4e7a66"
        # us-west-2 = "vpc-8803e0f0"
    }
}

# amzn-ami-hvm-x86_64-gp2 Amazon AMI
variable "aws_amis" {
  default = {
    us-east-1 = "ami-0080e4c5bc078760e"
    # need to update AMI ids for other regions 
    # eu-west-1 = "ami-674cbc1e"
    # us-east-1 = "ami-1d4e7a66"
    # us-west-2 = "ami-8803e0f0"
  }
}
