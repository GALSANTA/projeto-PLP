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

get_user(Usuario, Senha, Results) :-
     odbc_query(conn, 
                 "SELECT id_usuario, nome, profissao FROM tb_usuario WHERE usuario='~w' AND senha='~w'"-[Usuario, Senha],
                 Results,
                 [types([integer, default, default])]).

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
                "SELECT * FROM tb_disciplina WHERE id_disciplina=~w"-[Disciplina]).

verify_aluno(Aluno):-
    odbc_query('conn',
                "SELECT * FROM tb_usuario WHERE id_usuario='~w'"-[Aluno]).

cadeiras(Periodo, Quantidade, Results):-
    findall(Result,
                odbc_query(conn,
                    "SELECT id_disciplina, nome_disciplina, nome FROM tb_disciplina AS A INNER JOIN tb_usuario AS B ON B.id_usuario = A.professor_id WHERE (A.tipo='~w' OR A.tipo='O') ORDER BY id_disciplina LIMIT ~w"-[Periodo, Quantidade],
                    Result, [types([integer, default, default])]),
                Results).

inserir_disciplina(IdAluno, IdDisciplina) :-
    odbc_query('conn',
                "INSERT INTO tb_aluno_disciplina (aluno_id, disciplina_id, nota) VALUES ('~w','~w',0)"-[IdAluno, IdDisciplina],
                Result).

inserir_tarefa(Id, Descricao, Colaborador, Disciplina, Relevancia, Result):-
    odbc_query('conn',
                "INSERT INTO tb_tarefa VALUES (NULL,'~w','~w','~w','~w','~w')"-[Id, Descricao, Colaborador, Disciplina, Relevancia],
                Result).

ordenar_tarefas_relevancia(Id, Op, Results):-
    findall(Result,
                odbc_query(conn,
                           "SELECT * FROM tb_tarefa WHERE aluno_id='~w' OR colaborador_id='~w' AND relevancia='~w'"-[Id, Id, Op],
                           Result, [types([integer, default, default, default, default, default])]),
            Results).

ordenar_tarefas_asc(Id, Results):-
    findall(Result,
                odbc_query(conn,
                          "SELECT * FROM tb_tarefa WHERE aluno_id='~w' OR colaborador_id='~w' ORDER BY relevancia ASC"-[Id, Id],
                            Result, [types([integer, default, default, default, default, default])]),
            Results).

ordenar_tarefas_desc(Id, Results):-
    findall(Result,
                odbc_query(conn,
                          "SELECT * FROM tb_tarefa WHERE aluno_id='~w' OR colaborador_id='~w' ORDER BY relevancia DESC"-[Id, Id],
                            Result, [types([integer, default, default, default, default, default])]),
                Results).