# Define o ID do projeto no Google Cloud.
# Esse valor identifica o projeto onde a infraestrutura será provisionada.
variable "project_id" {
  type        = string
  description = "ID do projeto utilizado no Google Cloud."

  validation {
    condition     = length(trimspace(var.project_id)) > 0
    error_message = "O ID do projeto não pode ser vazio."
  }
}

# Define a região utilizada pelo provider do Google Cloud.
variable "region" {
  type        = string
  description = "Região do Google Cloud utilizada pelo projeto."

  validation {
    condition     = length(trimspace(var.region)) > 0
    error_message = "A região não pode ser vazia."
  }
}

# Define o nome da rede VPC.
variable "network_name" {
  type        = string
  description = "Nome da rede VPC criada pelo Terraform."

  validation {
    condition     = length(var.network_name) >= 1 && length(var.network_name) <= 63
    error_message = "O nome da rede deve possuir entre 1 e 63 caracteres."
  }
}