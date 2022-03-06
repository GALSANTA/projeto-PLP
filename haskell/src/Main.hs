module Main where
import System.Console.ANSI
import Controllers.LoginController as LoginController
import Util.Menu
import Util.Entry

main :: IO ()
main = do 
    menuPrincipal(" #####   ######   #####    ######   ##  ##    ####     ####     ####    #####     ####    #####\n##       ##       ##  ##   ##       ### ##   ##  ##     ##     ##  ##   ##  ##   ##  ##   ##  ##\n## ###   #####    #####    #####    ######   ##         ##     ######   ##  ##   ##  ##   #####\n##  ##   ##       ##  ##   ##       ## ###   ##  ##     ##     ##  ##   ##  ##   ##  ##   ##  ##\n ####    ######   ##  ##   ######   ##  ##    ####     ####    ##  ##   #####     ####    ##  ##\n\n ####     ####     ####    #####    ######   ##   ##   ####     ####     ####\n##  ##   ##  ##   ##  ##   ##  ##   ##       #######    ##     ##  ##   ##  ##\n######   ##       ######   ##  ##   #####    ## # ##    ##     ##       ##  ## \n##  ##   ##  ##   ##  ##   ##  ##   ##       ## # ##    ##     ##  ##   ##  ##\n##  ##    ####    ##  ##   #####    ######   ## # ##   ####     ####     ####\n")

menuPrincipal :: String -> IO ()
menuPrincipal msg = do
    clearScreen
    putStrLn(msg)
    putStrLn("[1] Para fazer login")
    putStrLn("[2] Para fazer cadastro")
    opcao <- lerEntrada
    escolheOpcao opcao 

escolheOpcao :: String -> IO()
escolheOpcao opcao 
 | opcao == "1" = LoginController.signIn(menuPrincipal)
 | opcao == "2" = LoginController.signUp(menuPrincipal)
 | otherwise = do putStrLn("Operação Inválida")