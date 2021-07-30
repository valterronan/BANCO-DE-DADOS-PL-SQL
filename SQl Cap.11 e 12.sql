CAPITULO 11

--Criando  VIEW
CREATE OR REPLACE VIEW V_ALUNO
AS
  SELECT COD_ALUNO AS CODIGO, SALARIO, ESTADO,
         NOME AS ALUNO, CIDADE
  FROM TALUNO
  WHERE ESTADO='RS';

--Usando a view
SELECT * FROM V_ALUNO
ORDER BY ALUNO;

SELECT * FROM TALUNO;

--Criando  VIEW
CREATE OR REPLACE VIEW V_CONTRATO_TOP
AS
  SELECT COD_CONTRATO, DESCONTO
  FROM   TCONTRATO
  WHERE  DESCONTO >= 10;

SELECT * FROM V_CONTRATO_TOP;

--Nome e conteudo das views
SELECT VIEW_NAME, TEXT
FROM USER_VIEWS;
--ALL retorna view de todos os usuario

--View com parametros de saida
CREATE OR REPLACE VIEW V_ALUNO2(COD, ALUNO, SAL)
AS
  SELECT COD_ALUNO, NOME, SALARIO
  FROM TALUNO;

SELECT * FROM V_ALUNO2;

--View Complexa trunc max avg count
CREATE OR REPLACE VIEW V_CONTRATO
AS
  SELECT Trunc(DATA) AS DATA,
         Max(DESCONTO) MAXIMO,
         Avg(DESCONTO) MEDIA,
         Count(*) QTDE
  FROM TCONTRATO
  GROUP BY Trunc(DATA);

SELECT * FROM V_CONTRATO;

--View Simples
CREATE OR REPLACE VIEW V_PESSOA_F
AS
  SELECT COD_PESSOA, TIPO, NOME, COD_RUA AS RUA
  FROM TPESSOA
  WHERE TIPO='F';

--Retorna atraves do tipo F
select * from V_PESSOA_F;

--Exemplo de consulta usando view e tabela
SELECT PES.COD_PESSOA AS CODIGO, 
       PES.NOME AS PESSOA,
       CID.NOME AS CIDADE,
       RUA.NOME AS RUA
FROM V_PESSOA_F PES, TRUA RUA, TCIDADE CID
WHERE PES.RUA = RUA.COD_RUA (+)
AND CID.COD_CIDADE = RUA.COD_CIDADE
ORDER BY PES.NOME;

--OPERACAO DML NA VIEW
CREATE OR REPLACE VIEW vcursos1000ck
  AS
   SELECT cod_curso, nome, valor
   FROM   TCurso
   WHERE  VALOR = 1000
   WITH CHECK OPTION CONSTRAINT vcursos1000_ck;


INSERT INTO vCursos1000ck
         (cod_curso, nome, valor)
VALUES   (52,'TESTE Y', 1000);

SELECT * FROM tCurso;

--delete em view
SELECT * FROM V_ALUNO;
--
DELETE FROM V_ALUNO WHERE CODIGO = 3

--insert em view
INSERT INTO V_ALUNO
VALUES (50, 500, 'RS','MARIA', 'NH');

COMMIT;

--delete em view
--(nao pode fazer DML em view complexa)
DELETE FROM V_CONTRATO;

--View somente leitura (Nao permite DML)
CREATE OR REPLACE VIEW V_ALUNO3
AS
  SELECT COD_ALUNO CODIGO,
         NOME ALUNO, CIDADE
  FROM TALUNO
  WHERE ESTADO='RS'
  WITH READ ONLY;

--Nao pode executar delete em view
--somente leitura.
DELETE FROM V_ALUNO3;

--Excluindo visao
DROP VIEW V_ALUNO3;


--CAPITULO 12

INSERT INTO TAluno (Cod_Aluno, Nome)
VALUES (Seq_Aluno1.NEXTVAL,'MASTER TRAINING 2');
--Proximo VALOR

SELECT * FROM TALUNO;
COMMIT;

SELECT * FROM USER_SEQUENCES;--Seleciona sequencias criadas pelo usuario atual

--Retorna o proximo valor da sequencia  
SELECT SEQ_ALUNO1.CURRVAL FROM DUAL;

--Alterar Valor da Sequencia
ALTER SEQUENCE SEQ_ALUNO1 MAXVALUE  500;
--Deletar sequencia
DROP SEQUENCE SEQ_ALUNO1;

CREATE SEQUENCE SEQ_ALUNO1 START WITH 80;--Sequencia crida

--Indices Secundario
SELECT NOME FROM TALUNO--Retorna todos os registros de nome q contem a letra A
WHERE NOME LIKE '%A%';    --F9

CREATE INDEX IND_TALUNO_NOME ON TALUNO(NOME);--INDEX criado

SELECT nome FROM TALUNO--Retorna todos os registros de nome q contem as letras sequencisis 'MA'
WHERE NOME LIKE '%MA%';   --F9

--
CREATE INDEX IND_TALU_NOMECIDADE--INDEX criada
ON TALUNO(NOME, CIDADE);

SELECT nome,cidade FROM TALUNO--Retorna nesse caso nome e cidade que contenham a letra 'A'
WHERE NOME LIKE '%A%' AND CIDADE LIKE '%A%';

SELECT * FROM USER_INDEXES;--Seleciona todas os INDEX criados pelo usuario
--ALL retorna de todos os usuarios

--Exclui index
DROP INDEX IND_TALU_NOMECIDADE;

--Sinonimos(apelidar tabela) nesse caso o select funciona com o nome da coluna e com o sinonimo tambem
CREATE SYNONYM TALUNO1 FOR TALUNO;
--DROP SYNONYM TALUNO1; exclui sinonimo

SELECT * FROM TALUNO;
SELECT * FROM ALUNO1;

--FIM
