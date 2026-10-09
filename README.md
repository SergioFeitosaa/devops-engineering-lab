# ⚙️ DevOps Engineering Lab

**Laboratório prático de DevOps, automação, infraestrutura como código, segurança de containers e CI/CD.**

Repositório dedicado à implementação e documentação de práticas de engenharia de DevOps, com foco em automação, segurança, versionamento, infraestrutura como código e execução de pipelines.

O objetivo é transformar conhecimentos teóricos em implementações práticas, documentadas e reproduzíveis, registrando a evolução técnica por meio de atividades, experimentos e melhorias contínuas.

[![GitHub](https://img.shields.io/badge/GitHub-Repository-181717?logo=github)](https://github.com/SergioFeitosaa/devops-engineering-lab)
[![Git](https://img.shields.io/badge/Version_Control-Git-F05032?logo=git&logoColor=white)](https://git-scm.com/)
[![GitHub Actions](https://img.shields.io/badge/CI%2FCD-GitHub_Actions-2088FF?logo=githubactions&logoColor=white)](https://docs.github.com/actions)
[![Docker](https://img.shields.io/badge/Containers-Docker-2496ED?logo=docker&logoColor=white)](https://www.docker.com/)
[![Terraform](https://img.shields.io/badge/IaC-Terraform-844FBA?logo=terraform&logoColor=white)](https://developer.hashicorp.com/terraform)

---

## 🎯 Objetivos do laboratório

- Desenvolver habilidades práticas em DevOps e automação.
- Implementar pipelines de CI/CD com GitHub Actions.
- Aplicar princípios de segurança no gerenciamento de containers e informações sensíveis.
- Estudar infraestrutura como código (IaC) com Terraform.
- Utilizar Git e GitHub para versionamento e rastreabilidade das mudanças.
- Documentar decisões técnicas, procedimentos de validação e resultados obtidos.
- Construir uma base prática para projetos de engenharia de software e infraestrutura.

## 🧪 Atividades e projetos

### 1. Hardening de Containers

**Foco:** segurança e configuração de containers.

Implementação de melhorias de segurança em uma aplicação containerizada, com atenção à redução de privilégios, controle de recursos e redução da exposição desnecessária de serviços.

**Práticas trabalhadas:**
- Utilização de imagem base mais específica.
- Execução da aplicação com usuário não privilegiado.
- Uso de `.dockerignore` para excluir arquivos desnecessários do contexto de build.
- Proteção de configurações sensíveis e uso de variáveis de ambiente.
- Limitação de consumo de CPU e memória.
- Redução da exposição de portas e serviços.
- Validação da execução da aplicação e dos containers.

**Tecnologias:** Docker, Docker Compose, Node.js e Git.

📂 [Acessar os arquivos da atividade](./docker/atividade-hardening-container/)

📄 [Consultar a documentação de Hardening](./docker/atividade-hardening-container/HARDENING.md)

### 2. GitHub Secrets e CI/CD

**Foco:** gerenciamento de informações sensíveis em pipelines de automação.

Modificação de um workflow do GitHub Actions para remover um valor sensível do arquivo YAML e disponibilizá-lo à aplicação Node.js por meio de um GitHub Secret e de uma variável de ambiente.

**Práticas trabalhadas:**
- Configuração de Repository Secrets no GitHub.
- Referência a secrets em workflows.
- Uso de variáveis de ambiente em aplicações Node.js.
- Execução automatizada de etapas com GitHub Actions.
- Validação do recebimento da variável pela aplicação.
- Prevenção da exposição desnecessária de informações sensíveis nos logs.
- Organização do workflow na estrutura reconhecida pelo GitHub Actions.

**Tecnologias:** Git, GitHub, GitHub Actions e Node.js.

📂 [Acessar a atividade GitHub Secrets](./github/atividade-github-secrets/)

📄 [Consultar a documentação e as respostas da atividade](./github/atividade-github-secrets/README.md)

🚀 [Consultar as execuções do GitHub Actions](./actions)

### 3. Terraform — Infraestrutura como Código

**Foco:** estudo e prática de Infrastructure as Code (IaC).

Laboratório dedicado ao aprendizado de Terraform e à organização de configurações de infraestrutura como código, buscando tornar a definição e a manutenção de recursos mais estruturadas, versionáveis e reproduzíveis.

**Competências trabalhadas:**
- Organização de arquivos de configuração Terraform.
- Declaração e parametrização de recursos.
- Versionamento das configurações de infraestrutura.
- Documentação de variáveis, saídas e decisões técnicas, conforme o escopo implementado.
- Estudo do ciclo de validação e planejamento de mudanças de infraestrutura.

**Tecnologia principal:** Terraform.

📂 [Acessar o laboratório Terraform](./terraform/)

> O escopo e os recursos efetivamente implementados devem ser consultados na documentação específica desse laboratório.

---

## 🛠️ Tecnologias e ferramentas

| Tecnologia | Aplicação no laboratório |
|---|---|
| Git e GitHub | Versionamento, histórico de alterações e colaboração |
| GitHub Actions | Automação de workflows e execução de pipelines |
| Docker | Construção e execução de containers |
| Docker Compose | Orquestração local de serviços containerizados |
| Node.js | Aplicações utilizadas nos exercícios práticos |
| Terraform | Estudo de infraestrutura como código |
| YAML | Configuração de workflows e serviços |

## 🔐 Princípios técnicos

Este laboratório busca aplicar os seguintes princípios:

- **Security by design:** considerar segurança desde a configuração inicial.
- **Least privilege:** reduzir privilégios e permissões ao mínimo necessário.
- **Secrets management:** manter informações sensíveis fora do código versionado.
- **Automation:** automatizar tarefas repetitivas e verificações sempre que aplicável.
- **Reproducibility:** documentar procedimentos para facilitar a reprodução dos exercícios.
- **Traceability:** manter alterações registradas no histórico do Git.
- **Continuous improvement:** revisar configurações, identificar limitações e implementar melhorias progressivamente.

## 📁 Organização do repositório

```text
devops-engineering-lab/
├── .github/
│   └── workflows/
│       └── github-secrets-demo.yml
├── docker/
│   └── atividade-hardening-container/
│       ├── app/
│       ├── docs/
│       ├── Dockerfile
│       ├── docker-compose.yml
│       ├── HARDENING.md
│       └── README.md
├── github/
│   └── atividade-github-secrets/
│       ├── .github/
│       │   └── workflows/
│       │       └── main.yml
│       ├── app/
│       ├── docs/
│       └── README.md
├── terraform/
└── README.md
```

A estrutura representa a organização planejada das atividades. Arquivos e diretórios adicionais podem existir conforme a evolução do laboratório.

## 📈 Evolução contínua

O laboratório será ampliado progressivamente com novos exercícios, incluindo:

- Aprimoramento de pipelines de CI/CD.
- Testes automatizados e verificações de qualidade.
- Construção e validação de imagens Docker.
- Gerenciamento seguro de configurações e credenciais.
- Infraestrutura como código.
- Monitoramento, observabilidade e práticas de confiabilidade.
- Documentação de decisões e resolução de problemas técnicos.

Novas atividades serão adicionadas conforme forem implementadas e validadas.

## 👨‍💻 Sobre

Sou estudante de Análise e Desenvolvimento de Sistemas e estou desenvolvendo competências práticas em DevOps, automação, cloud computing e engenharia de software.

Este repositório registra minha jornada de aprendizado por meio de projetos, experimentos técnicos e documentação, com foco na aplicação de boas práticas e na construção de soluções reproduzíveis.

**Objetivo profissional:** desenvolver competências para atuar em ambientes de engenharia de software e DevOps, contribuindo para processos de entrega mais seguros, automatizados e confiáveis.

---

## 🔗 Contato e projetos

- **GitHub:** [@SergioFeitosaa](https://github.com/SergioFeitosaa)
- **Laboratório:** [devops-engineering-lab](https://github.com/SergioFeitosaa/devops-engineering-lab)

---

*Este laboratório está em desenvolvimento contínuo. As atividades são exercícios práticos de aprendizado, documentados de acordo com seu estágio de implementação e validação.*