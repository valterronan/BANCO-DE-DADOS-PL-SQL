--Capitulo 2
SELECT COD_ALUNO, NOME, CIDADE --Seleciona estes registros na tabela taluno
FROM TALUNO;

SELECT * FROM TALUNO;
--AS renomeia as colunas(apelido)
SELECT COD_ALUNO AS "Código", NOME AS "Nome do Aluno"
FROM TALUNO;

SELECT CIDADE FROM TALUNO;-- todas colunas tem que ser iguais a da tabela
SELECT DISTINCT CIDADE FROM TALUNO;--Distinct retira linhas duplicadas

SELECT DISTINCT CIDADE, COD_ALUNO--Nao agrupa pois cod_aluno diferente para cada linha
FROM TALUNO
ORDER BY CIDADE;

SELECT NOME AS CURSO,
       VALOR,
       VALOR/CARGA_HORARIA,
       Round(VALOR/CARGA_HORARIA,2) AS VALOR_HORA
FROM TCURSO
ORDER BY VALOR_HORA;
--Apelido de coluna só funciona em ORDER BY

SELECT * FROM TCONTRATO;

--calculo com coluna = NULL
UPDATE TCONTRATO SET--alteraar deconto para null
DESCONTO = NULL
WHERE COD_CONTRATO = 4;

SELECT COD_CONTRATO,--calculo com coluna = NULL resultado = NULL
       TOTAL,
       DESCONTO,
       TOTAL+DESCONTO
FROM TCONTRATO;

SELECT COD_CONTRATO,
       DESCONTO,
       Nvl(DESCONTO,0),--Troca o null pelo 0
       TOTAL,
       TOTAL + Nvl(DESCONTO,0) AS TOTAL_MAIS_DESCONTO
FROM TCONTRATO;

SELECT COD_ALUNO || ' - ' || NOME || ' // ' || CIDADE AS ALUNO
FROM TALUNO
ORDER BY COD_ALUNO;

--VARIAVEIS
--INTEGER      - 1, 2 -- numero inteiro -> number(38)
--NUMBER(5,2)  - 999,99
--NUMERIC(5,2) - 999,99
--DATE         - '10/03/2011 00:00:00'
--VARCHAR(10)  -- Sinonimo
--VARCHAR2(10) - 'MARCIO'
--CHAR(10)     - 'MARCIO    '  conta todos os espaços

CAPITULO 3

SELECT * FROM TALUNO;

-- ALTER TABLE TALUNO DROP COLUMN COLUNA;
ALTER TABLE TALUNO ADD ESTADO CHAR(2) DEFAULT 'RS';--acrescenta coluna com registros ja enseridos

ALTER TABLE TALUNO ADD SALARIO NUMBER(8,2) DEFAULT 620;

UPDATE TALUNO SET--alterando registros da tabela
ESTADO = 'AC' ,
SALARIO = 250
WHERE COD_ALUNO = 1;

UPDATE TALUNO SET
ESTADO = 'MT',  SALARIO = 2000
WHERE COD_ALUNO = 2;

UPDATE TALUNO SET
ESTADO = 'SP', SALARIO = 800
WHERE COD_ALUNO = 5;

SELECT * FROM TALUNO--Select traz estado diferente de rs salario igual ou menor q 800
WHERE ESTADO <> 'RS'
AND  SALARIO <= 800
ORDER BY SALARIO DESC;

INSERT INTO TALUNO (COD_ALUNO, NOME,CIDADE)--Inserindo linhas na tabela
VALUES (SEQ_ALU.NEXTVAL,'VALDO','DOIS IRMAOS');

INSERT INTO TALUNO (COD_ALUNO, NOME,CIDADE)
VALUES (SEQ_ALU.NEXTVAL,'ALDO','QUATRO IRMAOS');

UPDATE TALUNO SET--Aterando registros na tabela
ESTADO = 'SP',
SALARIO = 900,
NOME = 'PEDRO'
WHERE COD_ALUNO = 6;

SELECT * FROM TALUNO;

SELECT ESTADO, SALARIO, NOME FROM TALUNO--Select registros ordem estado
ORDER BY ESTADO, SALARIO DESC;

ALTER TABLE TALUNO ADD NASCIMENTO DATE DEFAULT SYSDATE - 1000;--Inserindo coluna na tabela

SELECT SYSDATE - 10 FROM DUAL;--Seleciona data -10 dias

UPDATE TALUNO SET--Alterando registros
NASCIMENTO='30/06/1991'
WHERE COD_ALUNO=4;

--
UPDATE TALUNO SET
NASCIMENTO='05/03/1996'
WHERE COD_ALUNO=7;

--Trunc
SELECT COD_ALUNO, NASCIMENTO, Trunc(NASCIMENTO) AS nascimento, NOME
FROM TALUNO
WHERE Trunc(NASCIMENTO) = '25/07/2006'

SELECT COD_CONTRATO, DATA, TOTAL,
       DESCONTO, DESCONTO + 1000 AS CALCULO
FROM TCONTRATO
WHERE TOTAL <= DESCONTO + 1000;

UPDATE TCONTRATO SET--Alterando regisro para null
DESCONTO = NULL
WHERE COD_CONTRATO = 2;

SELECT * FROM TCONTRATO
WHERE DESCONTO IS NOT NULL;--Seleciona registrs not null

SELECT * FROM TCONTRATO--Seleciona registros null
WHERE DESCONTO IS NULL;

SELECT * FROM TCONTRATO--Seleciona desconto de 0 a 10
WHERE DESCONTO BETWEEN 0 AND 10;

--Nvl 0> Colunar com valor null
SELECT COD_CONTRATO, TOTAL, DESCONTO, NVL(DESCONTO,0)
FROM TCONTRATO
WHERE NVL(DESCONTO,0) BETWEEN 0 AND 10;--BETWEEN -> Entre

SELECT * FROM TCONTRATO--Mesmo efeito do between
WHERE DESCONTO >= 0
AND DESCONTO <= 10
OR DESCONTO IS NULL;

--  IN  /// NOT IN
SELECT * FROM TITEM
WHERE COD_CURSO IN (1, 2, 4);--IN busca somente os registros descritos
--NOT IN
SELECT * FROM TITEM
WHERE COD_CURSO NOT IN (1, 2, 4);--Not IN registros que não foram descritos

SELECT * FROM TCURSO

INSERT INTO TCURSO VALUES (5, 'WINDOWS', 1000, 50 );--Inserindo linha tabela tcurso

--Select cursos não vendidos
SELECT * FROM TCURSO
WHERE COD_CURSO NOT IN (SELECT COD_CURSO FROM TITEM)


--Select cursos vendidos
SELECT * FROM TCURSO
WHERE COD_CURSO IN (SELECT COD_CURSO FROM TITEM)

--OR equivalente ao SELECT IN
SELECT * FROM TITEM
WHERE COD_CURSO = 1
OR COD_CURSO    = 2
OR COD_CURSO    = 4;

SELECT * FROM TCURSO WHERE NOME LIKE 'W%'     --Registros que inicia com W
SELECT * FROM TCURSO WHERE NOME LIKE '%JAVA%'

ALTER TABLE TCURSO ADD PRE_REQ INTEGER;--Inserindo coluna na tabela

UPDATE TCURSO SET--Alterando registro coluna pre_req
PRE_REQ = 1
WHERE COD_CURSO = 2;

UPDATE TCURSO SET
PRE_REQ = 3
WHERE COD_CURSO = 4;

--cursos sem pre requisito
SELECT * FROM TCURSO WHERE PRE_REQ IS NULL

--cursos com pre-requisitos
SELECT * FROM TCURSO WHERE PRE_REQ IS NOT NULL

--Precedencia de operadores
-- ()
-- AND
-- OR
SELECT * FROM tcurso--Seleciona valor maior que 750 ou menor q 1000 ou carga horaio = 25
WHERE valor > 750
OR valor < 1000
AND carga_horaria = 25

SELECT * FROM tcurso--Parentese no valor não traz o resultado do valor
WHERE (valor > 750
or valor < 1000)
and carga_horaria = 25;

-- Ordem de execução
-- 1 - Paranteses
-- 2 - AND
-- 3 - OR



