
terraform {
  required_version = "~> 1.5.7"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.74.0"
    }
  }
}