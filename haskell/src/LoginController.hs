{-# LANGUAGE OverloadedStrings #-}

module LoginController where
import Entry
import Database.MySQL.Base
import qualified System.IO.Streams as Streams
import Data.Text as TS
signIn :: IO() 
signIn = do 
    a <- Entry.lerEntrada
    b <- Entry.lerEntrada
    let user = TS.pack(a)
    let password = TS.pack(b)

    conn <- connect
     defaultConnectInfo {ciHost="10.11.19.23", ciUser = "remote", ciPassword = "123", ciDatabase = "projetoPLP"}
    s <- prepareStmt conn "SELECT * FROM tb_usuario WHERE usuario=? AND senha=?"
    
    (defs, is) <- queryStmt conn s [MySQLText user, MySQLText password]
    print =<< Streams.toList is

signUp :: IO() 
signUp = do 
    print("REGISTRAR")