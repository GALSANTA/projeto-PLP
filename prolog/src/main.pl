:- include('menuController.pl').
:- include('Database/connectionDB.pl').
:- include('Controllers/loginController.pl').


main:-
write(" #####   ######   #####    ######   ##  ##    ####     ####     ####    #####     ####    #####\n##       ##       ##  ##   ##       ### ##   ##  ##     ##     ##  ##   ##  ##   ##  ##   ##  ##\n## ###   #####    #####    #####    ######   ##         ##     ######   ##  ##   ##  ##   #####\n##  ##   ##       ##  ##   ##       ## ###   ##  ##     ##     ##  ##   ##  ##   ##  ##   ##  ##\n ####    ######   ##  ##   ######   ##  ##    ####     ####    ##  ##   #####     ####    ##  ##\n\n ####     ####     ####    #####    ######   ##   ##   ####     ####     ####\n##  ##   ##  ##   ##  ##   ##  ##   ##       #######    ##     ##  ##   ##  ##\n######   ##       ######   ##  ##   #####    ## # ##    ##     ##       ##  ## \n##  ##   ##  ##   ##  ##   ##  ##   ##       ## # ##    ##     ##  ##   ##  ##\n##  ##    ####    ##  ##   #####    ######   ## # ##   ####     ####     ####\n"),
create_conn,
menuPrincipal.


menuPrincipal():-
nl,
write("[1] Para fazer login"), nl,
write("[2] Para fazer cadastro"), nl,
read(Opcao),
escolheOpcao(Opcao).

escolheOpcao(Opcao):-(Opcao = 1 -> login; Opcao = 2 -> signUp; write('Opção inválida!'), menuPrincipal).