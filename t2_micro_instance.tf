provider "aws" {
  access_key = "ACCESS_KEY_ID"
  secret_key = "SECRET_KEY"
  region     = "eu-west-3"
}

resource "aws_instance" "example" {
  ami           = "ami-9a03b5e7"
  instance_type = "t2.micro"
}
