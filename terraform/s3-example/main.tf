terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

# Provider
provider "aws" {
  profile = "demo"
  region  = "${var.region}"
}

# Terraform
resource "aws_s3_bucket" "main" {
  bucket = "demo-bucket-0e0f6119-96c2-4aa3-819d-166930b95941"

  tags = {
    Project        = "${var.project_name}"
    Environment    = "Dev"
  }
}

resource "aws_s3_bucket_acl" "demo" {
  bucket = aws_s3_bucket.main.id
  acl    = "private"
}