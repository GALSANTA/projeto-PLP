:- include('../Controllers/alunoController.pl').
:- include('../Controllers/professorController.pl').
:- include('./util.pl').

menu(Usuario) :- 
    row(Id, Nome, Profissao) = Usuario,
    (Profissao == 'professor' -> menuProfessor("", Nome); menuAluno(Usuario)).

menuProfessor(Message, Nome):-
    tty_clear,
    write(Message), nl,
    atom_concat("Olá professor: ", Nome, R),
    atom_concat(R, "! O que deseja?", R1),
    write(R1), nl,
    write("[1] para atualizar nota de uma aluno."), nl,
    write("[2] para deslogar"), nl,
    read(Opcao),
    (Opcao == 1 -> atualiza_nota, menuProfessor("Nota atualizada com sucesso!", Nome); Opcao == 2 -> menuPrincipal("Professor foi deslogado")).

menuAluno(Usuario):-
    tty_clear,
    row(Id, Nome, Profissao) = Usuario,
    write(Profissao),
    atom_concat("Olá aluno: ", Nome, R),
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
    cadeiras(Periodo, Quantidade, Results),
    iterarCadastro(Results),
    menuInserir("", Usuario).

menuAlunoCadastrarTarefas(Usuario):-
    row(Id, Nome, Profissao) = Usuario,

    write("Id do colaborador."), nl,
    read(Colaborador),
    write("Id do disciplina."), nl,
    read(Disciplina),
    write("Descreva a tarefa que deve ser executada."), nl,
    read(Descricao),
    write("Qual a relevancia? 1-Alta 2-Média 3-Baixa"), nl,
    read(Relevancia),
    inserir_tarefa(Id, Descricao, Colaborador, Disciplina, Relevancia, Result),
    write("Tarefa inserida com sucesso!..."), nl,
    write("digite E. para continuar..."), nl,
    read(buffer),
    menuAluno(Usuario).

menuVisualizarTarefas(Usuario) :- 
    row(Id, Nome, Profissao) = Usuario,
    write("\nInforme como deseja visualizar as Tarefas"), nl,
    write("1-Alta relevancia 2-Média relevancia 3-Baixa relevancia 4-Crescente 5-Decrescente"), nl,
    read(Opcao),
    (Opcao = 1 -> 
        ordenar_tarefas_relevancia(Id, Opcao, Results),
        iterarTarefas(Results),
        write("digite E. para continuar..."), nl,
        read(buffer),
        menuAluno(Usuario)
    ; 
    Opcao = 2 -> 
        ordenar_tarefas_relevancia(Id, Opcao, Results),
        iterarTarefas(Results),
        write("digite E. para continuar..."), nl,
        read(buffer),
        menuAluno(Usuario)
    ;
    Opcao = 3 -> 
       ordenar_tarefas_relevancia(Id, Opcao, Results),
       iterarTarefas(Results),
       write("digite E. para continuar..."), nl,
        read(buffer)
    ;
    Opcao == 4 -> 
        ordenar_tarefas_asc(Id,  Results),
        iterarTarefas(Results),
        write("digite E. para continuar..."), nl,
        read(buffer)
    ;
    ordenar_tarefas_desc(Id, Results),
    iterarTarefas(Results)
    ), menuAluno(Usuario).

menuInserir(Mensagem, Usuario):-
    write(Mensagem), nl, 
    write("[1] inserir materia!"), nl,
    write("[2] Voltar"), nl,  
    read(Opcao),
    (Opcao == 1 ->
        write("Digite o ID da disciplina!"),
        read(IdDisciplina),
        row(Id, Nome, Profissao) = Usuario,
        inserir_disciplina(Id, IdDisciplina),
        menuInserir("Disciplina inserida com sucesso!", Usuario)
    ; menuAluno(Usuario)).