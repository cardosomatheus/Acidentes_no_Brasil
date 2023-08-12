-- Padronização do formato sobre as datas

CREATE OR REPLACE PROCEDURE PROC_AJUSTA_DATAS
AS
BEGIN
    --  Ajusta o padrão sobre as Datas, altera '-' para '/'
    EXECUTE IMMEDIATE 'UPDATE SYSTEM.ACIDENTES_DATATRAN
                            SET DATA_INVERSA  = REPLACE(DATA_INVERSA, ''-'',''/'')';
    
    --  Atualiza as Datas com o formato brasileiro e com o ano definido por 2 valor(16) DD/MM/YYYY
    EXECUTE IMMEDIATE 'UPDATE ACIDENTES_DATATRAN
                            SET DATA_INVERSA = SUBSTR(DATA_INVERSA,0,6)||''20''||SUBSTR(DATA_INVERSA,7,8)
                         WHERE LENGTH(DATA_INVERSA) <= 8';
    
    --  Atualiza os texto que estão com os anos em formato brasileiro para texto em formato inglês
    EXECUTE IMMEDIATE 'UPDATE SYSTEM.ACIDENTES_DATATRAN
                            SET DATA_INVERSA = TO_CHAR(TO_DATE(DATA_INVERSA, ''DD/MM/YYYY''), ''YYYY/MM/DD'')
                          WHERE DATA_INVERSA LIKE ''%/200%''
                            OR  DATA_INVERSA LIKE ''%/201%'''; 

    COMMIT;
END;
/

