# Define os providers necessários para o projeto Terraform.
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configura o provider AWS.
# A região é recebida através da variável aws_region.
provider "aws" {
  region = var.aws_region
}

# Define o bucket S3 que será gerenciado pelo Terraform.
# O nome do bucket é recebido através da variável bucket_name.
resource "aws_s3_bucket" "terraform_bucket" {
  bucket = var.bucket_name
}