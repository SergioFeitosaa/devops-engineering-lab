# Atividade Docker — Site Web com Debian e Apache

## 1. Objetivo

Construir uma imagem Docker baseada no Debian, instalar o servidor web Apache e disponibilizar uma aplicação HTML em um container.

## 2. Tecnologias utilizadas

- Docker
- Debian Trixie
- Apache HTTP Server
- HTML
- TAR
- Git e GitHub

## 3. Estrutura do projeto

```text
atividade-site-apache/
├── Dockerfile
├── index.html
├── meu_site.tar
└── README.md
```

## 4. Construção da imagem

Na pasta da atividade, execute:

```bash
docker build -t meu-site-apache:1.0 .
```

## 5. Execução do container

```bash
docker run -d --name meu-site-container -p 8080:80 meu-site-apache:1.0
```

## 6. Acesso à aplicação

Com o container em execução, acesse:

http://localhost:8080

A aplicação é servida pelo Apache na porta 80 do container, mapeada para a porta 8080 da máquina hospedeira.

## 7. Verificação

Para verificar o container em execução:

```bash
docker ps
```

Para listar as imagens disponíveis:

```bash
docker images
```

## 8. Evidências

As capturas de tela da construção da imagem, da execução do container e da aplicação aberta no navegador serão utilizadas para demonstrar o funcionamento da atividade.

## 9. Aprendizados

Nesta atividade, foram praticados a criação de uma imagem Docker com Debian, a instalação do Apache, o empacotamento de arquivos HTML em um arquivo TAR, a construção de imagens e a execução de containers com mapeamento de portas.