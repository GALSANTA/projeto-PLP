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


