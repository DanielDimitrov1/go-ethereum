terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.65"
    }
  }


  backend "s3" {
    encrypt = true
    bucket  = "tfstate-file-store"
    region  = "eu-west-1"
    key     = "state"
  }
}
