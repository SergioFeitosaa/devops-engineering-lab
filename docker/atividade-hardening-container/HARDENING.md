
# Relatório de Hardening de Containers

## 1. Objetivo

Esta atividade tem como objetivo analisar a configuração inicial de uma aplicação executada em containers Docker, identificar riscos de segurança e aplicar medidas de hardening, preservando o funcionamento da aplicação.

O trabalho considera os princípios de redução da superfície de ataque, menor privilégio, proteção de informações sensíveis, restrição de exposição de serviços e controle de recursos.

## 2. Diagnóstico inicial

A análise foi realizada sobre os arquivos originais `Dockerfile`, `docker-compose.yml`, `app/server.js` e `app/package.json`.

### 2.1 Imagem-base

**Problema identificado:** o Dockerfile original utilizava `ubuntu:latest`.

**Risco:** a tag `latest` não fixa uma versão específica, podendo resultar em imagens diferentes entre builds. Além disso, utilizar uma imagem genérica e instalar manualmente o Node.js e o npm pode incluir componentes desnecessários.

### 2.2 Instalação de dependências

**Problema identificado:** o Dockerfile executava `npm install` no diretório `/app`, mas o arquivo `package.json` estava dentro de `app/`.

**Evidência:** o build original falhou com `ENOENT`, informando que `/app/package.json` não foi encontrado.

**Risco:** a configuração impedia a construção da imagem e precisava ser corrigida antes da validação funcional.

### 2.3 Funcionamento da aplicação

**Problema identificado:** o `server.js` original executava apenas `console.log()`, sem iniciar um servidor HTTP. O `package.json` também estava vazio.

**Risco:** a configuração publicava a porta 3000, mas o código original não disponibilizava um serviço HTTP nessa porta.

**Limitação do diagnóstico:** não foi possível comprovar o funcionamento inicial da aplicação porque o build falhou antes da execução.

### 2.4 Privilégios de execução

**Problema identificado:** o Dockerfile original não declarava um usuário por meio da instrução `USER`.

**Risco:** sem uma configuração explícita, a aplicação pode executar como `root`, dependendo da imagem-base, aumentando o impacto potencial de um comprometimento.

### 2.5 Informações sensíveis

**Problemas identificados:**
- O Dockerfile original definia `DB_PASSWORD=123456`.
- O Compose original definia `MYSQL_ROOT_PASSWORD: root`.

**Risco:** credenciais escritas diretamente em arquivos do projeto podem ser expostas por meio do código versionado ou de configurações e camadas da imagem.

### 2.6 Exposição de serviços

**Problema identificado:** o Compose original publicava as portas 3000 da aplicação e 3306 do MySQL.

**Risco:** a publicação da porta do banco permitia tentativas de conexão a partir do host sem que a necessidade dessa exposição estivesse demonstrada.

### 2.7 Controle de recursos

**Problema identificado:** o Compose original não declarava limites explícitos de CPU ou memória para os serviços.

**Risco:** o consumo excessivo de recursos por um container pode prejudicar outros processos e serviços no host.

### 2.8 Configurações de isolamento

Nos arquivos analisados, não foram identificadas declarações explícitas de montagem de volumes do host, modo privilegiado ou acesso ao socket Docker. Essa observação se limita às configurações inspecionadas e não representa uma auditoria completa do host.


## 3. Medidas aplicadas

### 3.1 Imagem-base e redução da superfície de ataque

O Dockerfile foi alterado para utilizar `node:22.20.0-bookworm-slim`, substituindo a imagem genérica `ubuntu:latest`.

A variante `slim` reduz a quantidade de componentes incluídos na imagem. Como a aplicação utiliza apenas o módulo HTTP nativo do Node.js, não é necessário instalar dependências externas.

**Objetivo:** reduzir componentes desnecessários e tornar o ambiente de execução mais previsível.

### 3.2 Correção funcional da aplicação

O `package.json` foi preenchido com os metadados do projeto e o script `start`.

O `server.js` foi atualizado para criar um servidor HTTP na porta 3000, utilizando o módulo nativo `node:http`.

O Dockerfile passou a copiar os arquivos de `app/` diretamente para `/app` e a iniciar a aplicação com `npm start`.

**Objetivo:** corrigir a falha original de build e permitir validar o funcionamento da aplicação antes de concluir as verificações de segurança.

**Observação:** essa correção funcional foi necessária porque o build original falhou e o código inicial não implementava um servidor HTTP.

### 3.3 Execução com menor privilégio

Foi adicionada a instrução `USER node` ao Dockerfile, e os arquivos da aplicação são copiados com propriedade atribuída ao usuário `node`.

A validação com `docker compose exec app id` retornou `uid=1000(node) gid=1000(node) groups=1000(node)`.

**Objetivo:** evitar executar a aplicação como usuário administrativo dentro do container e reduzir o impacto potencial de um comprometimento.

### 3.4 Gerenciamento de informações sensíveis

Foi criado o arquivo `.env` para armazenar as variáveis locais utilizadas pelo Compose.

O arquivo `.gitignore` contém a regra `.env`, e o comando `git check-ignore -v` confirmou que o Git ignora esse arquivo.

Também foi criado o `.env.example`, contendo os nomes das variáveis sem valores reais.

O Compose utiliza a variável `MYSQL_ROOT_PASSWORD` em vez de escrever diretamente a senha na configuração.

**Objetivo:** reduzir o risco de exposição acidental de credenciais em arquivos versionados.

**Limitação:** variáveis de ambiente não são, por si só, um mecanismo completo de gerenciamento de segredos. Em produção, devem ser considerados mecanismos próprios de secrets.

### 3.5 Redução da exposição de rede

A publicação da porta 3306 do MySQL foi removida do Compose. A aplicação continua publicando a porta 3000 para permitir o acesso HTTP local.

A configuração define os serviços na rede padrão criada pelo Docker Compose.

**Objetivo:** evitar a exposição desnecessária da porta do banco de dados no host.

**Limitação:** a aplicação atual não estabelece conexão com o MySQL. A comunicação entre os serviços não foi implementada nem validada funcionalmente.

### 3.6 Controle de recursos

Foram definidos limites de CPU e memória no Compose:

- Aplicação: 0,5 CPU e 128 MiB de memória.
- Banco de dados: 1 CPU e 512 MiB de memória.

O limite configurado para a aplicação foi verificado com `docker inspect`, retornando os valores esperados.

**Objetivo:** limitar o consumo de recursos do container e reduzir a possibilidade de que o uso excessivo afete outros serviços do host.

### 3.7 Configuração de execução

O Compose define `NODE_ENV=production` e a política de reinicialização `unless-stopped` para os serviços.

O Dockerfile utiliza `EXPOSE 3000` para documentar a porta da aplicação. Essa instrução não publica a porta por si só; a publicação é definida no Compose.

**Objetivo:** manter uma configuração de execução explícita e facilitar a operação do ambiente.


## 4. Evidências de validação

### 4.1 Construção da imagem

**Comando executado:**

```powershell
docker compose -f "C:\Users\SERGIO\OneDrive\Desktop\DevOps\devops-engineering-lab\docker\atividade-hardening-container\docker-compose.yml" build app
```

**Resultado:** a imagem `atividade-hardening-container-app` foi construída com sucesso.

### 4.2 Execução do container

**Comando executado:**

```powershell
docker compose -f "C:\Users\SERGIO\OneDrive\Desktop\DevOps\devops-engineering-lab\docker\atividade-hardening-container\docker-compose.yml" up -d app
```

**Resultado:** o container da aplicação foi iniciado.

### 4.3 Resposta HTTP

**Comando executado:**

```powershell
Invoke-RestMethod http://localhost:3000
```

**Resultado esperado e observado:** a aplicação retornou a mensagem `Olá, mundo! Aplicação executada com sucesso.`

### 4.4 Usuário efetivo

**Comando executado:**

```powershell
docker compose -f "C:\Users\SERGIO\OneDrive\Desktop\DevOps\devops-engineering-lab\docker\atividade-hardening-container\docker-compose.yml" exec app id
```

**Resultado observado:**

```text
uid=1000(node) gid=1000(node) groups=1000(node)
```

A evidência confirma que a aplicação executa com o usuário `node`, e não como `root`.

### 4.5 Proteção do arquivo de ambiente

**Comando executado:**

```powershell
git -C "C:\Users\SERGIO\OneDrive\Desktop\DevOps\devops-engineering-lab" check-ignore -v "docker/atividade-hardening-container/.env"
```

**Resultado observado:** o Git identificou a regra `.env` do `.gitignore` da atividade.

### 4.6 Configuração do Compose

**Comando executado:**

```powershell
docker compose -f "C:\Users\SERGIO\OneDrive\Desktop\DevOps\devops-engineering-lab\docker\atividade-hardening-container\docker-compose.yml" config --quiet
```

**Resultado:** o comando terminou sem apresentar erros.

### 4.7 Limites de recursos

O container da aplicação foi inspecionado com `docker inspect`.

**Valores configurados:**
- CPU: 0,5.
- Memória: 128 MiB.

Os valores esperados foram confirmados durante a validação.

### 4.8 Situação do banco de dados

O serviço MySQL foi iniciado por meio do Docker Compose e validado por meio da listagem dos containers e da análise dos logs.

Comando executado para verificar os serviços:

docker compose -f "C:\Users\SERGIO\OneDrive\Desktop\DevOps\devops-engineering-lab\docker\atividade-hardening-container\docker-compose.yml" ps

Resultado observado: os containers app e banco estavam em execução. A aplicação publicou a porta 3000 no host, enquanto o banco apresentou as portas internas 3306/tcp e 33060/tcp, sem mapeamento para o host.

Validação dos limites do banco:

docker inspect atividade-hardening-container-banco-1 --format "NanoCpus={{.HostConfig.NanoCpus}} Memory={{.HostConfig.Memory}}"

Resultado observado:

NanoCpus=1000000000 Memory=536870912

Os valores correspondem aos limites configurados de 1 CPU e 512 MiB de memória.

Validação dos logs: os registros do MySQL apresentaram a mensagem ready for connections, indicando que o servidor concluiu a inicialização e estava pronto para aceitar conexões.

A aplicação também foi testada por meio de uma requisição HTTP local após a inicialização do banco e continuou respondendo normalmente.

Limitação: a aplicação atual não implementa integração funcional com o banco de dados. Portanto, não foi validada uma consulta ou conexão real entre os dois serviços.

## 5. Análise final

### 5.1 Qual era o principal risco encontrado no projeto?

O projeto apresentava vários riscos, incluindo credenciais escritas diretamente nos arquivos, uso de uma imagem genérica, ausência de usuário de execução explícito, exposição da porta do banco de dados e falta de limites de recursos.

Um dos riscos mais importantes era a exposição de credenciais, pois senhas presentes em arquivos versionados podem ser compartilhadas ou utilizadas indevidamente. A configuração inicial também precisava ser corrigida para permitir a construção e execução da aplicação.

### 5.2 Qual alteração de hardening foi mais importante? Por quê?

A execução da aplicação com o usuário não administrativo `node` foi uma das medidas mais importantes, pois aplica o princípio do menor privilégio e reduz os privilégios disponíveis para um processo comprometido.

A proteção das credenciais e a redução da exposição de rede também são essenciais. As medidas atuam em conjunto, em vez de depender de uma única proteção.

### 5.3 O que poderia acontecer caso o container da aplicação fosse comprometido?

Um atacante poderia tentar explorar vulnerabilidades da aplicação, acessar dados e variáveis disponíveis no processo, realizar conexões de rede permitidas e consumir recursos do container.

A execução como usuário não administrativo e os limites de recursos ajudam a reduzir o impacto, mas não eliminam todos os riscos. O isolamento do container não deve ser tratado como uma garantia absoluta de segurança do host.

### 5.4 Como o princípio do menor privilégio foi aplicado?

A aplicação foi configurada para executar com `USER node`, e os arquivos foram copiados com propriedade atribuída a esse usuário.

A execução foi validada com o comando `id` dentro do container, que retornou UID e GID 1000 para o usuário `node`.

### 5.5 Por que o `.env` não deve ser enviado para o repositório?

O `.env` contém valores de configuração locais que podem incluir senhas e outras informações sensíveis. Versioná-lo pode expor essas informações a pessoas que não deveriam ter acesso a elas.

O arquivo foi incluído no `.gitignore`, e o comando `git check-ignore -v` confirmou que a regra de exclusão está sendo aplicada.

### 5.6 Qual é a função do `.env.example`?

O `.env.example` documenta os nomes das variáveis necessárias para configurar o ambiente, sem revelar seus valores reais.

Ele serve como modelo para que outros desenvolvedores criem seu próprio `.env` local.

### 5.7 Como o projeto poderia receber novas verificações de segurança automaticamente em uma pipeline CI/CD?

A pipeline poderia executar verificações automáticas durante o build e antes da publicação da imagem, incluindo:

- testes automatizados da aplicação;
- análise estática do código;
- análise de dependências;
- verificação de segredos no repositório;
- análise de vulnerabilidades da imagem Docker;
- validação do Dockerfile e do Docker Compose;
- verificação de que o container não executa como `root`;
- testes de inicialização e resposta HTTP.

Os resultados poderiam impedir a publicação de uma imagem quando fossem identificadas falhas críticas, conforme critérios definidos pela equipe.

### 5.8 Quais medidas adicionais poderiam ser aplicadas caso essa aplicação fosse executada em Kubernetes?

Em Kubernetes, poderiam ser adotadas medidas adicionais como:

- definir `runAsNonRoot` e `allowPrivilegeEscalation: false`;
- aplicar `readOnlyRootFilesystem`, quando compatível com a aplicação;
- remover capabilities Linux desnecessárias;
- definir `resources.requests` e `resources.limits`;
- utilizar Secrets com controles de acesso apropriados;
- aplicar políticas de rede para restringir a comunicação entre workloads;
- configurar probes de disponibilidade e inicialização;
- utilizar RBAC com permissões mínimas;
- verificar as imagens antes da implantação;
- aplicar políticas de segurança e monitoramento do cluster.

Essas medidas devem ser configuradas de acordo com as necessidades reais da aplicação e do ambiente.
