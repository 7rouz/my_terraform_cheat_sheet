variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "eu-west-3"
}
variable "AMIS" {
  type = "map"
  default = {
    eu-west-3 = "ami-9a03b5e7"
    eu-west-2 = "ami-506e8f37"
    eu-west-1 = "ami-74e6b80d"
  }
}
