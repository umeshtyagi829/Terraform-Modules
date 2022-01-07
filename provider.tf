terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.68.0"
    }
  }
}

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      environment = "training"
      Owner       = "utyagi@presidio.com"
    }
  }
}

