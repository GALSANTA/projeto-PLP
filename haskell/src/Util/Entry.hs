module Util.Entry where

lerEntrada :: IO String
lerEntrada = do
    x <- getLine
    return x

lerInt:: IO Int
lerInt = do
    s <-getLine
    return (read s)