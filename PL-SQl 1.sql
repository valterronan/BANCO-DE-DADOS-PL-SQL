--PL/SQL ORACLE

--Bloco anonimo

DECLARE
  x INTEGER;
  y INTEGER;
  c INTEGER;
BEGIN
  x :=10;
  y :=20;
  c := x + y;
  dbms_output.put_line('RESULTADO: '||c); --Imprime resultado
END;  


DECLARE
  VDESCONTO NUMBER(6,2) := 0.50;
  VCIDADE  VARCHAR(30)  :='NOVO HAMBURGO';
  VCOD_ALUNO TALUNO.COD_ALUNO%TYPE := 5;
  VTOTAL    NUMBER(8,2) := 1345.89;
BEGIN
  VTOTAL := ROUND(VTOTAL * VDESCONTO, 2);
  dbms_output.put_line('TOTAL: ' || VTOTAL);
  VDESCONTO  := 1.20;
  VCIDADE    := INITCAP(VCIDADE);
  dbms_output.put_line('cidade: ' || vcidade);
  dbms_output.put_line('desconto: ' || vdesconto);
  dbms_output.put_line('alunoo: ' || vcod_aluno);
END; 

--Update atualizar valor conforme carga horaria
DECLARE
  VVALOR TCURSO.VALOR%TYPE := &VALOR;
BEGIN
  UPDATE TCURSO SET
  VALOR = VALOR + VVALOR
  WHERE CARGA_HORARIA >=30;
END;

SELECT * FROM TCURSO;

--Cursores
DECLARE
   vcod_aluno taluno.cod_aluno%type;
   vnome  taluno.nome%type;
   CURSOR c1 IS
     SELECT cod_aluno, nome
     FROM TALUNO;
BEGIN
   OPEN c1;
   LOOP
      FETCH c1 INTO vcod_aluno, vnome;
      EXIT WHEN c1%ROWCOUNT >= 10 OR c1%NOTFOUND;
      Dbms_output.put_line('codigo; '||
        lpad(vcod_aluno,4,'0')||'-'||'nome: '||vnome);
   END LOOP;
   CLOSE c1;
END;

--Cursores laços de tabelas
DECLARE
  CURSOR c1 IS
    SELECT * FROM TALUNO;
  reg taluno%ROWTYPE;
BEGIN
  FOR REG IN c1
  LOOP
    Dbms_output.put_line('codigo: '||
      lpad(reg.cod_aluno,5,'0')||'-' ||'nome: '||reg.nome);
  END LOOP;
END; 

--Procedimento de BD(Procedur)
CREATE OR REPLACE PROCEDURE aumenta_preço
(pCod_curso NUMBER)
IS
BEGIN --AUMENTA 10% DO VALOR DO CURSO
  UPDATE TCURSO SET
  VALOR = VALOR *1.1
  WHERE COD_CURSO = PCOD_CURSO;
END;
  
SELECT * FROM TCURSO;

EXEC AUMENTA_PREÇO(4); --Executa a procedure

--Criando Funções
CREATE OR REPLACE FUNCTION CONSULTA_PREÇO
(PCOD_CURSO NUMBER) RETURN NUMBER
AS
 VVALOR NUMBER;
BEGIN
  SELECT VALOR INTO VVALOR FROM TCURSO
  WHERE COD_CURSO = PCOD_CURSO;
  RETURN(VVALOR);
END;  
        
--Utilizando função criada
DECLARE
  vcod NUMBER :=&codigo;
  vvalor NUMBER;
BEGIN 
  vvalor := consulta_preço(vcod);
  Dbms_output.put_line('preço do curso; '||VVALOR);
END; 

CREATE OR REPLACE FUNCTION EXISTE_ALUNO--(corrigir erro
( pcod_aluno IN taluno.cod_aluno&type)
RETURN BOOLEAN
IS
 valuno  NUMBER(10);
BEGIN
  SELECT COD_ALUNO
  INTO   VALUNO
  FROM   TALUNO
  WHERE cod_aluno = pcod_aluno;
  RETURN( TRUE );
EXCEPTION
  WHEN others THEN
    RETURN( FALSE );
END;

DECLARE
  vcodigo INTEGER := 1;
BEGIN 
  IF EXISTE_ALUNO(VCODIGO) THEN
    Dbms_output.put_line('codigo encontrado');
  ELSE  
     Dbms_output.put_line('codigo não encontrado');
  END IF;
END;  

--Especificações ou declarações
CREATE OR REPLACE PACKAGE PKG_ALUNO
IS
  vcidade varchar(30);
  vmedia number(8,2);
  vnome varchar(30);
  PROCEDURE DELETA_ALUNO(PCOD_ALUNO NUMBER);
  PROCEDURE MEDIA_CONTRATOS;
  PROCEDURE CON_ALUNO(PCOD_ALUNO NUMBER);
END;  

CREATE TABLE LOG
( USUARIO VARCHAR(30),
  HORARIO DATE,
  VALOR_ANTIGO VARCHAR(10),
  VALOR_NOVO VARCHAR(10)
 ); 

--Criando Trigger
CREATE OR REPLACE TRIGGER GERA_LOG_ALT
AFTER UPDATE OF TOTAL ON TCONTRATO
DECLARE
--Variaveis
BEGIN
  INSERT INTO LOG(USUARIO, HORARIO) VALUES(USER, SYSDATE);
END;  

SELECT * FROM TCONTRATO;
UPDATE TCONTRATO SET TOTAL = 2000 WHERE COD_CONTRATO = 3;

SELECT * FROM LOG;

--Alterar o formato da data(nesse caso vai mostrar só hr)
ALTER SESSION SET NLS_DATE_FORMAT = 'HH24:MI:SS';
--Inserindo coluna na tabela LOG
ALTER TABLE LOG ADD OBS VARCHAR(80);
--Inserindo valores nas colunas
UPDATE LOG SET
OBS = 'OBRIGADO'

--Union e union all
SELECT COD_ALUNO, TOTAL, DESCONTO
FROM TCONTRATO
WHERE COD_ALUNO = 1;

UNION --Traz registros das 2 tabelas

SELECT COD_ALUNO, TOTAL, DESCONTO
FROM TCONTRATO
WHERE TOTAL >= 350;

--Intersect
SELECT COD_CONTRATO, DATA, DESCONTO, TOTAL
FROM TCONTRATO
WHERE DESCONTO IS NOT NULL

INTERSECT--Registros estão presentes em todos os conjuntos

SELECT COD_CONTRATO, DATA, DESCONTO, TOTAL
FROM TCONTRATO
WHERE TOTAL > 350
ORDER BY 1;

--Minus descarta os  valores iguais
SELECT COD_CONTRATO, DATA, DESCONTO, TOTAL
FROM TCONTRATO
WHERE DESCONTO IS NOT NULL

MINUS

SELECT COD_CONTRATO, DATA, DESCONTO, TOTAL
FROM TCONTRATO
WHERE TOTAL > 1500
ORDER BY 1;

--Rollup
SELECT COD_ALUNO, (DATA),
       SUM(DESCONTO) DESCONTO,
       SUM(TOTAL) TOTAL
FROM TCONTRATO
GROUP BY ROLLUP(COD_ALUNO, (DATA));











