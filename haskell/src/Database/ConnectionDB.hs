{-# LANGUAGE OverloadedStrings #-}

module Database.ConnectionDB where
import Database.MySQL.Base

connectionDB :: ConnectInfo
connectionDB = defaultConnectInfo {ciHost="10.11.19.23", ciUser = "remote", ciPassword = "123", ciDatabase = "projetoPLP"}
    
connectDB :: IO MySQLConn
connectDB = connect connectionDB