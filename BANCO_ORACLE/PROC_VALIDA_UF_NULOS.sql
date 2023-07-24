/* Identifica os as 'UF' com o caracter '(null)' e seleciona os municipios.
 Através desse municipio ele consuta na base de dados se existe esse municipio em outros registro e
 pega a UF do primeiro registro retornado e  atualiza o valor '(null)' */

CREATE OR REPLACE PROCEDURE PROC_VALIDA_UF_VAZIAS AS
  VUF VARCHAR(2);
BEGIN
  FOR C1 IN (SELECT LOWER(MUNICIPIO) MUNICIPIO
                FROM SYSTEM.ACIDENTES_DATATRAN 
               WHERE lower(UF) = '(null)')
  LOOP
    BEGIN
       SELECT UF INTO VUF
            FROM SYSTEM.ACIDENTES_DATATRAN
          WHERE LOWER(MUNICIPIO) = C1.MUNICIPIO
          FETCH FIRST 1 ROW ONLY;


        UPDATE SYSTEM.ACIDENTES_DATATRAN
            SET UF = VUF
          WHERE C1.MUNICIPIO = LOWER(MUNICIPIO);
        
    EXCEPTION WHEN NO_DATA_FOUND THEN

        UPDATE SYSTEM.ACIDENTES_DATATRAN
            SET UF = NULL
          WHERE C1.MUNICIPIO = LOWER(MUNICIPIO);      

    END; 
  END LOOP;
  COMMIT;
END;
/