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
            let result = Util.convert(Util.getCPF list)
            let r = "BEM VINDO "++result
            putStrLn r
    else
        putStrLn "Não Logou"

signUp :: IO() 
signUp = do 
    print("REGISTRAR")


