# Exibe o ID da rede VPC criada pelo Terraform.
# O output facilita a identificação do recurso após o provisionamento.
output "network_id" {
  description = "ID da rede VPC criada pelo Terraform."
  value       = google_compute_network.vpc_network.id
}

# Exibe o nome da rede VPC.
output "network_name" {
  description = "Nome da rede VPC criada pelo Terraform."
  value       = google_compute_network.vpc_network.name
}

# Exibe a quantidade de regiões retornadas pelo Data Source.
# Esse output demonstra como utilizar informações consultadas
# através de um Data Source.
output "available_regions_count" {
  description = "Quantidade de regiões disponíveis retornadas pelo Data Source."
  value       = length(data.google_compute_regions.available.names)
}