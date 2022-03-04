{-# LANGUAGE OverloadedStrings #-}

module Database.ConnectionDB where
import Database.MySQL.Base
import qualified System.IO.Streams as Streams
import Data.Text as TS

connectionDB :: ConnectInfo
connectionDB = defaultConnectInfo {ciHost="10.11.19.23", ciUser = "remote", ciPassword = "123", ciDatabase = "projetoPLP"}
    
connectDB :: IO MySQLConn
connectDB = connect connectionDB

insertUser :: String -> String -> String -> String -> String -> String -> IO OK
insertUser nome cpf usuario senha matricula profissao = do
    let n = TS.pack(nome)
    let c = TS.pack(cpf)
    let u = TS.pack(usuario)
    let s = TS.pack(senha)
    let m = TS.pack(matricula)
    let p = TS.pack(profissao)
    conn <- connectDB
    execute conn "INSERT INTO tb_usuario VALUES (NULL, ?, ?, ?, ?, ?, ?)" [MySQLText n, MySQLText c, MySQLText m, MySQLText p, MySQLText u, MySQLText s]

getUser :: String -> String -> IO ([ColumnDef], Streams.InputStream [MySQLValue])
getUser user password = do
    let a = TS.pack(user)
    let b = TS.pack(password) 
    conn <- connectDB
    query <- prepareStmt conn "SELECT * FROM tb_usuario WHERE usuario=? AND senha=?"
    queryStmt conn query [MySQLText a, MySQLText b]


verifyData :: String -> String -> IO ([ColumnDef], Streams.InputStream [MySQLValue])
verifyData cpf matricula = do
    let a = TS.pack(cpf)
    let b = TS.pack(matricula) 
    conn <- connectDB
    query <- prepareStmt conn "SELECT * FROM tb_usuario WHERE cpf=? OR matricula=?"
    queryStmt conn query [MySQLText a, MySQLText b]

validateRegistry:: (String -> IO ()) -> [[MySQLValue]] -> String -> String -> String -> String -> String -> String -> IO()
validateRegistry originalMenu matriz nome cpf usuario senha matricula profissao =if matriz == []
        then do
            insertUser nome cpf usuario senha matricula profissao
            originalMenu("Usuário cadastrado com sucesso!")
    else
        originalMenu("Usuário já cadastrado!")

verifyDisciplina :: String -> String -> IO ([ColumnDef], Streams.InputStream [MySQLValue])
verifyDisciplina aluno_id disciplina_id = do
    let a = TS.pack(aluno_id)
    let b = TS.pack(disciplina_id)
    conn <- connectDB
    query <- prepareStmt conn "SELECT * FROM tb_aluno_disciplina WHERE aluno_id=? AND disciplina_id=?"
    queryStmt conn query [MySQLText a, MySQLText b]

inserirDisciplina :: String -> String -> IO OK
inserirDisciplina aluno_id disciplina_id = do
    let a = TS.pack(aluno_id)
    let b = TS.pack(disciplina_id)
    conn <- connectDB
    execute conn "INSERT INTO tb_aluno_disciplina VALUES (?, ?, 0)" [MySQLText a, MySQLText b]

cadeiras :: String -> String -> IO ([ColumnDef], Streams.InputStream [MySQLValue])
cadeiras periodo quantidade = do
    let a = TS.pack(periodo)
    let b = TS.pack(quantidade) 
    conn <- connectDB
    query <- prepareStmt conn "SELECT id_disciplina, nome_disciplina, nome  FROM tb_disciplina AS A INNER JOIN tb_usuario AS B ON B.id_usuario = A.professor_id WHERE (A.tipo=? OR A.tipo='O') ORDER BY id_disciplina LIMIT ?"
    queryStmt conn query [MySQLText a, MySQLText b]

getCountDependencia :: String -> IO ([ColumnDef], Streams.InputStream [MySQLValue])
getCountDependencia id_disciplina = do 
    let a = TS.pack(id_disciplina)
    conn <- connectDB
    query <- prepareStmt conn "SELECT COUNT(*) FROM tb_dependencia WHERE id=?"
    queryStmt conn query [MySQLText a]

getCountDependenciaAluno :: String -> String -> IO ([ColumnDef], Streams.InputStream [MySQLValue])
getCountDependenciaAluno id_disciplina aluno_id = do
    let a = TS.pack(aluno_id)
    let b = TS.pack(id_disciplina)
    conn <- connectDB
    query <- prepareStmt conn "SELECT COUNT(*) FROM tb_dependencia AS A JOIN tb_aluno_disciplina AS B ON (A.disciplina_id = B.disciplina_id AND aluno_id=?) WHERE id=?"
    queryStmt conn query [MySQLText a, MySQLText b]

showDependencia :: String -> IO ([ColumnDef], Streams.InputStream [MySQLValue])
showDependencia id_disciplina  = do
    let a = TS.pack(id_disciplina)
    conn <- connectDB
    query <- prepareStmt conn "SELECT disciplina_id, nome_disciplina, nome FROM tb_dependencia AS A JOIN tb_disciplina AS B ON (A.disciplina_id = B.id_disciplina) INNER JOIN tb_usuario AS C ON (C.id_usuario = B.professor_id) WHERE id=?"
    queryStmt conn query [MySQLText a]

showDependenciaClosed :: String -> String -> IO ([ColumnDef], Streams.InputStream [MySQLValue])
showDependenciaClosed id_disciplina aluno_id  = do
    let a = TS.pack(aluno_id)
    let b = TS.pack(id_disciplina)
    conn <- connectDB
    query <- prepareStmt conn "SELECT A.disciplina_id, nome_disciplina, nome FROM tb_dependencia AS A JOIN tb_aluno_disciplina AS B ON (A.disciplina_id = B.disciplina_id AND aluno_id=?) INNER JOIN tb_disciplina AS C ON (B.disciplina_id = C.id_disciplina) INNER JOIN tb_usuario AS D ON (D.id_usuario = C.professor_id) WHERE id=?"
    queryStmt conn query [MySQLText a, MySQLText b]


    -- SELECT A.disciplina_id, nome_disciplina, nome FROM tb_dependencia AS A 
    -- JOIN tb_aluno_disciplina AS B ON (A.disciplina_id = B.disciplina_id AND aluno_id=4)
    -- INNER JOIN tb_disciplina AS C ON (B.disciplina_id = C.id_disciplina)
    -- INNER JOIN tb_usuario AS D ON (D.id_usuario = C.professor_id)
    -- WHERE id=11

    -- SELECT disciplina_id, nome_disciplina, nome FROM tb_dependencia AS A JOIN tb_disciplina AS B ON (A.disciplina_id = B.id_disciplina) INNER JOIN tb_usuario AS C ON (C.id_usuario = B.professor_id) WHERE id=11
