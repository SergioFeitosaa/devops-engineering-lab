# Consulta informações sobre a região configurada no Google Cloud.
# Data sources permitem consultar dados existentes sem criar recursos.
data "google_compute_regions" "available" {
  project = var.project_id
}