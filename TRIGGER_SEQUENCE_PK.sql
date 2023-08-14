﻿-- Controle da Primary key (PK) da tabela
CREATE SEQUENCE SEQ_ACIDENTES  START WITH 1 INCREMENT BY 1;


CREATE OR REPLACE TRIGGER TRG_ACIDENTE_PK
BEFORE INSERT ON SYSTEM.TB_ACIDENTES FOR EACH ROW
BEGIN
    IF :NEW.PID IS NULL THEN
        :NEW.PID := SYSTEM.SEQ_ACIDENTES.NEXTVAL;
    END IF;
END;