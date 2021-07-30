--Order by CUBE
SELECT COD_ALUNO,
      TRUNC(DATA),
      SUM (TOTAL)
FROM TCONTRATO
GROUP BY CUBE(COD_ALUNO, TRUNC(DATA));

SELECT * FROM TCONTRATO;

--Identifica total geral
SELECT GROUPING(COD_ALUNO), SUM(TOTAL)
FROM TCONTRATO
GROUP BY ROLLUP(COD_ALUNO);

SELECT GROUPING(COD_ALUNO),--Corrigir erro
       CASE
         WHEN GROUPING(COD_ALUNO)=0 THEN TO CHAR(COD_ALUNO)
         ELSE 'TOTAL GERAL:'
       END ALUNO,
       SUM(TOTAL)
FROM TCONTRATO
GROUP BY ROLLUP(COD_ALUNO);

--Grouping Sets  retorna somente subtotais
SELECT TRUNC(DATA), COD_ALUNO, SUM(TOTAL)
FROM TCONTRATO
GROUP BY GROUPING SETS (COD_ALUNO, TRUNC(DATA) );
--Total igual repete o rank
SELECT TRUNC(DATA), COD_ALUNO, SUM(TOTAL),
       RANK() OVER (ORDER BY SUM(TOTAL) DESC) POSI��O
FROM TCONTRATO
GROUP BY (TRUNC(DATA), COD_ALUNO);
--Posi��o por grupo
SELECT TRUNC(DATA),COD_ALUNO,SUM(TOTAL),
       RANK() OVER (PARTITION BY TRUNC(DATA)
         ORDER BY SUM(TOTAL) DESC) POSI�AO
FROM TCONTRATO
GROUP BY (TRUNC(DATA),COD_ALUNO)
ORDER BY COD_ALUNO;

SELECT TRUNC(DATA), SUM(TOTAL) "TOTAL DO DIA",
  LAG  (SUM(TOTAL),1) OVER (ORDER BY TRUNC(DATA)) ANTERIOR,
  LEAD (SUM(TOTAL),1) OVER (ORDER BY TRUNC(DATA)) POSTERIOR
FROM TCONTRATO
GROUP BY TRUNC(DATA)
ORDER BY TRUNC(DATA);

--Insert all (inserir em diversas tabelas)
INSERT ALL
  INTO TCURSO (COD_CURSO,NOME,VALOR)
  INTO TALUNO (COD_ALUNO,NOME,CEP)
      SELECT COD_CONTRATO+50, 'INSERT ALL', 1013
      FROM TCONTRATO
      WHERE COD_CONTRATO=1;

SELECT * FROM TALUNO;      
SELECT * FROM TCURSO;

CREATE SEQUENCE SEQ_CURSO START WITH 100;--Sequencia criada

INSERT ALL
   WHEN TOTAL>=350 THEN
        INTO TCURSO(COD_CURSO,NOME,VALOR)
        VALUES (SEQ_CURSO.NEXTVAL, 'DESCONTO IS NULL', TOTAL)
   WHEN DESCONTO IS NULL THEN
        INTO TCURSO (COD_CURSO,NOME,VALOR)
        VALUES (SEQ_CURSO.NEXTVAL, 'DESCONTO IS NULL', TOTAL)
   SELECT COD_CONTRATO, TOTAL, DESCONTO
   FROM TCONTRATO WHERE COD_CONTRATO = 1;
   
--Merge (atualiza dados de varias tabelas em uma unica tabela)
MERGE INTO TCONTRATO TCN
     USING (SELECT COD_ALUNO AS ALUNO
            FROM TALUNO
            WHERE ESTADO = 'RS')
     ON    (TCN.COD_ALUNO = ALUNO)
       WHEN MATCHED THEN --encontrou o registro
            UPDATE SET DESCONTO = 22
       WHEN NOT MATCHED THEN --n�o encontrou o registro
            INSERT (TCN.COD_CONTRATO,TCN.DATA,TCN.COD_ALUNO,
                    TCN.DESCONTO, TCN.TOTAL)
            VALUES(SEQ_CON.NEXTVAL, SYSDATE, ALUNO, 0, 20);  
            
SELECT * FROM TCONTRATO;

CREATE SEQUENCE SEQ_CON START WITH 500;--sequencia criada


