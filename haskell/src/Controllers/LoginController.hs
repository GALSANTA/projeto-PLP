{-# LANGUAGE OverloadedStrings #-}

module Controllers.LoginController where
import Util.Entry as Entry
import Util.Menu as Menu
import qualified System.IO.Streams as Streams
import Data.Text as TS
import Util.Util as Util
import Database.ConnectionDB as ConnectionDB
import Database.MySQL.Base
import System.Console.ANSI

signIn :: (String -> IO ()) -> IO() 
signIn originalMenu = do 
    clearScreen
    putStrLn("Digite o usuário")
    user <- Entry.lerEntrada
    putStrLn("Digite a senha")
    password <- Entry.lerEntrada
    (defs, is) <- getUser user password
    matriz <- Streams.toList is

    if matriz /= []
        then do
            let nome = Util.convert(Util.getName (Util.matrizToList matriz))
            clearScreen
            menu originalMenu matriz
    else
        originalMenu("Usuário não encontrado!")

signUp :: (String -> IO ()) -> IO()
signUp originalMenu = do
    clearScreen 
    putStrLn("Nome: ")
    nome <- Entry.lerEntrada
    putStrLn("Profissao: ")
    profissao <- Entry.lerEntrada
    putStrLn("CPF: ")
    cpf <- Entry.lerEntrada
    putStrLn("Matricula: ")
    matricula <- Entry.lerEntrada
    putStrLn("Usuario: ")
    usuario <- Entry.lerEntrada
    putStrLn("Senha: ")
    senha <- Entry.lerEntrada

    (defs, is) <- verifyData cpf matricula usuario
    matriz <- Streams.toList is
    
    validateRegistry originalMenu matriz nome cpf usuario senha matricula profissao