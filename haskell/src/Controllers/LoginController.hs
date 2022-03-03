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

    (defs, is) <- verifyData cpf matricula
    matriz <- Streams.toList is
    
    validateRegistry originalMenu matriz nome cpf usuario senha matricula profissao

insertUser :: String -> String -> String -> String -> String -> String -> IO OK
insertUser nome cpf usuario senha matricula profissao = do
    let n = TS.pack(nome)
    let c = TS.pack(cpf)
    let u = TS.pack(usuario)
    let s = TS.pack(senha)
    let m = TS.pack(matricula)
    let p = TS.pack(profissao)
    conn <- ConnectionDB.connectDB
    execute conn "INSERT INTO tb_usuario VALUES (NULL, ?, ?, ?, ?, ?, ?)" [MySQLText n, MySQLText c, MySQLText m, MySQLText p, MySQLText u, MySQLText s]

getUser :: String -> String -> IO ([ColumnDef], Streams.InputStream [MySQLValue])
getUser user password = do
    let a = TS.pack(user)
    let b = TS.pack(password) 
    conn <- ConnectionDB.connectDB
    query <- prepareStmt conn "SELECT * FROM tb_usuario WHERE usuario=? AND senha=?"
    queryStmt conn query [MySQLText a, MySQLText b]


verifyData :: String -> String -> IO ([ColumnDef], Streams.InputStream [MySQLValue])
verifyData cpf matricula = do
    let a = TS.pack(cpf)
    let b = TS.pack(matricula) 
    conn <- ConnectionDB.connectDB
    query <- prepareStmt conn "SELECT * FROM tb_usuario WHERE cpf=? OR matricula=?"
    queryStmt conn query [MySQLText a, MySQLText b]

validateRegistry:: (String -> IO ()) -> [[MySQLValue]] -> String -> String -> String -> String -> String -> String -> IO()
validateRegistry originalMenu matriz nome cpf usuario senha matricula profissao =if matriz == []
        then do
            insertUser nome cpf usuario senha matricula profissao
            originalMenu("Usuário cadastrado com sucesso!")
    else
        originalMenu("Usuário já cadastrado!")
            