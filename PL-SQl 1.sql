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

 
    











