loopTarefa(0) :-  write("digite . para continuar..."), nl, read(Buffer).
loopTarefa(N, Lista) :-
[H | T] = Lista,
row(Id, IdAluno, IdColaborador, IdDisciplina, Descricao, Envio, Relevancia) = H,
write("Tarefa: "), write(Descricao), write(" -- "), write(Envio), write(" Relevância: "), write(Relevancia), nl,
M is N-1,
loopTarefa(M, T).

iterarTarefas(Lista) :-
length(Lista, C),
loopTarefa(C, Lista).

loopCadastrar(0).
loopCadastrar(N, Lista) :-
[H | T] = Lista,
row(Id, Descricao, Professor) = H,
write("Disciplina: "), write(Id), write(" -- "), write(Descricao), write(" Professor: "), write(Professor), nl,
M is N-1,
loopCadastrar(M, T).

iterarCadastro(Lista) :-
length(Lista, C),
loopCadastrar(C, Lista).