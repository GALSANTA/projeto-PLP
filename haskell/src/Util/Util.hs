module Util.Util where
import Database.MySQL.Protocol.MySQLValue
import Data.Binary.Put
import Data.Text as TS
import Data.Text.Lazy.Encoding as TLE
import Data.Text.Lazy as TL
import qualified System.IO.Streams as Streams
import Database.MySQL.Base

convert :: MySQLValue -> String
convert value = TL.unpack(TLE.decodeUtf8(runPut(putTextField(value))))

matrizToList :: [[MySQLValue]] -> [MySQLValue]
matrizToList (x:xs) = x

getCount :: [MySQLValue] -> MySQLValue
getCount (count:tail) = count

disciplinas :: [[MySQLValue]] -> String
disciplinas [] = []
disciplinas (x:xs) = "\nID "++convert(getIdDisciplina x)++", NOME: " ++ convert(getNameDisciplina x) ++", PROFESSOR: "++ convert(getNameProfessor x) ++ disciplinas xs

--------------USUARIO------------------ 
getId :: [MySQLValue] -> MySQLValue
getId (id:tail) = id

getName :: [MySQLValue] -> MySQLValue
getName (id:name:tail) = name

getCPF :: [MySQLValue] -> MySQLValue
getCPF (id:name:cpf:tail) = cpf

getMatricula :: [MySQLValue] -> MySQLValue
getMatricula (id:name:cpf:matricula:tail) = matricula

getProfissao :: [MySQLValue] -> MySQLValue
getProfissao (id:name:cpf:matricula:profissao:tail) = profissao

--------------DISCIPLINA------------------
 
getIdDisciplina :: [MySQLValue] -> MySQLValue
getIdDisciplina (id:tail) = id

getNameDisciplina :: [MySQLValue] -> MySQLValue
getNameDisciplina (id:name:tail) = name

getNameProfessor:: [MySQLValue] -> MySQLValue
getNameProfessor (id:name:nameP:tail) = nameP