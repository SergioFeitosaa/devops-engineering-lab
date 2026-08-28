# Define a região da AWS utilizada pelo provider.
variable "aws_region" {
  type        = string
  description = "Região da AWS onde os recursos serão provisionados."

  validation {
    condition     = length(trimspace(var.aws_region)) > 0
    error_message = "A região da AWS não pode ser vazia."
  }
}

# Define o nome do bucket S3.
variable "bucket_name" {
  type        = string
  description = "Nome globalmente único do bucket S3."

  validation {
    condition     = length(var.bucket_name) >= 3 && length(var.bucket_name) <= 63
    error_message = "O nome do bucket deve possuir entre 3 e 63 caracteres."
  }
}