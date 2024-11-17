# Specify the required Packer plugins
packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

# Define a variable for the AWS region, with a default value
#variable "region" {
#  default = "" # Default AWS region where the AMI will be built
#}

#variable "aws_access_key" {
#  default = "" # AWS access key, to be overridden by the variables file
#}

#variable "aws_secret_key" {
#  default = "" # AWS secret key, to be overridden by the variables file
#}

# Configure the Amazon EBS builder
source "amazon-ebs" "amazon_linux" {
  region             = "us-east-1" # Use the specified AWS region
  source_ami         = "ami-0166fe664262f664c" # Copied from amazon-liux ami
  instance_type      = "t2.micro" # Use a cost-effective instance type for the build process
  ami_name           = "custom-ami-cloudwatch-ssm-docker-{{timestamp}}" # Name the AMI with a unique timestamp
  ssh_username       = "ec2-user" # Default SSH user for Amazon Linux 2
  #access_key        = var.aws_access_key # Use the AWS access key from variables
  #ecret_key         = var.aws_secret_key # Use the AWS secret key from variables
} 

# Define the build process
build {
  name    = "amazon-linux-provisioning" # Name of the build process
  sources = ["source.amazon-ebs.amazon_linux"] # Reference the source configuration

  # Use a shell provisioner to run the external provisioning script
  provisioner "shell" {
    script = "./provisioner.sh" # Path to the external shell script for provisioning
  }
}
