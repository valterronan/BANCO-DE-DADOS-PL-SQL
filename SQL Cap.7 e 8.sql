--CAPITULO 7
 
--Retorna uma linha na subconsulta)
SELECT COD_CONTRATO, DATA, TOTAL
FROM TCONTRATO
WHERE TOTAL >=
  ( SELECT VALOR FROM TCURSO
    WHERE COD_CURSO = 3 );

-- Errado (Só pode retornar 1
-- linha na subconsulta)
SELECT COD_CONTRATO, DATA, TOTAL
FROM TCONTRATO
WHERE TOTAL >=
  ( SELECT VALOR FROM TCURSO
    WHERE VALOR > 500 );

 SELECT * from TALUNO

--Todos os Alunos da mesma cidade do Aluno 1,
--Menos o Aluno 1
SELECT COD_ALUNO, NOME, CIDADE
FROM TALUNO
WHERE CIDADE = ( SELECT CIDADE FROM TALUNO
                 WHERE COD_ALUNO = 1 )
AND COD_ALUNO <> 1;

--Todos os alunos da mesma cidade e
--estado do aluno 1
--menos o aluno 1
SELECT COD_ALUNO, NOME, CIDADE, ESTADO
FROM TALUNO
WHERE (CIDADE,ESTADO) =
          ( SELECT CIDADE,ESTADO FROM TALUNO
            WHERE COD_ALUNO = 1 )
AND COD_ALUNO <> 1 ;

SELECT * FROM TALUNO
  
UPDATE TALUNO SET--Atualizando coluna estado cod aluno
  ESTADO = 'RS'
WHERE COD_ALUNO = 1;

--Soma todos os itens, e mostra somente cujo o
--valor minimo seja maior que o valor medio dos cursos
SELECT COD_CURSO, Min(VALOR),Sum(VALOR),
       Count(*) QTDE
FROM TITEM
WHERE cod_curso > 0
GROUP BY COD_CURSO
HAVING Min(VALOR) >=
      (SELECT Avg(VALOR) FROM TCURSO)
ORDER BY Cod_Curso;

--Soma o total de contrato por aluno e mostra
--somente cujo o menor contrato seja maior queo valor medio de curso
SELECT COD_ALUNO, Min(TOTAL), Sum(TOTAL)
FROM TCONTRATO
GROUP BY COD_ALUNO
HAVING Min(TOTAL) >
   (SELECT Avg(VALOR) FROM TCURSO);

--Todos os cursos que estao na tabela de
--Item (Vendidos)
SELECT COD_CURSO, NOME, VALOR
FROM TCURSO
WHERE COD_CURSO IN (SELECT COD_CURSO FROM TITEM)

--Todos os Cursos que nao Estao na Tabela de Item (Nao Vendidos)
SELECT COD_CURSO, NOME, VALOR
FROM TCURSO
WHERE COD_CURSO NOT IN (SELECT COD_CURSO FROM TITEM)
ORDER BY NOME

--Codigo equivalente a subselect ( se os valores sao conhecidos )
SELECT cod_curso, nome, valor
FROM tcurso WHERE cod_curso IN (1,2,3,4) ;

--OR (onde)
SELECT Cod_curso, nome, valor
FROM Tcurso
WHERE Cod_curso = 1
   OR Cod_curso = 2
   OR Cod_curso = 3
   OR Cod_curso = 4;

--Todos cursos que foram vendidos
--pelo valor padrao nesse caso não tem nenhum então retornara tabela vazia
SELECT * FROM TITEM
WHERE (COD_CURSO, VALOR) IN
      (SELECT COD_CURSO, VALOR FROM TCURSO)

select *from tcurso

--SubConsulta na clausula From
SELECT ITE.COD_CONTRATO, ITE.VALOR, ITE.COD_CURSO,
       CUR.COD_CURSO codigo, CUR.VALOR
FROM TITEM ITE,
     ( SELECT COD_CURSO, VALOR
       FROM TCURSO WHERE VALOR > 500 ) CUR

  WHERE CUR.COD_CURSO = ITE.COD_CURSO


--CAPITULO 8
SELECT * FROM TDESCONTO;
--Inserindo linhas na tabela tdesconto
INSERT INTO TDESCONTO VALUES ('A',00,10);
INSERT INTO TDESCONTO VALUES ('B',11,15);
INSERT INTO TDESCONTO VALUES ('C',16,20);
INSERT INTO TDESCONTO VALUES ('D',21,25);
INSERT INTO TDESCONTO VALUES ('E',26,30);

--Inserindo linhas atraves &
INSERT INTO TDESCONTO(CLASSE, INFERIOR, SUPERIOR)
VALUES ('&cla', &inf, &sup);

SELECT * FROM TDESCONTO
WHERE CLASSE = '&cla';

UPDATE TDESCONTO SET--Atualiza colunas inferio e superior
INFERIOR = &inf ,
SUPERIOR = &sup
WHERE CLASSE = '&cla';

DELETE FROM TDESCONTO--Deletando linha tdesconto
WHERE CLASSE = '&cla';

CREATE TABLE TDESCONTO2--Criando tabela (AS)cria tabela = tabela tdesconto
  AS SELECT * FROM TDESCONTO

SELECT * FROM TDESCONTO2;

COMMIT;

--Transação (Commit/Rollback)
--
DELETE FROM TDESCONTO2;--Deleta todos os registros

ROLLBACK;--Cancela o delete acima, pois ainda não foi feito commit

--Delete todos os registros da tabela
--Nao tem clausula Where
TRUNCATE TABLE TDESCONTO2;

SELECT * FROM TDESCONTO2;

COMMIT;
--Depois do commit não funciona o rollback
--Deleta todos os registros nao tem volta/

SELECT * FROM TDESCONTO2;

ROLLBACK;--Não funciona o Rollback por causa do commit

SELECT * FROM TDESCONTO

--Savepoint Ponto do reinicio
SAVEPOINT upd_b;

UPDATE TDESCONTO SET--Atualizando coluna superior onde a clase = registro B
SUPERIOR = 88
WHERE CLASSE = 'B';

SAVEPOINT upd_a;

UPDATE TDESCONTO SET--Atualizando coluna superior onde a clase = registro A
SUPERIOR = 99
WHERE CLASSE = 'A';

--ponto de restauraçao
SAVEPOINT ins_Ok;
--
INSERT INTO tdesconto(classe, inferior, superior)
VALUES ('&cla', &inf, &sup);

SELECT * FROM TDESCONTO;

ROLLBACK TO SAVEPOINT ins_Ok;--Retorna ao ponto de restauração(SAVEPOINT)
ROLLBACK TO SAVEPOINT upd_a;--Anula o insert anterior
ROLLBACK TO SAVEPOINT upd_b;

--excluir tabela
DROP TABLE TDESCONTO2;

SELECT * FROM T CONTRATO2;

--FIM




