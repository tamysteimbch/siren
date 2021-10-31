# Bem vindo!

Olá! Esse repositório foi criado para a realização de uma atividade da matéria DevOps da Universidade Positivo, solicitada pelo professor Leandro Escobar.

# Como utilizar esse repositório
## Requisitos

 - Docker instalado ([https://docs.docker.com/get-started/](https://docs.docker.com/get-started/))

## Utilizando a imagem já criada

Para utilizar a imagem que criei, acesse https://hub.docker.com/r/tsteimbch/siren e utilize o comando 
`docker pull tsteimbch/siren` e para acessar o dockerfile junto ao script sql preparado, utilize `https://github.com/tamysteimbch/siren.git`

# Criando o próprio container

## Como funciona o Docker

O Docker é uma ferramenta que facilita a criação e administração de ambientes (contêineres) tornando uma aplicação mais flexível e portável para qualquer outro Host que tenha o Docker instalado em sua máquina, reduzindo o tempo gasto para ajustar o ambiente. 
Ex: uma aplicação usa o Python 3.7.2, utilizando o Docker isso é configurado apenas uma vez. Cada Host que utilizar este contêiner já estará com a configuração correta.

## Como criar o próprio contêiner
Antes de criar o seu contêiner, primeiro precisamos criar o nosso *Dockerfile* e gerar uma imagem.

### Criando um dockerfile teste
Para isso, utilizando a documentação oficial do Docker, iremos gerar o nosso Dockerfile na pasta de nossa aplicação. ([documentação sobre dockerfile](https://docs.docker.com/engine/reference/builder/))

Por agora, vamos fazer a configuração teste de nosso dockerfile (isso pode ser feito na IDE de sua preferência): 
`# syntax=docker/dockerfile:1`
`FROM busybox`
`CMD echo 'test'`

Após a criação desse dockerfile, vamos gerar nossa primeira imagem de teste.
Para isso, iremos digitar em um terminal: 
`docker build -t nome-imagem -f /path/do/seu/dockerfile .`
A flag -t é usada para dar um nomem à sua imagem, nesse caso passei como nome-imagem, para ficar mais fácil a identificação, e a flag -f especifica o arquivo dockerfile para gerar a imagem e o ponto ao final especifica onde a imagem será construída.

### Criando o contêiner a partir da imagem teste
Agora vamos gerar nosso contêiner a partir de nossa imagem gerada.

Para isso, vamos utilizar a seguinte linha de comando:
`docker run -d --rm --name nome-container nome-imagem`
A flag -d significa que será rodado em segundo plano, não deixando o terminal preso à exibição de informações sobre o contêiner, a flag --rm verifica se o contêiner já existe, caso sim, ele será removido e outro será criado, a flag --name gera o nome do contêiner para a identificação ficar mais fácil e ao final o nome da imagem que será utilizada no contêiner.
Ao finalizar, rode o comando `docker ps` para verificar os contêineres em execução.

# Criando um contêiner MySQL
Utilizando o Dockerfile já criado, vamos configurá-lo para MySQL.

## Configuração do Dockerfile

Para o nosso arquivo Docker, iremos alterar algumas linhas, adicionando instruções ao mesmo.
Primeira instrução que devemos utilizar é o `FROM`, especificando um *Parent Image*, que faz o download da imagem de um repositório (geralmente do *DockerHub*):
`FROM mysql`
Agora, utilizaremos outra instrução muito importante, que é a `ENV` que define as variáveis de ambiente, onde podemos alterar o PATH, por exemplo. Neste caso, iremos utilizar a `ENV` para definir algumas informações do Mysql (para mais opções, acesse a documentação oficial do [MySQL](https://hub.docker.com/_/mysql)):
`ENV MYSQL_DATABASE=<nome-database> \ MYSQL_ROOT_PASSWORD=<senha> `

Adicionaremos o arquivo SQL do nosso banco de dados com a instrução `ADD`
`ADD schema.sql /docker-entrypoint-initdb.d` 
Esse arquivo você consegue gerar a partir de seu banco já pronto, utilizando o comando mysqldump, que gera um arquivo completo do seu banco de dados, ou você pode criar um script do zero.

E, por fim, adicionaremos a porta por onde estará ouvindo conexões com a instrução `EXPOSE`. Como a porta default do MySQL é 3306, iremos continuar com a mesma.
`EXPOSE 3306`

As instruções são adicionadas conforme o necessário, portanto acesse a documentação oficial do [MySQL](https://hub.docker.com/_/mysql) para saber quais e quando utilizar.

Após isso, usando o comando `docker-compose build` e `docker-compose up` iremos iniciar a instância Docker MySQL!
