module Util.Util where
import Database.MySQL.Protocol.MySQLValue
import Data.Binary.Put
import Data.Text as TS
import Data.Text.Lazy.Encoding as TLE
import Data.Text.Lazy as TL
import Database.ConnectionDB as ConnectionDB
import qualified System.IO.Streams as Streams
import Database.MySQL.Base

convert :: MySQLValue -> String
convert value = TL.unpack(TLE.decodeUtf8(runPut(putTextField(value))))

matrizToList :: [[MySQLValue]] -> [MySQLValue]
matrizToList (x:xs) = x

getName :: [MySQLValue] -> MySQLValue
getName (id:name:tail) = name

getCPF :: [MySQLValue] -> MySQLValue
getCPF (id:name:cpf:tail) = cpf

getMatricula :: [MySQLValue] -> MySQLValue
getMatricula (id:name:cpf:matricula:tail) = matricula

getProfissao :: [MySQLValue] -> MySQLValue
getProfissao (id:name:cpf:matricula:profissao:tail) = profissao