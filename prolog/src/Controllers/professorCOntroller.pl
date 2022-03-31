:- include('../Database/connectionDB.pl').

atualiza_nota():-
    write('Id da disciplina: '), nl,
    read(Id_d),
    write('Id Aluno: '), nl,
    read(Id_a),
    write('Nota do aluno: '), nl,
    read(Nota),
    (verify_disciplina(Id_d, Id_a, Result) -> (update_nota(Id_d, Id_a, Nota, Result) -> write('Nota Atualizada!'), nl, halt;
                                                write('Impossivel atualizar nota do aluno!'));
    write('Aluno não cadastrado na disciplina informada'), nl, halt).