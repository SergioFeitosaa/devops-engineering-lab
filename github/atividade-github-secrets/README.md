# Atividade Prática — Utilização de GitHub Secrets

## 1. Objetivo

Compreender como utilizar o GitHub Secrets para armazenar informações sensíveis fora do código-fonte e disponibilizá-las de forma controlada a uma aplicação executada por uma pipeline de CI/CD com GitHub Actions.

## 2. Problema identificado

Na configuração inicial do workflow, a variável `MENSAGEM_SECRETA` possuía um valor literal diretamente no arquivo YAML.

Essa prática é inadequada porque o arquivo é versionado no Git e seu conteúdo pode ser visualizado por pessoas com acesso ao repositório. Além disso, o valor pode permanecer no histórico de commits mesmo após sua remoção do arquivo.

Se a informação fosse uma senha ou um token real, uma pessoa não autorizada poderia utilizá-la para tentar acessar recursos protegidos.

## 3. Solução implementada

Foi criado o GitHub Secret com o seguinte nome:

- **Nome:** `MENSAGEM_SECRETA`
- **Local de configuração:** Settings → Secrets and variables → Actions → Repository secrets.

O valor foi configurado diretamente nas definições do repositório no GitHub, sem ser inserido no código-fonte.

No workflow, a configuração foi alterada para:

```yaml
env:
  MENSAGEM_SECRETA: ${{ secrets.MENSAGEM_SECRETA }}
```

O workflow executável foi disponibilizado em `.github/workflows/github-secrets-demo.yml`, na raiz do repositório, conforme a estrutura exigida pelo GitHub Actions.

Os comandos de instalação e execução foram ajustados para acessar a aplicação localizada em `github/atividade-github-secrets/app`.

## 4. Fluxo de funcionamento

O funcionamento da solução segue estas etapas:

1. O valor é cadastrado nas configurações de GitHub Secrets do repositório.
2. O GitHub Actions inicia o workflow após um `push` na branch `main`.
3. A expressão `${{ secrets.MENSAGEM_SECRETA }}` obtém o Secret para disponibilizá-lo como variável de ambiente na etapa autorizada.
4. O processo Node.js acessa a variável por meio de `process.env.MENSAGEM_SECRETA`.
5. A aplicação verifica se a variável foi configurada e registra uma confirmação genérica, sem imprimir o conteúdo da mensagem.

## 5. Evidência de execução

A execução do workflow **GitHub Secrets Demo** foi concluída com sucesso no GitHub Actions.

Evidências observadas:

- Workflow: `GitHub Secrets Demo`.
- Job: `executar`.
- Evento: `push`.
- Branch: `main`.
- Commit da execução: `7522a02`.
- Resultado: execução concluída com sucesso.
- Etapas de instalação das dependências e execução da aplicação concluídas sem falha.

A aplicação apresentou a confirmação de recebimento do Secret, sem revelar o conteúdo da mensagem nos logs.

**Capturas recomendadas para anexar:** tela do resumo da execução e logs da etapa `Executar aplicação`, ocultando qualquer informação sensível caso apareça.

## 6. Respostas às questões propostas

### 1. Qual é a diferença entre armazenar o valor diretamente no `pipeline.yml` e armazená-lo no GitHub Secrets?

Quando o valor fica diretamente no YAML, ele passa a fazer parte de um arquivo versionado e pode ser visualizado por pessoas com acesso ao repositório. Com GitHub Secrets, o valor é configurado separadamente e pode ser referenciado pelo workflow sem ser escrito diretamente no arquivo.

### 2. Onde o valor do Secret fica configurado?

Nas configurações do repositório GitHub, em **Settings → Secrets and variables → Actions → Repository secrets**.

### 3. O valor do Secret deve ser colocado no código da aplicação?

Não. O código deve acessar a variável de ambiente, sem precisar conhecer ou armazenar diretamente o valor sensível.

### 4. Qual é a função de `process.env.MENSAGEM_SECRETA`?

A expressão acessa, no processo Node.js, o valor da variável de ambiente chamada `MENSAGEM_SECRETA`. Se ela não estiver configurada, a aplicação utilizada nesta atividade encerra a execução com erro.

### 5. Por que utilizar Secrets é importante em uma pipeline de CI/CD?

Porque permite separar informações sensíveis do código-fonte, reduzindo o risco de exposição acidental de credenciais e facilitando o gerenciamento de valores utilizados durante a automação.

### 6. Por que seria inadequado colocar uma senha real de banco de dados diretamente no arquivo `.yml`?

Porque a senha poderia ser exposta a pessoas com acesso ao arquivo ou ao histórico do repositório. Caso fosse utilizada indevidamente, poderia permitir acesso não autorizado ao banco de dados. O uso de Secrets reduz esse risco, embora também seja necessário limitar permissões e evitar a impressão de credenciais nos logs.

## 7. Conclusão

A atividade demonstrou como retirar uma informação sensível do arquivo de pipeline e disponibilizá-la à aplicação por meio do GitHub Secrets e de uma variável de ambiente.

A execução bem-sucedida do workflow confirmou o funcionamento da configuração implementada. A prática aprendida pode ser aplicada posteriormente ao gerenciamento de credenciais de banco de dados, tokens e outras informações sensíveis em pipelines de CI/CD.

## 8. Repositório da atividade

Repositório: https://github.com/SergioFeitosaa/devops-engineering-lab

Pasta da atividade: `github/atividade-github-secrets/`
