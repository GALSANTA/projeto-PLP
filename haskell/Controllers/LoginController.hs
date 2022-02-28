module Controllers.LoginController where
import Util.Util as Util

signIn :: IO() 
signIn = do 
    usuario <- Util.lerEntrada
    senha <- Util.lerEntrada
    if (usuario == "usuario" && senha == "senha")
        then do print("LOGOU")
    else 
        print("NAO LOGOU")

signUp :: IO() 
signUp = do 
    print("REGISTRAR")