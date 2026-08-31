# Terraform - Google Cloud

## 📌 Sobre o projeto

Este diretório contém a implementação prática de Infrastructure as Code (IaC) utilizando Terraform e o provider do Google Cloud.

O objetivo desta atividade é aplicar os conceitos estudados em aula relacionados à definição declarativa de infraestrutura, providers, resources, variables, data sources e outputs.

A configuração foi desenvolvida com base na documentação oficial do Terraform e do provider Google Cloud.

> **Observação:** a conexão com o Google Cloud não foi realizada nesta etapa, conforme permitido na atividade. O projeto contém os códigos Terraform necessários para o provisionamento, mas nenhum recurso real foi criado na Cloud.

---

## 🎯 Objetivos

- Praticar Infrastructure as Code (IaC).
- Utilizar Terraform para definir infraestrutura.
- Configurar o provider do Google Cloud.
- Criar uma rede VPC utilizando Terraform.
- Utilizar variáveis para parametrizar a infraestrutura.
- Utilizar `terraform.tfvars` para fornecer valores às variáveis.
- Utilizar Data Sources para consultar informações existentes.
- Utilizar Outputs para disponibilizar informações dos recursos.
- Organizar o código Terraform de forma modular e legível.
- Versionar os arquivos utilizando Git e GitHub.

---

## 🏗️ Estrutura do projeto

```text
google-cloud/
├── .gitignore
├── data.tf
├── main.tf
├── outputs.tf
├── terraform.tfvars
├── variables.tf
└── README.md