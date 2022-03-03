module Util.Menu where
import Util.Entry as Entry
import Database.MySQL.Base
import Util.Util as Util

menu:: (String -> IO ()) -> [[MySQLValue]] -> IO ()
menu originalMenu matriz = do 
    let profissao = Util.convert(Util.getProfissao (Util.matrizToList matriz))
    if profissao == "'professor'"
        then do
            menuProfessor originalMenu matriz
    else
        putStrLn("MENU DE ALUNO")

menuProfessor:: (String -> IO ()) -> [[MySQLValue]] -> IO ()
menuProfessor originalMenu matriz = do
    let nome = Util.convert(Util.getName (Util.matrizToList matriz))
    putStrLn("Olá professor: "++nome++"! O que deseja?")
    putStrLn("[1] para inserir nota de uma aluno.")
    putStrLn("[2] para deslogar")

    input <- Entry.lerEntrada
    if input == "1"
        then do putStrLn("Inserindo nota do aluno")
    else if input == "2"
        then do originalMenu("Nota do aluno inserida com sucesso!")
    else
        originalMenu("Operação Inválida")
