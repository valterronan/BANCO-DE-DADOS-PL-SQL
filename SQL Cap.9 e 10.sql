--CAPITULO 9

CREATE TABLE TESTE
(
  CODIGO INTEGER NOT NULL PRIMARY KEY,
  DATA DATE DEFAULT SYSDATE
);

INSERT INTO TESTE (CODIGO) VALUES (1);
INSERT INTO TESTE (CODIGO,DATA) VALUES (2,'03/08/2013');

SELECT * FROM TESTE;

--Tipos de Dados

--VARCHAR2(10) -> 'MARCIO'
--CHAR(10);    -> 'MARCIO    '
--NUMBER(5,2)  -> 999.99


--Retorna tabelas criadas pelo usuario - USER_TABLES (View)
SELECT * FROM USER_TABLES;
--Retorna tabelas criadas por todos os usuario
SELECT * FROM ALL_TABLES;

CREATE TABLE TCONTRATO_VIP--Criando tabela com resultados de valor de contrato >(maior) q 500 
AS
 SELECT * FROM TCONTRATO WHERE TOTAL > 500;

SELECT * FROM TCONTRATO_VIP;

--add coluna valor na tabela tcontrato_vip
ALTER TABLE TCONTRATO_VIP ADD VALOR NUMBER(5,2); -- 999,99

--alterar coluna de number(5,2) p/ (8,2)
ALTER TABLE TCONTRATO_VIP MODIFY VALOR NUMBER(8,2); --

--alterar coluna
ALTER TABLE TCONTRATO_VIP MODIFY VALOR NUMBER(12,2) DEFAULT 0;

--Renomear coluna valor´para valor2
ALTER TABLE TCONTRATO_VIP RENAME COLUMN VALOR TO VALOR2;

--excluir coluna valor2
ALTER TABLE TCONTRATO_VIP DROP COLUMN VALOR2;

--excluir tabela
DROP TABLE TCONTRATO_VIP;

--Renomear tabela tcontrato p/ contrato_top
RENAME TCONTRATO TO TCONTRATO_TOP;

SELECT * FROM TCONTRATO_TOP;
--Renomeando a tabela de tcontrato_top p/ tcontrato
RENAME TCONTRATO_TOP TO TCONTRATO;

SELECT * FROM TCONTRATO;

--comentario na tabela -
COMMENT ON TABLE TCONTRATO IS 'Informações de Contratos';

--comentario na coluna da tabela
COMMENT ON COLUMN TCONTRATO.COD_CONTRATO IS 'Código do Contrato';

COMMENT ON COLUMN TCONTRATO.DATA IS 'Data de emissão do Contrato';
--Retorna o comentario
SELECT * FROM USER_COL_COMMENTS WHERE TABLE_NAME='TCONTRATO'

SELECT * FROM USER_TAB_COMMENTS WHERE TABLE_NAME='TCONTRATO'

--Desabilita a coluna
ALTER TABLE TCONTRATO ADD TOTAL2 NUMERIC(8,2);--Alterando tabela tcontrato add total2 

ALTER TABLE TCONTRATO SET UNUSED (TOTAL2)--UNUSED Desabilita a tabela

SELECT * FROM TCONTRATO

--Excluir colunas nao usadas
ALTER TABLE TCONTRATO DROP UNUSED COLUMNS;

--Truncate table exclui todos registros da tabela
--Não tem clausula where e não tem commit/rollback 
TRUNCATE TABLE NOME_TABELA;--Exemplo


CAPITULO 10
--PK E FK

--TALUNO
--COD_ALUNO - PK -> Chave Primaria -> PRIMARY KEY

--TCONTRATO
--COD_CONTRATO - PK -> Chave Primaria -> PRIMARY KEY
--COD_ALUNO - FK -> Chave primaria que vem de outra tabela

SELECT * FROM USER_CONSTRAINTS;--Seleciona constraints criadas pelo usuario atual

SELECT * FROM ALL_CONSTRAINTS;--Seleciona constraints criadasp por todos os usuario

--DROP TABLE tcidade

CREATE TABLE tcidade--Criando tabela
(
  cod_cidade INTEGER NOT NULL,
  nome VARCHAR2(40),
  CONSTRAINT pk_cidade PRIMARY KEY(cod_cidade)
);


CREATE TABLE tbairro--Criando tabela
(
  cod_cidade INTEGER NOT NULL,
  cod_bairro INTEGER NOT NULL,
  nome       VARCHAR2(40),
  CONSTRAINT pk_bairro PRIMARY KEY(cod_cidade,cod_bairro)
);

      1 - 1
      1 - 2
      2 - 1
      2 - 2

--Add chave estrangeira
ALTER TABLE tbairro ADD CONSTRAINT fk_cod_cidade
FOREIGN KEY (COD_CIDADE)
REFERENCES tcidade(COD_CIDADE);

CREATE TABLE trua
(
  cod_rua INTEGER NOT NULL,
  cod_cidade INTEGER ,
  cod_bairro INTEGER ,
  nome VARCHAR(40),
  CONSTRAINT pk_rua PRIMARY KEY(cod_rua)
);

ALTER TABLE TRUA ADD CONSTRAINT fk_cidadebairro
FOREIGN KEY(cod_cidade, cod_bairro)
REFERENCES tbairro(cod_cidade, cod_bairro);

--DROP TABLE tpessoa  (Fornec ou Cliente)
CREATE TABLE tpessoa (
  cod_pessoa INTEGER      NOT NULL,
  tipo       VARCHAR2(1)  NOT NULL,
  nome       VARCHAR2(30) NOT NULL,
  pessoa     VARCHAR2(1)  NOT NULL,
  cod_rua    INTEGER      NOT NULL,
  cpf        VARCHAR2(15) ,
  CONSTRAINT pk_pessoa PRIMARY KEY (cod_pessoa)
);

--ALTER TABLE TPESSOA DROP CONSTRAINT NOME_CONSTRAINT
ALTER TABLE TPESSOA ADD CONSTRAINT FK_PESSOA_RUA
FOREIGN KEY (COD_RUA)
REFERENCES TRUA;


-----Cidade
INSERT INTO TCIDADE VALUES(1,'NOVO HAMBURGO');
INSERT INTO TCIDADE VALUES(2,'IVOTI');
INSERT INTO TCIDADE VALUES(3,'SAPIRANGA');
INSERT INTO TCIDADE VALUES(4,'TAQUARA');

SELECT * FROM TCIDADE

-----Bairro
INSERT INTO TBAIRRO VALUES(1,1,'CENTRO');
INSERT INTO TBAIRRO VALUES(2,1,'RIO BRANCO');
INSERT INTO TBAIRRO VALUES(3,1,'CENTRO');
INSERT INTO TBAIRRO VALUES(4,1,'FRITZ');


-----Rua
INSERT INTO TRUA VALUES (1,1,1,'MARCILIO DIAS');
INSERT INTO TRUA VALUES (2,2,1,'FRITZ');
INSERT INTO TRUA VALUES (3,3,1,'JACOBINA');
INSERT INTO TRUA VALUES (4,3,1,'JOAO DA SILVA');
Select * from trua;

--Check tipo da pessoa ´so aceita 'c' 'f'
ALTER TABLE TPESSOA ADD CONSTRAINT CK_PESSOA_TIPO
CHECK (TIPO IN ('C','F'));

select * from tpessoa;
ALTER TABLE TPESSOA ADD CONSTRAINT CK_PESSOA_JF
CHECK (PESSOA IN ('J','F'));

--Unique Key não aceita valores para CPF iguais
ALTER TABLE TPESSOA ADD CONSTRAINT UK_CPF UNIQUE(CPF);
--Excluir constraint criada
ALTER TABLE TPESSOA DROP CONSTRAINT UK_CPF;

DELETE FROM TPESSOA;
--Inserindo linhas tabela tpessoa
INSERT INTO TPESSOA VALUES(1,'C','MARCIO','F',1,'1234');
INSERT INTO TPESSOA VALUES(2,'F','BEATRIZ','F',2,'123');
INSERT INTO TPESSOA VALUES(3,'F','PEDRO','F',4,'1238');
INSERT INTO TPESSOA VALUES(4,'C','MARIA','J',3,'1239');

SELECT * FROM TPESSOA

--Foreign Key Drop
--ALTER TABLE TPESSOA DROP CONSTRAINT NOME_CONSTRAINT
--CASCADE CONSTRAINT;

--Check
ALTER TABLE TCONTRATO
ADD CONSTRAINT CK_CONTRATO_DESCONTO
CHECK (DESCONTO BETWEEN 0 AND 30);

SELECT * FROM TCONTRATO

--Desabilitando/Habilitando constraint
ALTER TABLE TPESSOA DISABLE CONSTRAINT uk_cpf;
ALTER TABLE TPESSOA ENABLE CONSTRAINT uk_cpf;

--Excluir Constraint
ALTER TABLE TPESSOA DROP CONSTRAINT uk_cpf;

SELECT * FROM user_constraints--Retorna Constraints criadas na tabela tpessoa
WHERE table_name = 'TPESSOA';

--Retorna consntraint e as colunas associadas na tabela tpessoa
SELECT constraint_name, column_name
FROM user_cons_columns
WHERE table_name = 'TPESSOA';

--Objetos criado pele usuario atual na tabela tpessoa
SELECT OBJECT_NAME, OBJECT_TYPE
FROM USER_OBJECTS
WHERE OBJECT_NAME IN ('TPESSOA')

SELECT * FROM TPESSOA

COMMIT;

--FIM