:- include('../Database/connectionDB.pl').

cadastra_disciplinas():-
    write('Qual o período de referência?'),
    read(Periodo),
    write('Qual o numero de cadeiras que deseja cursar?'),
    read(NumCadeiras),
    write('Essas são as disciplinas que recomendamos para você!'),
    cadeiras(Periodo, NumCadeiras).