{-# LANGUAGE OverloadedStrings #-}

module Controllers.LoginController where
import Util.Entry as Entry
import Database.MySQL.Base
import qualified System.IO.Streams as Streams
import Data.Text as TS
import Util.Util as Util

signIn :: IO() 
signIn = do 
    print "Digite o usuario"
    a <- Entry.lerEntrada
    print "Digite a senha"
    b <- Entry.lerEntrada
    let user = TS.pack(a)
    let password = TS.pack(b)

    conn <- connect
     defaultConnectInfo {ciHost="10.11.19.23", ciUser = "remote", ciPassword = "123", ciDatabase = "projetoPLP"}
    s <- prepareStmt conn "SELECT * FROM tb_usuario WHERE usuario=? AND senha=?"
    
    (defs, is) <- queryStmt conn s [MySQLText user, MySQLText password]
    matriz <- Streams.toList is
    if matriz /= []
        then do
            let list = Util.matrizToList matriz
            let result = Util.convert(Util.getName list)
            let r = "BEM VINDO "++result
            putStrLn r
    else
        putStrLn "Não Logou"

signUp :: IO()
signUp = do 
    print "Nome: "
    n <- Entry.lerEntrada
    print "Profissao: "
    p <- Entry.lerEntrada 
    print "CPF: "
    c <- Entry.lerEntrada
    print "Matricula: "
    m <- Entry.lerEntrada
    print "Usuario: "
    u <- Entry.lerEntrada
    print "Senha: "
    s <- Entry.lerEntrada
    let nome = TS.pack(n)
    let cpf = TS.pack(c)
    let usuario = TS.pack(u)
    let senha = TS.pack(s)
    let matricula = TS.pack(m)
    let profissao = TS.pack(p)

    conn <- connect
     defaultConnectInfo {ciHost="10.11.19.23", ciUser = "remote", ciPassword = "123", ciDatabase = "projetoPLP"}
    execute conn "INSERT INTO tb_usuario VALUES (NULL, ?, ?, ?, ?, ?, ?)" [MySQLText nome, MySQLText cpf, MySQLText matricula, MySQLText profissao, MySQLText usuario, MySQLText senha]
    print "Usuario Cadastrado com sucesso!"


