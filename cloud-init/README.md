# Laboratório Cloud-Init — Provisionamento Automatizado de Servidor

## 1. Visão geral

Este laboratório demonstra o provisionamento automatizado de uma máquina virtual Ubuntu utilizando **Vagrant, VirtualBox e Cloud-Init**.

O objetivo é configurar um ambiente básico de servidor DevOps de forma reproduzível, automatizando a criação de um usuário administrador, a instalação de Docker e Nginx e a publicação de uma página HTML personalizada.

A configuração é declarativa: as instruções de provisionamento ficam registradas em arquivos do projeto, facilitando a manutenção, a reprodução do ambiente e a compreensão das etapas de configuração.

## 2. Objetivos

- Automatizar a preparação de uma máquina virtual Ubuntu.
- Utilizar Cloud-Init para configurar o ambiente durante a inicialização.
- Criar um usuário administrador com permissões `sudo` sem solicitação de senha.
- Configurar autenticação SSH por chave pública.
- Instalar Docker e Nginx.
- Publicar uma página HTML personalizada por meio do Nginx.
- Configurar o encaminhamento de portas para acessar a página pelo navegador do host.
- Validar o estado dos serviços e o funcionamento da aplicação web.

## 3. Tecnologias utilizadas

| Tecnologia | Finalidade |
|---|---|
| Vagrant | Gerenciamento e provisionamento da máquina virtual |
| VirtualBox | Virtualização do sistema operacional |
| Ubuntu Server 22.04 LTS | Sistema operacional da máquina virtual |
| Cloud-Init | Automação da configuração inicial do servidor |
| Docker | Plataforma de containers instalada no servidor |
| Nginx | Servidor web responsável por disponibilizar a página HTML |
| YAML | Formato declarativo da configuração Cloud-Init |
| PowerShell | Execução dos comandos de gerenciamento no Windows |

## 4. Arquitetura do laboratório

O ambiente utiliza o Windows como sistema hospedeiro e uma máquina virtual Ubuntu executada no VirtualBox.

Durante a inicialização, o Vagrant transfere o arquivo de configuração para a máquina virtual e executa o script responsável por preparar o Cloud-Init e sua fonte de dados NoCloud.

O Cloud-Init processa as instruções de configuração, enquanto o Nginx disponibiliza a página HTML.

### Fluxo de provisionamento

```text
Windows
  |
  | Vagrant
  v
VirtualBox
  |
  v
Ubuntu Server 22.04
  |
  v
cloud-init_setup.sh
  |
  v
Cloud-Init / NoCloud
  |
  +--> Criação do usuário administrador
  |
  +--> Instalação do Docker
  |
  +--> Instalação do Nginx
  |
  +--> Criação da página HTML
  |
  v
Nginx disponibiliza a página
  |
  v
Navegador: http://localhost:8081
```

## 5. Estrutura dos arquivos

```text
cloud-init/
├── Vagrantfile
├── cloud-init_setup.sh
├── user-data.yaml
└── README.md
```

### `Vagrantfile`

Define a máquina virtual, a imagem Ubuntu, o hostname, a rede, o encaminhamento de portas e os provisionadores utilizados na inicialização.

A configuração do laboratório utiliza:

- Sistema operacional: Ubuntu Jammy 64 bits.
- Hostname: `servidor-devops`.
- Memória: 2048 MB.
- Processadores virtuais: 1.
- Porta do servidor web na VM: `80`.
- Porta de acesso no Windows: `8081`.

O encaminhamento de portas permite acessar o Nginx da máquina virtual pelo navegador do sistema hospedeiro.

### `cloud-init_setup.sh`

Script de preparação executado pelo Vagrant. Sua função é instalar ou verificar o Cloud-Init, disponibilizar o arquivo `user-data` na fonte NoCloud, criar os metadados da instância e preparar a configuração do datasource.

### `user-data.yaml`

Contém as instruções declarativas de configuração do Cloud-Init, incluindo:

- Atualização da lista de pacotes.
- Criação do diretório utilizado pela página web.
- Criação do usuário `meu-usuario`.
- Configuração do grupo administrativo `sudo`.
- Configuração de uma chave pública SSH autorizada.
- Instalação dos pacotes `docker.io` e `nginx`.
- Criação do arquivo `/var/www/html/index.html`.
- Inicialização e habilitação dos serviços Docker e Nginx.
- Inclusão do usuário no grupo `docker`.
- Registro de uma mensagem final nos logs.

**Segurança:** a autenticação SSH utiliza uma chave pública. A chave privada não deve ser armazenada no repositório nem incluída na documentação.

## 6. Como executar o laboratório

### Pré-requisitos

Antes de iniciar, verifique se os seguintes componentes estão instalados no Windows:

- Vagrant.
- Oracle VirtualBox.
- Git, caso deseje clonar o repositório.

O Docker Desktop não é obrigatório para este laboratório, pois o Docker é instalado dentro da máquina virtual Ubuntu.

### 6.1. Acessar a pasta

Abra o PowerShell na raiz do repositório e execute:

```powershell
cd .\cloud-init
```

### 6.2. Validar o Vagrantfile

```powershell
vagrant validate
```

Resultado esperado:

```text
Vagrantfile validated successfully.
```

### 6.3. Iniciar o ambiente

```powershell
vagrant up
```

Na primeira execução, o Vagrant poderá baixar a imagem Ubuntu e instalar os componentes necessários. Aguarde o término do provisionamento.

### 6.4. Consultar o estado da máquina

```powershell
vagrant status
```

A máquina deverá aparecer como `running (virtualbox)`.

### 6.5. Consultar o estado do Cloud-Init

```powershell
vagrant ssh -c "cloud-init status --long"
```

Após a conclusão da configuração, o estado esperado é:

```text
status: done
extended_status: done
```

### 6.6. Acessar a página

Abra o endereço abaixo no navegador do Windows:

http://localhost:8081

A página apresenta o título **Cloud-Init configurado com sucesso!**, acompanhado de informações sobre o ambiente DevOps, Docker e Nginx.

## 7. Validação do ambiente

Os seguintes comandos podem ser utilizados para verificar os componentes configurados.

### Verificar a existência do usuário

```powershell
vagrant ssh -c "id meu-usuario"
```

O resultado deve apresentar o usuário e seus grupos, incluindo `sudo` e `docker`.

### Verificar o Docker e o Nginx

```powershell
vagrant ssh -c "systemctl is-active docker && systemctl is-active nginx"
```

Resultado esperado:

```text
active
active
```

### Testar a página dentro da VM

```powershell
vagrant ssh -c "curl -i http://localhost/"
```

A resposta HTTP esperada é `200 OK`.

### Testar a página pelo Windows

```powershell
curl.exe -i http://localhost:8081/
```

A resposta esperada é `HTTP/1.1 200 OK`, seguida do conteúdo HTML personalizado.

## 8. Evidências de execução

Para documentar a execução da atividade, recomenda-se registrar as seguintes evidências:

1. Validação do `Vagrantfile`.
2. Estado da máquina virtual no Vagrant.
3. Estado final do Cloud-Init.
4. Existência do usuário `meu-usuario` e seus grupos.
5. Docker e Nginx com estado `active`.
6. Resposta HTTP `200 OK` no acesso local e no acesso pelo Windows.
7. Página HTML personalizada aberta no navegador.

As capturas de tela devem ser adicionadas ao repositório somente após serem registradas, preferencialmente em uma pasta `evidencias/`.

## 9. Observações de segurança e manutenção

- Não versionar chaves privadas SSH.
- Não incluir senhas ou outros segredos nos arquivos de configuração.
- Manter a configuração Cloud-Init e os scripts organizados e versionados.
- Utilizar o encaminhamento de portas definido no `Vagrantfile` para acessar os serviços.
- Antes de destruir ou recriar a VM, verificar se há arquivos ou configurações que precisem ser preservados.
- Em ambientes reais, revisar cuidadosamente as permissões administrativas e as regras de acesso aos serviços.

## 10. Conclusão

O laboratório demonstra como automatizar a configuração inicial de um servidor Linux com Cloud-Init, integrando virtualização, provisionamento e serviços de infraestrutura.

A atividade permite praticar conceitos importantes para a área de DevOps, como infraestrutura reproduzível, configuração declarativa, administração de serviços Linux, autenticação SSH e validação de aplicações por HTTP.

O resultado é um ambiente de laboratório que pode ser recriado e utilizado como base para estudos posteriores de containers, automação e integração contínua.

---

**Projeto:** Laboratório Cloud-Init  
**Repositório:** `devops-engineering-lab`  
**Diretório:** `cloud-init`