terraform {
  backend "s3" {
    bucket                  = "myterraform-72784883"
    key                     = "terraform.tfstate"
    region                  = "us-east-1"
  }
  required_version = ">= 0.13.7"
}

provider "aws" {
  region = "us-east-1"
}
