# Terraform - Infrastructure as Code

## 📌 Sobre o projeto

Este diretório contém a implementação prática dos conceitos de **Infrastructure as Code (IaC)** utilizando **Terraform**, desenvolvida durante a formação em DevOps.

O objetivo deste laboratório é compreender, na prática, como uma infraestrutura pode ser definida de forma declarativa, organizada em código, versionada e posteriormente provisionada de maneira automatizada.

Neste primeiro exercício, foi estruturada uma configuração para gerenciamento de um **bucket Amazon S3**, utilizando o provider da AWS.

> **Observação:** nesta etapa, a configuração foi desenvolvida e validada localmente, sem provisionamento de recursos reais na AWS.

---

## 🎯 Objetivos

- Compreender os fundamentos de Infrastructure as Code (IaC).
- Conhecer a estrutura básica de um projeto Terraform.
- Configurar um provider.
- Declarar recursos de infraestrutura.
- Utilizar variáveis para parametrizar configurações.
- Utilizar outputs para disponibilizar informações dos recursos.
- Aplicar boas práticas de organização de código.
- Utilizar Git para versionamento da infraestrutura.
- Compreender a importância do `.gitignore` em projetos Terraform.

---

## 🏗️ Estrutura do projeto

```text
terraform/
│
├── README.md
├── main.tf
├── variables.tf
├── outputs.tf
└── .gitignore# Terraform - Infrastructure as Code

## 📌 Sobre o projeto

Este diretório contém a implementação prática dos conceitos de **Infrastructure as Code (IaC)** utilizando **Terraform**, desenvolvida durante a formação em DevOps.

O objetivo deste laboratório é compreender, na prática, como uma infraestrutura pode ser definida de forma declarativa, organizada em código, versionada e posteriormente provisionada de maneira automatizada.

Neste primeiro exercício, foi estruturada uma configuração para gerenciamento de um **bucket Amazon S3**, utilizando o provider da AWS.

> **Observação:** nesta etapa, a configuração foi desenvolvida e validada localmente, sem provisionamento de recursos reais na AWS.

---

## 🎯 Objetivos

- Compreender os fundamentos de Infrastructure as Code (IaC).
- Conhecer a estrutura básica de um projeto Terraform.
- Configurar um provider.
- Declarar recursos de infraestrutura.
- Utilizar variáveis para parametrizar configurações.
- Utilizar outputs para disponibilizar informações dos recursos.
- Aplicar boas práticas de organização de código.
- Utilizar Git para versionamento da infraestrutura.
- Compreender a importância do `.gitignore` em projetos Terraform.

---

## 🏗️ Estrutura do projeto

```text
terraform/
│
├── README.md
├── main.tf
├── variables.tf
├── outputs.tf
└── .gitignore