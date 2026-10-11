# Kubernetes — Implantação de Aplicação com Minikube

## 1. Visão geral

Este projeto demonstra a implantação e o acesso a uma aplicação conteinerizada em um ambiente Kubernetes local, utilizando Minikube, Docker e manifestos declarativos em YAML.

A atividade tem como objetivo compreender os principais componentes da arquitetura Kubernetes e aplicar, na prática, os conceitos de Pod, Service, NodePort, Control Plane e gerenciamento de recursos por meio do `kubectl`.

O projeto faz parte do repositório **devops-engineering-lab**, destinado ao estudo prático de ferramentas e conceitos de DevOps.

## 2. Objetivos

- Compreender a arquitetura básica do Kubernetes.
- Executar uma aplicação conteinerizada em um Pod.
- Configurar um Service para disponibilizar acesso à aplicação.
- Utilizar manifestos YAML para declarar recursos Kubernetes.
- Inicializar e verificar um cluster local com Minikube.
- Testar o acesso à aplicação por meio do navegador.
- Documentar a arquitetura e os procedimentos de execução.

## 3. Tecnologias utilizadas

| Tecnologia | Finalidade |
|---|---|
| Docker | Construção e execução de contêineres. |
| Docker Hub | Armazenamento e distribuição da imagem da aplicação. |
| Kubernetes | Orquestração dos recursos da aplicação. |
| Minikube | Execução de um cluster Kubernetes local. |
| kubectl | Comunicação com o cluster e gerenciamento de recursos. |
| YAML | Definição declarativa dos recursos Kubernetes. |
| Draw.io | Elaboração do diagrama de arquitetura. |
| Visual Studio Code | Edição dos arquivos e execução dos comandos no terminal. |

## 4. Arquitetura da solução

A solução utiliza um cluster Kubernetes local executado pelo Minikube. A aplicação é executada em um contêiner dentro de um Pod, enquanto um Service do tipo NodePort fornece um ponto de acesso à aplicação.

O fluxo de acesso é:

1. O usuário solicita acesso à aplicação pelo navegador.
2. O Minikube disponibiliza uma URL local para acessar o Service.
3. O Service seleciona o Pod por meio do label `app: meu-app`.
4. O tráfego é encaminhado ao endpoint do Pod na porta 5000.
5. O contêiner executa a aplicação e retorna a resposta HTTP.

O gerenciamento do cluster ocorre por meio do `kubectl`, que envia solicitações à API do Kubernetes.

O diagrama completo está disponível em [`kubernetes.drawio`](kubernetes.drawio).

## 5. Componentes Kubernetes

### 5.1. Pod

O Pod é a menor unidade implantável do Kubernetes. Ele agrupa um ou mais contêineres que compartilham determinados recursos.

Neste projeto, o manifesto `pod.yml` declara o Pod `meu-app-pod`, que executa a imagem Docker Hub `sergiorfeitosa/meu_app_python:1.0`.

O Pod utiliza o label `app: meu-app`, que permite sua identificação pelo Service.

### 5.2. Service

O Service fornece um ponto de acesso estável para os Pods selecionados. Isso evita que os consumidores precisem conhecer diretamente o endereço IP temporário de um Pod.

Neste projeto, o arquivo `service.yml` define o Service `meu-app-service`, do tipo NodePort.

Configuração principal:

- Porta do Service: `5000`.
- Porta de destino do contêiner: `5000`.
- NodePort: `30080`.
- Seletor: `app: meu-app`.

### 5.3. NodePort

NodePort permite disponibilizar um Service por meio de uma porta do Node. Neste projeto, foi configurada a porta `30080`.

Como o ambiente utiliza Minikube com o driver Docker no Windows, o comando `minikube service meu-app-service --url` disponibilizou uma URL local para acesso à aplicação.

A URL observada durante o teste foi `http://127.0.0.1:59939`. Essa porta local é específica da execução e pode mudar em execuções futuras.

### 5.4. Control Plane

O Control Plane coordena o funcionamento do cluster Kubernetes.

Seus principais componentes conceituais incluem:

- **API Server:** recebe e valida solicitações à API do Kubernetes.
- **etcd:** armazena os dados do estado do cluster.
- **Scheduler:** seleciona um Node para executar Pods que precisam ser agendados.
- **Controller Manager:** executa controladores responsáveis por reconciliar o estado desejado dos recursos.

### 5.5. Componentes do Node

- **Kubelet:** acompanha a execução dos Pods no Node.
- **kube-proxy:** implementa regras de rede utilizadas pelos Services, conforme a configuração do cluster.

### 5.6. ReplicaSet

O ReplicaSet mantém o número desejado de réplicas de Pods. Ele costuma ser criado e gerenciado por um Deployment.

Nesta atividade, o ReplicaSet é apresentado no diagrama como conceito da arquitetura. Ele não foi criado durante a execução prática, pois o Pod foi implantado diretamente pelo manifesto `pod.yml`.

## 6. Estrutura do projeto

```text
kubernetes/
├── evidencias/
│   └── acesso-aplicacao.png
├── kubernetes.drawio
├── pod.yml
├── README.md
└── service.yml
```

- `kubernetes.drawio`: diagrama visual da arquitetura.
- `pod.yml`: manifesto declarativo do Pod.
- `service.yml`: manifesto declarativo do Service.
- `evidencias/acesso-aplicacao.png`: captura de tela do acesso à aplicação.
- `README.md`: documentação técnica da atividade.

## 7. Pré-requisitos

Antes de executar o projeto, é necessário ter:

- Docker Desktop instalado e em execução.
- kubectl instalado.
- Minikube instalado.
- Acesso à imagem `sergiorfeitosa/meu_app_python:1.0` no Docker Hub.
- Terminal PowerShell aberto na raiz do repositório.

A imagem utilizada deve estar disponível no Docker Hub e a aplicação deve escutar na porta 5000 para que a configuração atual funcione como esperado.

## 8. Como executar o projeto

Os comandos a seguir devem ser executados no terminal PowerShell, a partir da raiz do repositório `devops-engineering-lab`.

### 8.1. Iniciar o cluster

```powershell
minikube start --driver=docker
```

Verifique o estado do cluster:

```powershell
kubectl get nodes
```

O Node deve apresentar o estado `Ready`.

### 8.2. Implantar o Pod

```powershell
kubectl apply -f .\kubernetes\pod.yml
```

Verifique a execução:

```powershell
kubectl get pods
```

O Pod deverá apresentar o estado `Running` e o contêiner deverá estar pronto.

### 8.3. Implantar o Service

```powershell
kubectl apply -f .\kubernetes\service.yml
```

Verifique os Services:

```powershell
kubectl get services
```

O Service `meu-app-service` deverá aparecer com o tipo `NodePort`.

### 8.4. Verificar o endpoint

```powershell
kubectl get endpoints meu-app-service
```

Esse comando permite verificar se o Service encontrou um endereço de destino para encaminhar as requisições.

Em versões recentes do Kubernetes, o recurso Endpoints está obsoleto em favor do EndpointSlice. O comando acima foi utilizado nesta atividade para a verificação inicial.

### 8.5. Acessar a aplicação

```powershell
minikube service meu-app-service --url
```

Abra a URL retornada pelo comando no navegador.

No ambiente utilizado durante a atividade, a aplicação exibiu a mensagem:

**Olá! Meu primeiro aplicativo Docker!**

No Windows com o driver Docker, o comando pode precisar permanecer em execução no terminal para manter o acesso local disponível.

## 9. Resultados obtidos

Durante a execução prática, foram observados os seguintes resultados:

- O cluster Minikube ficou disponível e o Node apresentou o estado `Ready`.
- O Pod `meu-app-pod` ficou com status `Running`.
- O contêiner apresentou estado de prontidão `1/1`.
- O Service `meu-app-service` foi criado com o tipo `NodePort`.
- O Service encontrou o endpoint `10.244.0.3:5000`.
- A aplicação foi acessada pelo navegador por meio da URL local disponibilizada pelo Minikube.

Esses resultados demonstram a execução do Pod, a seleção do endpoint pelo Service e o acesso HTTP à aplicação no ambiente local.

## 10. Evidências

A captura de tela do navegador está disponível em:

[`evidencias/acesso-aplicacao.png`](evidencias/acesso-aplicacao.png)

O diagrama da arquitetura pode ser aberto no Draw.io pelo arquivo `kubernetes.drawio`.

Para complementar a documentação da execução, recomenda-se registrar também capturas do terminal mostrando:

- O Node com estado `Ready`.
- O Pod com estado `Running`.
- O Service com a porta NodePort.
- O endpoint associado ao Service.

## 11. Limitações e melhorias futuras

Esta atividade utiliza um Pod individual criado diretamente por um manifesto YAML. Em um cenário de produção, seria importante avaliar melhorias como:

- Utilização de Deployment para gerenciar réplicas e atualizações.
- Configuração de probes de readiness e liveness.
- Definição de requests e limits de CPU e memória.
- Uso de ConfigMaps e Secrets para configuração.
- Aplicação de políticas de segurança para contêineres.
- Implementação de monitoramento e logs.
- Automação de validações e implantação por meio de CI/CD.

Esses itens não fazem parte da implementação atual e podem ser explorados em atividades futuras.

## 12. Conclusão

A atividade permitiu praticar a implantação de uma aplicação conteinerizada em Kubernetes utilizando Minikube, manifestos YAML e um Service do tipo NodePort.

A execução demonstrou como o Pod hospeda a aplicação, como o Service seleciona o Pod por meio de labels e como o Minikube permite acessar o serviço localmente.

O projeto também documenta os principais componentes da arquitetura Kubernetes, relacionando os conceitos teóricos à experiência prática realizada.

---

**Repositório:** `devops-engineering-lab`  
**Diretório da atividade:** `kubernetes/`