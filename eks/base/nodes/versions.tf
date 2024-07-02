terraform {
  required_version = "1.8.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.65.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0.0"
    }
  }
}
