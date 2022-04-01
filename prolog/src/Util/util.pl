loop(0).
loop(N, Lista) :-
[H | T] = Lista,
row(Id, IdAluno, IdColaborador, IdDisciplina, Descricao, Envio, Relevancia) = H,
write("Tarefa: "), write(Descricao), write(" -- "), write(Envio), write(" Relevância: "), write(Relevancia), nl,
M is N-1,
loop(M, T).

iterarTarefas(Lista) :-
length(Lista, C),
loop(C, Lista).