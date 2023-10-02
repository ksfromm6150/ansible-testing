variable "aws_region" {
  type    = string
  default = "us-east-1"
}

provider "aws" {
  region = var.aws_region
  assume_role {
    role_arn = "arn:aws:iam::131828561891:role/gh-actions-dev"
  }
}
