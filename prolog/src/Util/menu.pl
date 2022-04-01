:- include('../Controllers/alunoController.pl').

menu(Usuario) :- 

    % Profissao é pega por algo que vem do usuario
    Profissao = "aluno",

    (Profissao == "professor" -> menuProfessor(""); menuAluno(Usuario)).

menuProfessor(Message):-
    tty_clear,
    write(Message), nl,
    % Sera substituido por algo que vem do usuario
    Nome = "Professor A",

    atom_concat("Olá professor: ", Nome, R),
    atom_concat(R, "! O que deseja?", R1),
    write(R1), nl,
    write("[1] para atualizar nota de uma aluno."), nl,
    write("[2] para deslogar"), nl,
    read(Opcao),
    (Opcao == 1 -> update_nota(1,1,1), menuProfessor("Nota atualizada com sucesso!"); Opcao == 2 -> menuPrincipal("Professor foi deslogado")).


menuAluno(Usuario):-
    tty_clear,

    % O nome do aluno é pego por algo que vem do usuario
    Aluno = "Aluno A",
    atom_concat("Olá aluno: ", Aluno, R),
    atom_concat(R, "! O que deseja?", R1),

    write(R1), nl,
    write("[1] para cadastrar as cadeiras."), nl, 
    write("[2] para cadastrar tarefas."), nl,
    write("[3] para visualizar tarefas."), nl,
    write("[4] para deslogar"), nl,
    read(Opcao),
    (Opcao == 1 -> menuAlunoCadastrar(Usuario); 
    Opcao == 2 ->  menuAlunoCadastrarTarefas(Usuario); 
    Opcao == 3 -> menuVisualizarTarefas(Usuario); 
    Opcao == 4 -> menuPrincipal("Aluno foi deslogado!")).

menuAlunoCadastrar(Usuario):-
    write("Qual o período de referência?"), nl,
    read(Periodo), 
    write("Qual o numero de cadeiras que deseja cursar?"), nl,
    read(Quantidade),
    write("Essas são as disciplinas que recomendamos para você!"), nl,
    cadeiras(Periodo, Quantidade),
    menu(Usuario).

menuAlunoCadastrarTarefas(Usuario):-
    write("Id do colaborador."), nl,
    read(Colaborador),
    write("Id do disciplina."), nl,
    read(Disciplina),
    write("Descreva a tarefa que deve ser executada."), nl,
    read(Descricao),
    write("Informe a data e Hora do envio. YYYY-MM-DD"), nl,
    read(Data),
    write("Qual a relevancia?"), nl,
    write("Qual a relevancia? 1-Alta 2-Média 3-Baixa"), nl,
    read(Relevancia),
    % inserir tarefa
    write("Tarefa inserida com sucesso!..."), nl,
    write("digite . para continuar..."), nl,
    read(buffer),
    menuAluno(Usuario).

menuVisualizarTarefas(Usuario) :- 
    
    % IdAluno = pega do usuario o id do aluno.
    % let id_aluno = Util.convert(Util.getId(Util.matrizToList matriz))

    write("\nInforme como deseja visualizar as Tarefas"), nl,
    write("1-Alta relevancia 2-Média relevancia 3-Baixa relevancia 4-Crescente 5-Decrescente"), nl,
    read(Opcao),
    (Opcao = 1 -> write("1"); 
    Opcao = 2 -> write("2");
    Opcao = 3 -> write("3");
    % Ordernar Por relevancia
    Opcao == 4 -> 
    write("4")
    % Ordernar Crescente
    ;
    Opcao == 5 -> 
    write("5")
    % Ordernar Decrescente
    ).