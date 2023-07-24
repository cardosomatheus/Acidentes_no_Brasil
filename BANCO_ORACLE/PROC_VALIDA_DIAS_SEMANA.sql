-- Cria um padrão para os dias da semana.

CREATE OR REPLACE PROCEDURE proc_valida_dias_semana AS
BEGIN
    EXECUTE IMMEDIATE 'UPDATE SYSTEM.ACIDENTES_DATATRAN
        SET DIA_SEMANA = ''Domingo''
      WHERE DIA_SEMANA IN (''domingo'')';


    EXECUTE IMMEDIATE 'UPDATE SYSTEM.ACIDENTES_DATATRAN
        SET DIA_SEMANA = ''Segunda-Feira''
      WHERE DIA_SEMANA IN (''Segunda'',''segunda'',''segunda-feira'')';


    EXECUTE IMMEDIATE 'UPDATE SYSTEM.ACIDENTES_DATATRAN
        SET DIA_SEMANA = ''Terça-Feira''
      WHERE DIA_SEMANA IN (''Quarta'',''quarta'',''terça-feira'')';


    EXECUTE IMMEDIATE 'UPDATE SYSTEM.ACIDENTES_DATATRAN
        SET DIA_SEMANA = ''Quarta-Feira''
      WHERE DIA_SEMANA IN (''Terça'',''terça'',''quarta-feira'')';


    EXECUTE IMMEDIATE 'UPDATE SYSTEM.ACIDENTES_DATATRAN
        SET DIA_SEMANA = ''Quinta-Feira''
      WHERE DIA_SEMANA IN (''Quinta'',''quinta'',''quinta-feira'')';


    EXECUTE IMMEDIATE 'UPDATE SYSTEM.ACIDENTES_DATATRAN
        SET DIA_SEMANA = ''Sexta-Feira''
      WHERE DIA_SEMANA IN (''Sexta'',''sexta'',''sexta-feira'')';


    EXECUTE IMMEDIATE 'UPDATE SYSTEM.ACIDENTES_DATATRAN
        SET DIA_SEMANA = ''Sábado''
      WHERE DIA_SEMANA IN (''sábado'', ''SÁBADO'')';

    COMMIT;
END;
/