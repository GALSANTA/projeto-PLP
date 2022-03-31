:- use_module(library(odbc)).

create_conn :-
    odbc_connect('projetoPLP', _,
                    [ user('remote'),
                    password('123'),
                    alias(conn),
                    open(once)
                    ]).

drop_connection :-
    odbc_disconnect(conn).

getUser(F) :-
    write('Digite seu usuario: '), nl,
    read(Usuario),
    write('Digite sua senha: '), nl,
    read(Senha),
        odbc_query(conn, 
                    "SELECT (nome) FROM tb_usuario WHERE usuario='~w' AND senha='~w'"-[Usuario, Senha],
                    row(F)), write(F).

cadastra_usuario(F) :-
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
    odbc_query('conn',
                "INSERT INTO tb_usuario (nome, cpf, matricula, profissao, usuario, senha)
                 VALUES ('~w', '~w', '~w', '~w', '~w', '~w')"-[Nome, Cpf, Matricula, Profissao, Usuario, Senha],
                affected(F)).