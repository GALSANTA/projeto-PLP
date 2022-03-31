create_connection :-
    odbc_connect('projetoPLP', _,
                    [ user(remote),
                    password(123),
                    alias(conn),
                    open(once)
                    ]).

drop_connection :-
    odbc_disconnect(conn).

cadastra(Nome, Cpf, Matricula, Profissao, Usuario, Senha, F) :-
    odbc_query('conn',
                'INSERT INTO tb_usuario (id_usuario, nome, cpf, matricula, profissao, usuario, senha)
                VALUES (?, Nome, Cpf, Matricula, Profissao, Usuario, Senha, F)',
                affected(F)).

