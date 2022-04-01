:- include('../Database/connectionDB.pl').
:- include('../Util/menu.pl').

signIn :- 
    tty_clear,
    write("Digite o usuário"), nl,
    read(Usuario),
    write("Digite a senha"), nl,
    read(Senha),
    (get_user(Usuario, Senha, Result) -> menu(Result); write("Usuário não encontrado!")).

signUp :-
    write('Digite seu nome: '), nl,
    read(Nome),
    write('Digite seu cpf: '), nl,
    read(Cpf),
    write('Digite sua Matricula: '), nl,
    read(Matricula),
    write('Digite sua Profissão: '), nl,
    read(Profissao),
    write('Digite seu Usuario: '), nl,
    read(Usuario),
    write('Digite sua Senha: '), nl,
    read(Senha),
    (validate_registry(Cpf, Matricula, Usuario, Result) -> write('Usuario já possui uma conta no sistema!'),nl,write("digite E. para continuar..."), nl,
    read(buffer), menu(Result);
    cadastra_usuario(Nome, Cpf, Matricula, Profissao, Usuario, Senha, F) -> write('Cadastro Realizado!'), nl, write("digite E. para continuar..."), nl,
    read(buffer), get_user(Usuario, Senha, R), menu(R);
    write('Não foi possivel realizar o cadastro'), nl, write("digite E. para continuar..."), nl,
    read(buffer), menu(Result)).