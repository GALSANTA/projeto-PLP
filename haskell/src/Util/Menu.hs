{-# LANGUAGE OverloadedStrings #-}

module Util.Menu where
import Util.Entry as Entry
import Util.Util as Util
import Database.MySQL.Base
import Database.ConnectionDB as ConnectionDB
import Controllers.ProfessorController as ProfessorController
import qualified System.IO.Streams as Streams
import System.Console.ANSI

menu:: (String -> IO ()) -> [[MySQLValue]] -> IO ()
menu originalMenu matriz = do 
    let profissao = Util.convert(Util.getProfissao (Util.matrizToList matriz))
    if profissao == "'professor'"
        then do
            menuProfessor originalMenu matriz
    else
        menuAluno originalMenu matriz

menuProfessor:: (String -> IO ()) -> [[MySQLValue]] -> IO ()
menuProfessor originalMenu matriz = do
    clearScreen
    let nome = Util.convert(Util.getName (Util.matrizToList matriz))
    putStrLn("Olá professor: "++nome++"! O que deseja?")
    putStrLn("[1] para atualizar nota de uma aluno.")
    putStrLn("[2] para deslogar")

    opcao <- Entry.lerEntrada
    if opcao == "1"
        then do ProfessorController.atualizaNota originalMenu
    else if opcao == "2"
        then do originalMenu(nome++" foi deslogado!")
    else
        originalMenu("Operação Inválida")

menuAluno:: (String -> IO ()) -> [[MySQLValue]] -> IO ()
menuAluno originalMenu matriz = do
    clearScreen
    let nome = Util.convert(Util.getName (Util.matrizToList matriz))
    putStrLn("Olá aluno: "++nome++"! O que deseja?")
    putStrLn("[1] para cadastrar as cadeiras.")
    putStrLn("[2] para deslogar")

    opcao <- Entry.lerEntrada
    if opcao == "1"
        then do 
            putStrLn("Qual o período de referência?")
            periodo <- Entry.lerEntrada
            putStrLn("Qual o numero de cadeiras que deseja cursar?")
            quantidade <- Entry.lerEntrada
            (defs, is) <- cadeiras periodo quantidade
            m <- Streams.toList is
            let result = Util.disciplinas m
            putStrLn("Essas são as disciplinas que recomendamos para você! \n")
            putStrLn result
            putStrLn("\n")
            menuInserir "" originalMenu matriz

    else if opcao == "2"
        then do originalMenu(nome++" foi deslogado!")
    else
        originalMenu("Operação Inválida")

menuInserir :: String -> (String -> IO ())  -> [[MySQLValue]] -> IO()
menuInserir msg originalMenu matriz = do 
    putStrLn(msg)
    putStrLn("[1] inserir materia!")
    putStrLn("[2] Voltar")
    opcao <- Entry.lerEntrada
    if opcao == "1"
        then do
            putStrLn("Digite o ID da disciplina!")
            id_disciplina <- Entry.lerEntrada
            let id_aluno = Util.convert(Util.getId (Util.matrizToList matriz))
            (defs, is) <- verifyDisciplina id_aluno id_disciplina 
            m <- Streams.toList is

            if  m == []
                then do
                    (defs, is) <- getCountDependencia id_disciplina
                    m <- Streams.toList is
                    let c1 = Util.convert(Util.getCount (Util.matrizToList m))
                    (defs, is) <- getCountDependenciaAluno id_disciplina id_aluno
                    m <- Streams.toList is
                    let c2 = Util.convert(Util.getCount (Util.matrizToList m))
            
                    if c1 == c2
                        then do
                            inserirDisciplina id_aluno id_disciplina
                            menuInserir "Inserido com sucesso!" originalMenu matriz
                    else if c1 /= c2
                        then do
                            putStrLn("\n [ALERT] Infelizmente essa disciplina tem pedências com outras que você não cursou.")
                            putStrLn("\n Disciplinas necessárias: ")
                            (defs, is) <- showDependencia id_disciplina
                            m <- Streams.toList is
                            let result = Util.disciplinas m
                            putStrLn(result)
                            putStrLn("\n Disciplinas que você cursou: ")
                            (defs, is) <- showDependenciaClosed id_disciplina id_aluno
                            m <- Streams.toList is
                            let result = Util.disciplinas m
                            putStrLn(result)
                            putStrLn("--- aperte enter ---")
                            enter <- Entry.lerEntrada
                            menuInserir "" originalMenu matriz
                    else 
                        menuInserir "" originalMenu matriz
                else 
                    menuInserir "Já cursando ou terminando!" originalMenu matriz

    else if opcao == "2"
        then do menuAluno originalMenu matriz
    else
        originalMenu("Operação Inválida")