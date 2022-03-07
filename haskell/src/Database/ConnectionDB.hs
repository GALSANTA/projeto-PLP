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


verifyData :: String -> String -> String-> IO ([ColumnDef], Streams.InputStream [MySQLValue])
verifyData cpf matricula usuario = do
    let a = TS.pack(cpf)
    let b = TS.pack(matricula) 
    let c = TS.pack(usuario)
    conn <- connectDB
    query <- prepareStmt conn "SELECT * FROM tb_usuario WHERE cpf=? OR matricula=? OR usuario=?"
    queryStmt conn query [MySQLText a, MySQLText b, MySQLText c]

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
-- 1999-02-02 02:02:22
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

inserirTarefa :: String -> String -> String -> String -> String -> String -> IO OK
inserirTarefa id_aluno id_colaborador id_disciplina descricao envio relevancia = do 
    let aluno = TS.pack(id_aluno)
    let colaborador = TS.pack(id_colaborador)
    let disciplina =TS.pack(id_disciplina)
    let aux_descricao = TS.pack(descricao)
    let aux_envio = TS.pack(envio)
    let aux_relevancia = TS.pack(relevancia)    
    conn <- connectDB
    execute conn "INSERT INTO tb_tarefa VALUES (NULL,?,?,?,?,?,?)" [MySQLText aluno, MySQLText colaborador,  MySQLText disciplina,  MySQLText aux_descricao, MySQLText aux_envio, MySQLText aux_relevancia]

ordernarTarefasRelevancia :: String -> String -> IO ([ColumnDef], Streams.InputStream [MySQLValue])
ordernarTarefasRelevancia id_aluno relevancia = do
    let aux_aluno = TS.pack(id_aluno)
    let aux_relevancia = TS.pack(relevancia)
    conn <- connectDB
    query <- prepareStmt conn "SELECT * FROM tb_tarefa WHERE aluno_id = ? OR colaborador_id = ? AND relevancia = ?"
    queryStmt conn query [MySQLText aux_aluno, MySQLText aux_aluno, MySQLText aux_relevancia]

ordernarTarefasASC:: String -> IO ([ColumnDef], Streams.InputStream [MySQLValue])
ordernarTarefasASC id_aluno = do
    let aux_aluno = TS.pack(id_aluno)
    conn <- connectDB
    query <- prepareStmt conn "SELECT * FROM tb_tarefa WHERE aluno_id = ? OR colaborador_id = ? ORDER BY relevancia ASC"
    queryStmt conn query [MySQLText aux_aluno, MySQLText aux_aluno]

ordernarTarefasDESC:: String -> IO ([ColumnDef], Streams.InputStream [MySQLValue])
ordernarTarefasDESC id_aluno = do
    let aux_aluno = TS.pack(id_aluno)
    conn <- connectDB
    query <- prepareStmt conn "SELECT * FROM tb_tarefa WHERE aluno_id = ? OR colaborador_id = ? ORDER BY relevancia DESC"
    queryStmt conn query [MySQLText aux_aluno, MySQLText aux_aluno]

    -- INSERT INTO tb_tarefa VALUES (NULL,4,5,3,"tarefa",'1999-01-22',1) 
    -- SELECT * FROM tb_tarefa WHERE aluno_id = 4 OR colaborador_id = 5 ORDER BY relevancia ASC