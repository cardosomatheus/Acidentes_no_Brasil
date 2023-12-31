﻿-- Criação da tabela principal
CREATE TABLE SYSTEM.TB_ACIDENTES(
    PID           NUMBER NOT NULL,
    DATA_ACIDENTE DATE,
    DATA_HORARIO_ACIDENTE VARCHAR2(30),
    DIA_SEMANA VARCHAR2(15),
    UF VARCHAR2(2),
    BR VARCHAR2(10),
    KM VARCHAR2(10),
    MUNICIPIO      VARCHAR(100),
    CAUSA_ACIDENTE VARCHAR2(120),
    TIPO_ACIDENTE  VARCHAR2(100),
    CLASSIFICACAO_ACIDENTE VARCHAR2(100),
    FASE_DIA    VARCHAR2(30),
    SENTIDO_VIA VARCHAR2(30),
    CONDICAO_METEREOLOGICA VARCHAR2(30),
    TIPO_PISTA  VARCHAR2(30),
    TRACADO_VIA VARCHAR2(50),
    PESSOAS NUMBER,
    MORTOS  NUMBER,
    FERIDOS_LEVES  NUMBER,
    FERIDOS_GRAVES NUMBER,
    ILESOS    NUMBER,
    IGNORADOS NUMBER,
    FERIDOS   NUMBER,
    VEICULOS  NUMBER,
    REGIONAL  VARCHAR2(50),
    DELEGACIA VARCHAR2(50),
    UOP       VARCHAR2(50),
    LATITUDE  VARCHAR2(100),
    LONGITUDE VARCHAR2(100),
    GEOMETRY SDO_GEOMETRY,
    CONSTRAINT PK_ACIDENTES PRIMARY KEY(PID)
);


-- Inserção dos 2 milhões de registros tratados.
INSERT INTO SYSTEM.TB_ACIDENTES(DATA_ACIDENTE,
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
                                LONGITUDE)
                                
    SELECT  TO_DATE(TO_CHAR(TO_DATE(DATA_INVERSA,'YYYY/MM/DD'),'DD/MM/YYYY')), 
            TO_CHAR(TO_TIMESTAMP(DATA_INVERSA ||' '|| HORARIO,'YYYY/MM/DD HH24:MI:SS'),'DD/MM/YYYY HH24:MI:SS'),
            DIA_SEMANA,
            UF,
            'BR-'||DECODE(BR,NULL,'NDA',BR),
            REPLACE(DECODE(KM,NULL,'NDA', KM),',','.')||' KM',
            TRIM(MUNICIPIO),
            INITCAP(TRIM(CAUSA_ACIDENTE)),
            TRIM(INITCAP(TIPO_ACIDENTE)),
            CLASSIFICACAO_ACIDENTE,
            INITCAP(TRIM(FASE_DIA)),
            TRIM(SENTIDO_VIA),
            UPPER(DECODE(TRIM(CONDICAO_METEREOLOGICA),'Garoa/Chuvisco','GAROA',
                                                      'Ceu claro', 'CÉU CLARO',
                                                      'Nevoeiro/Neblína','NEVOEIRO/NEBLINA',CONDICAO_METEREOLOGICA)),
            TRIM(TIPO_PISTA),
            TRIM(TRACADO_VIA),
            TO_NUMBER(PESSOAS),
            TO_NUMBER(MORTOS),
            TO_NUMBER(FERIDOS_LEVES),
            TO_NUMBER(FERIDOS_GRAVES),
            TO_NUMBER(ILESOS),
            TO_NUMBER(IGNORADOS),
            TO_NUMBER(FERIDOS_LEVES)+TO_NUMBER(FERIDOS_GRAVES),
            TO_NUMBER(VEICULOS),
            TRIM(REGIONAL),
            TRIM(REPLACE(DELEGACIA,'/','-')),
            UOP,
            LATITUDE,
            LONGITUDE
        FROM acidentes_datatran;

-- INSERÇÃO DAS GEOMETRIAS PONTUAIS NA TABELA
EXEC PROC_INSERIR_GEOMETRIAS_PONTUAIS;

--   Otimização com index 
CREATE INDEX IX_DATA_ACIDENTE ON SYSTEM.TB_ACIDENTES(DATA_ACIDENTE);
CREATE INDEX IX_DATA_HORARIO_ACIDENTE ON SYSTEM.TB_ACIDENTES(DATA_HORARIO_ACIDENTE);
CREATE INDEX IX_MUNICIPIO ON SYSTEM.TB_ACIDENTES(MUNICIPIO);
CREATE INDEX IX_GEOM_ACIDENTES ON SYSTEM.TB_ACIDENTES(GEOMETRY) INDEXTYPE IS MDSYS.SPATIAL_INDEX;


--CRIÇÃO DO USUARIO
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;

CREATE USER USERBR IDENTIFIED BY userbr;

-- NÃO SERÁ DADO O ACESSO DE DELETE SOBRE OS REGISTROS PARA O USER.
 GRANT SELECT, UPDATE , INSERT ON SYSTEM.TB_ACIDENTES TO USERBR;
