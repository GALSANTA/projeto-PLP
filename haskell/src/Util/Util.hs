module Util.Util where
import Database.MySQL.Protocol.MySQLValue
import Data.Binary.Put
import Data.Text as TS
import Data.Text.Lazy.Encoding as TLE
import Data.Text.Lazy as TL

convert :: MySQLValue -> String
convert value = TL.unpack(TLE.decodeUtf8(runPut(putTextField(value))))

matrizToList :: [[MySQLValue]] -> [MySQLValue]
matrizToList (x:xs) = x

getName :: [MySQLValue] -> MySQLValue
getName (id:name:tail) = name

getCPF :: [MySQLValue] -> MySQLValue
getCPF (id:name:cpf:tail) = cpf