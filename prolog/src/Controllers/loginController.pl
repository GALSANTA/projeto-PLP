:- include('../Database/connectionDB.pl').

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
    (validate_registry(Cpf, Matricula, Usuario, Result) -> write('Usuario já possui uma conta no sistema!'),nl, halt;
    cadastra_usuario(Nome, Cpf, Matricula, Profissao, Usuario, Senha, F) -> write('Cadastro Realizado!'), nl, halt;
    write('Não foi possivel realizar o cadastro'), nl, halt).