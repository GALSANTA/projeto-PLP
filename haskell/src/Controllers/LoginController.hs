{-# LANGUAGE OverloadedStrings #-}

module Controllers.LoginController where
import Util.Entry as Entry
import Database.MySQL.Base
import qualified System.IO.Streams as Streams
import Data.Text as TS
import Util.Util as Util
import Database.ConnectionDB as ConnectionDB

signIn :: IO() 
signIn = do 
    print "Digite o usuario"
    user <- Entry.lerEntrada
    print "Digite a senha"
    password <- Entry.lerEntrada
    (defs, is) <- getUser user password
    matriz <- Streams.toList is

    if matriz /= []
        then do
            let nome = Util.convert(Util.getName (Util.matrizToList matriz))
            let r = "BEM VINDO "++nome
            putStrLn r
    else
        putStrLn "Não Logou"

signUp :: IO()
signUp = do 
    print "Nome: "
    nome <- Entry.lerEntrada
    print "Profissao: "
    profissao <- Entry.lerEntrada 
    print "CPF: "
    cpf <- Entry.lerEntrada
    print "Matricula: "
    matricula <- Entry.lerEntrada
    print "Usuario: "
    usuario <- Entry.lerEntrada
    print "Senha: "
    senha <- Entry.lerEntrada
    
    insertUser nome cpf usuario senha matricula profissao
    print "Usuario Cadastrado com sucesso!"

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