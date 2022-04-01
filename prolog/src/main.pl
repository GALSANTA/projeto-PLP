:- include('Database/connectionDB.pl').
:- include('Controllers/loginController.pl').


main:-
create_conn,
Message = " #####   ######   #####    ######   ##  ##    ####     ####     ####    #####     ####    #####\n##       ##       ##  ##   ##       ### ##   ##  ##     ##     ##  ##   ##  ##   ##  ##   ##  ##\n## ###   #####    #####    #####    ######   ##         ##     ######   ##  ##   ##  ##   #####\n##  ##   ##       ##  ##   ##       ## ###   ##  ##     ##     ##  ##   ##  ##   ##  ##   ##  ##\n ####    ######   ##  ##   ######   ##  ##    ####     ####    ##  ##   #####     ####    ##  ##\n\n ####     ####     ####    #####    ######   ##   ##   ####     ####     ####\n##  ##   ##  ##   ##  ##   ##  ##   ##       #######    ##     ##  ##   ##  ##\n######   ##       ######   ##  ##   #####    ## # ##    ##     ##       ##  ## \n##  ##   ##  ##   ##  ##   ##  ##   ##       ## # ##    ##     ##  ##   ##  ##\n##  ##    ####    ##  ##   #####    ######   ## # ##   ####     ####     ####\n",
menuPrincipal(Message).


menuPrincipal(Message):-
tty_clear,
nl,
write(Message),nl,
write("[1] Para fazer login"), nl,
write("[2] Para fazer cadastro"), nl,
read(Opcao),
escolheOpcao(Opcao).

escolheOpcao(Opcao):-(Opcao = 1 -> signIn; Opcao = 2 -> signUp; write('Opção inválida!'), menuPrincipal).