# Imagem-base do sistema operacional
FROM debian:trixie

# Instala o servidor web Apache
RUN apt-get update && \
    apt-get install -y --no-install-recommends apache2 && \
    rm -rf /var/lib/apt/lists/*

# Define o diretório padrão do Apache para os arquivos do site
WORKDIR /var/www/html

# Copia e extrai o arquivo TAR com os arquivos do site
ADD meu_site.tar /var/www/html/

# Documenta a porta utilizada pelo servidor web
EXPOSE 80

# Inicia o Apache em primeiro plano para manter o container ativo
CMD ["apachectl", "-D", "FOREGROUND"]
