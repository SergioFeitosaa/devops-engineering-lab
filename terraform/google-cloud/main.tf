# Define os providers necessários para o projeto Terraform.
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }
  }
}

# Configura o provider do Google Cloud.
# O projeto e a região serão definidos por meio de variáveis.
provider "google" {
  project = var.project_id
  region  = var.region
}

# Cria uma rede VPC no Google Cloud.
# A rede utiliza subnets customizadas para permitir maior controle
# sobre a configuração da infraestrutura.
resource "google_compute_network" "vpc_network" {
  name                    = var.network_name
  auto_create_subnetworks = false
}