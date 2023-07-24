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

--  Executar a proc para ajustar a inconsistencia.
EXEC PROC_AJUSTA_DATAS;

------------------------------------------------------------------------------
-- NÃO HOUVE NESCESSIDADES DE AJUSTES
SELECT DISTINCT HORARIO FROM ACIDENTES_DATATRAN 
WHERE LENGTH(HORARIO) > 8
OR HORARIO LIKE'%.%'
OR HORARIO LIKE'%,%';

------------------------------------------------------------------------------


