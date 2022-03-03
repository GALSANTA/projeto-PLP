import Util.Entry as Entry
import Controllers.LoginController as LoginController

main :: IO ()
main = do
 print("Gerenciador de cronograma academico")
 opcao <- Entry.lerEntrada
 escolheOpcao opcao

escolheOpcao :: String -> IO()
escolheOpcao opcao 
 | opcao == "1" = LoginController.signIn
 | opcao == "2" = LoginController.signUp
