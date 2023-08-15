--------------------------------------------------------------------------------
-- Identificar inconsistencia nos dias da semana
SELECT DISTINCT dia_semana 
    FROM ACIDENTES_DATATRAN;

--  Executar a proc para ajustar a inconsistencia.
EXEC PROC_VALIDA_DIAS_SEMANA;

--------------------------------------------------------------------------------
-- Identificar inconsistencia sobre as datas dos acidentes
SELECT DISTINCT DATA_INVERSA 
    FROM ACIDENTES_DATATRAN;

--  Executar a proc para ajustar a inconsistencias.
EXEC PROC_AJUSTA_DATAS;
EXEC PROC_AJUSTA_NULOS;

------------------------------------------------------------------------------
-- NÃO HOUVE NESCESSIDADES DE AJUSTES
SELECT DISTINCT HORARIO 
    FROM ACIDENTES_DATATRAN 
  WHERE LENGTH(HORARIO) > 8
    OR HORARIO LIKE'%.%'
    OR HORARIO LIKE'%,%';

------------------------------------------------------------------------------
-- Ajustes de UF que estão (nulas ou caractere simbolizando o valor nulo)

SELECT UF, MUNICIPIO
    FROM SYSTEM.ACIDENTES_DATATRAN 
 WHERE lower(UF) = '(null)';
 
EXEC PROC_VALIDA_UF_VAZIAS;

-------------------------------------------------------------------------------
-- BRs inconsistentes
UPDATE TB_ACIDENTES
    SET BR = NULL
  WHERE BR = 'BR-(null)';

-- KMs inconsistentes
UPDATE TB_ACIDENTES
    SET KM = NULL
  WHERE KM IN('NDA KM','(null) KM');

COMMIT;
-------------------------------------------------------------------------------
-- Ajuste sobre as causas de acidentes.
UPDATE TB_ACIDENTES
    SET CAUSA_ACIDENTE = 'Restrição De Visibilidade'
  WHERE CAUSA_ACIDENTE IN ('Restrição De Visibilidade Em Curvas Verticais','Restrição De Visibilidade Em Curvas Horizontais');
 

UPDATE TB_ACIDENTES
    SET CAUSA_ACIDENTE = 'Ingestão De Álcool E/Ou Substâncias Psicoativas Pelo Pedestre'
  WHERE CAUSA_ACIDENTE = 'Ingestão De Álcool Ou De Substâncias Psicoativas Pelo Pedestre';
 

UPDATE TB_ACIDENTES
    SET CAUSA_ACIDENTE = 'Sinalização Da Via Insuficiente Ou Inadequada'
  WHERE CAUSA_ACIDENTE  IN ('Sinalização Mal Posicionada','Sinalização Encoberta');

UPDATE TB_ACIDENTES
    SET CAUSA_ACIDENTE = 'Ingestão De Substâncias Psicoativas'
  WHERE CAUSA_ACIDENTE ='Ingestão De Substâncias Psicoativas Pelo Condutor'; 

UPDATE TB_ACIDENTES
    SET CAUSA_ACIDENTE = 'Ingestão De Álcool'
  WHERE CAUSA_ACIDENTE ='Ingestão De Álcool Pelo Condutor';
 

UPDATE TB_ACIDENTES
    SET CAUSA_ACIDENTE = 'Fenômenos Da Natureza'
  WHERE CAUSA_ACIDENTE ='Demais Fenômenos Da Natureza';



UPDATE TB_ACIDENTES
    SET CAUSA_ACIDENTE = 'Falhas Mecânicas Ou Elétricas No Veiculo'
  WHERE CAUSA_ACIDENTE IN ('Defeito Mecânico No Veículo','Defeito Mecânico Em Veículo','Demais Falhas Mecânicas Ou Elétricas',
                            'Problema Com O Freio','Problema Na Suspensão');
 

UPDATE TB_ACIDENTES
    SET CAUSA_ACIDENTE = 'Condutor Dormindo'
  WHERE CAUSA_ACIDENTE = 'Dormindo';


UPDATE TB_ACIDENTES
    SET CAUSA_ACIDENTE = 'Deficiência Ou Não Acionamento Do Sistema De Iluminação/Sinalização Do Veículo'
  WHERE CAUSA_ACIDENTE = 'Deixar De Acionar O Farol Da Motocicleta (Ou Similar)';

UPDATE TB_ACIDENTES
    SET CAUSA_ACIDENTE = 'Defeito Na Via'
  WHERE CAUSA_ACIDENTE = 'Demais Falhas Na Via';
 

UPDATE TB_ACIDENTES
    SET CAUSA_ACIDENTE = 'Mal Súbito'
  WHERE CAUSA_ACIDENTE = 'Mal Súbito Do Condutor';
 


UPDATE TB_ACIDENTES
    SET CAUSA_ACIDENTE = 'Reação Tardia Ou Ineficiente Do Condutor'
  WHERE CAUSA_ACIDENTE = 'Ausência De Reação Do Condutor';

COMMIT;
-------------------------------------------------------------------------------
-- Ajuste em tipo_acidente
UPDATE TB_ACIDENTES
    SET TIPO_ACIDENTE= 'Colisão Com Objeto Estático'
  WHERE TIPO_ACIDENTE = 'Colisão Com Objeto Fixo';

-------------------------------------------------------------------------------
--AJUSTE ME LOCAIS DE DELEGACIAS PROC_AJUSTA_NULOS
UPDATE TB_ACIDENTES
    SET DELEGACIA = TRIM(REPLACE(DELEGACIA,'/','-'))
  WHERE DELEGACIA IS NOT NULL;

UPDATE TB_ACIDENTES
    SET UOP = TRIM(REPLACE(UOP,'/','-'))
  WHERE UOP IS NOT NULL;

UPDATE TB_ACIDENTES
    SET DELEGACIA = SUBSTR(UOP,INSTR(UOP,'-',1)+1,LENGTH(UOP))
  WHERE DELEGACIA IS NULL
    AND UOP IS NOT NULL
    AND UOP LIKE '%DEL%'
    AND LENGTH(UOP) > 10;

UPDATE TB_ACIDENTES
    SET DELEGACIA = NULL
  WHERE LENGTH(DELEGACIA) <=3;

-------------------------------------------------------------------------------
-- AJUSTES NA DELEGACIA E UOP
UPDATE TB_ACIDENTES
    SET UOP = SUBSTR(UOP,1, INSTR(UOP,'-',1))||DELEGACIA||'-'||UF,
        DELEGACIA = DELEGACIA||'-'||UF
   WHERE DELEGACIA ='DEL01'
    AND UOP LIKE 'UOP%'; 

UPDATE TB_ACIDENTES
    SET DELEGACIA = DELEGACIA||'-'||UF
   WHERE DELEGACIA ='DEL01';


UPDATE TB_ACIDENTES
    SET DELEGACIA = DELEGACIA||'-'||UF
    WHERE DELEGACIA LIKE 'DEL%'
  AND NOT REGEXP_LIKE(DELEGACIA,'ES|SP|MT|PR|MG|BA|RJ|RS|SC|PI|GO|PE|PA|MS|MA|CE|AP|PB|SE|RO|RN|TO|RR|DF|AL|AC|AM','c');