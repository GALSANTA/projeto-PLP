module Util.Entry where

lerEntrada :: IO String
lerEntrada = do
    x <- getLine
    return x