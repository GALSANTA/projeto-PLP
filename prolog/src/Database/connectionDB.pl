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

getUser(Usuario, Senha, Result) :-
    odbc_query(conn, 
                "SELECT (nome) FROM tb_usuario WHERE usuario='~w' AND senha='~w'"-[Usuario, Senha],
                row(Result)).

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

update_nota(Disciplina, Aluno, Nota):-
    odbc_query('conn',
                "UPDATE tb_aluno_disciplina SET nota='~w' WHERE aluno_id='~w' AND disciplina_id='~w'"-[Nota, Aluno, Disciplina]),
                write('Nota atualizada com sucesso!').

verify_disciplina_aluno(Disciplina, Aluno, Result):-
    odbc_query('conn',
                "SELECT * FROM tb_aluno_disciplina WHERE aluno_id='~w' AND disciplina_id='~w'"-[Aluno, Disciplina],
                Result).

verify_disciplina(Disciplina):-
    odbc_query('conn',
                "SELECT * FROM tb_disciplina WHERE id_disciplina='~w'"-[Disciplina]).

verify_aluno(Aluno):-
    odbc_query('conn',
                "SELECT * FROM tb_usuario WHERE id_usuario='~w'"-[ALuno]).
