# Gerenciador de cronograma acadêmico

## 1. Do que se trata?

Este é um projeto para a disciplina de PLP com propósitos avaliativos.

## 2. Como contribuir?

### 2.1 Caso você não seja do grupo 12 de PLP

Primeiro tenha a chave privada do repositório em mãos e depois rode o seguinte comando em seu terminal Linux.

```
eval "$(ssh-agent -s)"
```

Logo em seguida rode o seguinte comando em seu terminal Linux.

```
ssh-add <caminho para sua chave privada>
```

Depois de ter feito esses passos você está apto para contribuir no projeto, então dê um git pull.

```
git pull https://github.com/GALSANTA/PLP-projeto
```
### 2.2 Caso você seja do grupo 12 de PLP

Neste caso você já tem acesso via github pois te deixei como colaborador. Se por acaso você não possui github,  apenas faça download do código e passe suas modificações no canal de Discord para que alguém as valide.

## 3. Como funciona essa contribuição? 

Casa US tem que ter sua própria branch, seguindo o seguinte padrão:

```
FEAT#US-numéro da us.
````

Os commits devem seguir esses padrão:

```
TAG: descrição do commit
```

Essa tag pode variar conforme o propósito do commit.

| Tag | Descrições |
|---|---|
| DOCS | Mudanças relacionadas à documentação|
| STYLE | Código relacionado ao estilo da aplicação, ou seja, comentários |
| FEAT | Uma nova feature, uma funcionalidade implementada |
| FIX | Correção de algum bug |
| REFACTOR | Refatoramento de código, ou seja, não corrige um bug nem adiciona uma funcionalidade |

Logo após terminar um merge request deve ser feito e será validado por todos do grupo.

## 4. Dependências
---

* [haskell platform](https://www.cyberithub.com/how-to-install-haskell-platform-on-ubuntu-20-04-lts/)
* [mariadb](https://www.mariadbtutorial.com/getting-started/install-mariadb/)
* [mysql-haskell-0.8.4.3](https://hackage.haskell.org/package/mysql-haskell)
* [odbc-mysql](https://dev.mysql.com/downloads/connector/odbc/)


## 5. Rodando o código em haskell
---

Primeiro tenha o `cabal` instalado no seu Linux, se você baixou o haskell platform já deve ter ele. Dentro da pasta haskell rode o seguinte comando

```
cabal run
```

## 6. Rodando código em prolog

Primeiro é necessário fazer a instalação do `odbc-mysql` que pode variar para cada sistema operacional. Depois de instalado é preciso a criação de um cursor, que deve conter os dados necessários para se conectar com seu banco de dados, que tambem deve ser alterado no código, na pasta `/prolog/src/Database/connectionDB.pl` método `create_conn` você deve mudar o primeiro parametro para o nome do cursor criado, seu user e password do banco de dados.

### 6.1. Exemplo linux

No linux, depois de instalado o odbc-mysql vc deve ter um arquivo `etc/odbc.ini` que reflete as configurações para conexão com o banco de dados, um exemplo do nosso cursor:

```
[ODBC Data Sources]
myodbc8w     = MyODBC 8.0 UNICODE Driver DSN
myodbc8a     = MyODBC 8.0 ANSI Driver DSN

[projetoPLP]
Driver       = /home/ubuntu/mysql-connector-odbc-8.0.28-linux-glibc2.12-x86-64bit/lib/libmyodbc8w.so
Description  = Connector/ODBC 8.0 UNICODE Driver DSN
SERVER       = localhost
PORT         = 3306
USER         = 
Password     =
Database     = projetoPLP
OPTION       = 3
SOCKET       =
```