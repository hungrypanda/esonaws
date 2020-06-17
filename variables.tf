variable "trusted_network" {
  description = "CIDR formatted IP (<IP Address>/32) or network that will be allowed access (you can use 0.0.0.0/0 for unrestricted access)"
}

variable "project_name" {
  description = "An idenfitying name used for names of cloud resources"
}

variable "aws_access_key" {
  description = "AWS access key"
}

variable "aws_secret_key" {
  description = "AWS secret key"
}

variable "aws_region" {
  default = "us-east-1"
}

variable "aws_ami_name" {
  default = "ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"
}

# The owner of the AMI
variable "aws_ami_owner" {
  default = "099720109477" # Canonical
}

variable "remote_user" {
  default = "ubuntu"
}

variable "zones" {
  type    = list(string)
  default = ["a","b","c"]
}

variable "public_key" {
  default = "~/.ssh/id_rsa.pub"
}

variable "private_key" {
  default = "~/.ssh/id_rsa"
}

variable "ece-version" {
  default="2.5.0"
}

variable "sleep-timeout" {
  default="30"
}

variable "cidr" {
  default = "192.168.100.0/24"
}

variable "aws_instance_type" {
  default = "t2.micro"

}

variable "device_name" {
  default = "xvda"
}