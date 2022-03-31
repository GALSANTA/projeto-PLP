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

cadastra_usuario(Nome, Cpf, Matricula, Profissao, Usuario, Senha, F) :-
    odbc_query('conn',
                "INSERT INTO tb_usuario (nome, cpf, matricula, profissao, usuario, senha)
                 VALUES ('~w', '~w', '~w', '~w', '~w', '~w')"-[Nome, Cpf, Matricula, Profissao, Usuario, Senha],
                affected(F)).

validate_registry(Cpf, Matricula, Usuario, Result) :- 
    odbc_query('conn',
                "SELECT * FROM tb_usuario WHERE cpf='~w' OR matricula='~w' OR usuario='~w'"-[Cpf, Matricula, Usuario],
                Result, [ types([integer,default, default, default, default, default, default])
                ]).

update_nota(Disciplina, Aluno, Nota, Result):-
    odbc_query('conn',
                "UPDATE tb_aluno_disciplina SET nota='~w' WHERE aluno_id='~w' AND disciplina_id='~w'"-[Nota, Aluno, Disciplina],
                Result).

verify_disciplina(Disciplina, Aluno, Result):-
    odbc_query('conn',
                "SELECT * FROM tb_aluno_disciplina WHERE aluno_id='~w' AND disciplina_id='~w'"-[Aluno, Disciplina],
                Result).
