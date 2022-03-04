{-# LANGUAGE OverloadedStrings #-}

module Controllers.ProfessorController where
import Util.Entry as Entry
import qualified System.IO.Streams as Streams
import Data.Text as TS
import Data.Word
import Database.ConnectionDB as ConnectionDB
import Database.MySQL.Base
import System.Console.ANSI

atualizaNota:: (String -> IO ()) -> IO()
atualizaNota originalMenu = do
    clearScreen
    putStrLn("Id da disciplina: ")
    id_d <- Entry.lerInt
    putStrLn("Id aluno: ")
    id_a <- Entry.lerInt
    putStrLn("Nota do aluno: ")
    n <- Entry.lerInt

    (defs, is) <- verifyDisciplinaAluno id_d id_a
    matriz <- Streams.toList is

    validateDisciplina originalMenu matriz id_d id_a n


retornaInteger:: Int -> Integer
retornaInteger num = fromIntegral num

retornaWord32:: Int -> Word32
retornaWord32 num = fromInteger (retornaInteger num)

updateDb :: Int -> Int -> Int -> IO OK
updateDb disciplina aluno nota = do
    let d = retornaWord32 disciplina
    let a = retornaWord32 aluno
    let n = retornaWord32 nota
    conn <- ConnectionDB.connectDB
    execute conn "UPDATE tb_aluno_disciplina SET nota=? WHERE aluno_id=? AND disciplina_id=?" [MySQLInt32U n, MySQLInt32U a, MySQLInt32U d]

verifyDisciplinaAluno:: Int -> Int -> IO ([ColumnDef], Streams.InputStream [MySQLValue])
verifyDisciplinaAluno id_disciplina id_aluno = do
    let a = retornaWord32 id_aluno
    let d = retornaWord32 id_disciplina
    conn <- ConnectionDB.connectDB
    query <- prepareStmt conn "SELECT * FROM tb_aluno_disciplina WHERE aluno_id=? AND disciplina_id=?"
    queryStmt conn query [MySQLInt32U a, MySQLInt32U d]

validateDisciplina:: (String -> IO ()) -> [[MySQLValue]] -> Int -> Int -> Int -> IO()
validateDisciplina originalMenu matriz disciplina aluno nota = if matriz /= []
        then do
            updateDb disciplina aluno nota
            originalMenu("Nota atualizada com sucesso!")
    else
        originalMenu("Aluno não está cursando a disciplina!")