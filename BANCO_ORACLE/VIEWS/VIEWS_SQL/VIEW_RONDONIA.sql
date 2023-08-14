﻿CREATE OR REPLACE VIEW VIEW_RONDONIA (DATA_HORARIO,DIA_SEMANA,UF,BR,KM,MUNICIPIO,CAUSA_ACIDENTE,TIPO_ACIDENTE,POSSUI_VITIMAS,PERIODO_DO_DIA,SENTIDO_VIA,CONDICAO_METEREOLOGICA,TIPO_PISTA,TRACADO_VIA,PESSOAS,
MORTOS,FERIDOS_LEVES,FERIDOS_GRAVES,ILESOS,IGNORADOS,FERIDOS,VEICULOS,REGIONAL,DELEGACIA,UOP,LATITUDE,LONGITUDE)AS 
 SELECT 
        DATA_HORARIO_ACIDENTE,
        DIA_SEMANA,
        UF,
        BR,
        KM,
        MUNICIPIO,
        CAUSA_ACIDENTE,
        TIPO_ACIDENTE,
        CLASSIFICACAO_ACIDENTE,
        FASE_DIA,
        SENTIDO_VIA,
        CONDICAO_METEREOLOGICA,
        TIPO_PISTA,
        TRACADO_VIA,
        PESSOAS,
        MORTOS,
        FERIDOS_LEVES,
        FERIDOS_GRAVES,
        ILESOS,
        IGNORADOS,
        FERIDOS,
        VEICULOS,
        REGIONAL,
        DELEGACIA,
        UOP,
        LATITUDE,
        LONGITUDE
    FROM SYSTEM.TB_ACIDENTES
  WHERE UF = 'RO'; 