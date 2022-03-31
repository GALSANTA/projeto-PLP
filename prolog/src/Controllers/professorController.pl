:- include('../Database/connectionDB.pl').

atualiza_nota:-
    write('Id da disciplina: '), nl,
    read(Id_d),
    write('Id Aluno: '), nl,
    read(Id_a),
    write('Nota do aluno: '), nl,
    read(Nota),
    (verify_disciplina_aluno(Id_d, Id_a, Result) -> update_nota(Id_d, Id_a, Nota);
    verify_disciplina(Id_d) -> write('Disciplina não existe!');
    verify_aluno(Id_a) -> write('Aluno não existe!');
    write('Aluno não cadastrado na disciplina informada'), nl, halt).