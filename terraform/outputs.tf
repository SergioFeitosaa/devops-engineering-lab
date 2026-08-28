# Exibe o nome do bucket S3 gerenciado pelo Terraform.
output "bucket_name" {
  description = "Nome do bucket S3 gerenciado pelo Terraform."
  value       = aws_s3_bucket.terraform_bucket.bucket
}

# Exibe o ID do bucket S3.
output "bucket_id" {
  description = "Identificador do bucket S3."
  value       = aws_s3_bucket.terraform_bucket.id
}