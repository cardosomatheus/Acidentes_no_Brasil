﻿CREATE OR REPLACE PROCEDURE PROC_AJUSTA_NULOS AS 
    VSQL VARCHAR2(400);
BEGIN
    FOR C1 IN (SELECT COLUMN_NAME FROM ALL_TAB_COLUMNS 
                 WHERE TABLE_NAME = 'TB_ACIDENTES' 
                    AND COLUMN_NAME <> 'GEOMETRY' )
    LOOP
        VSQL := 'UPDATE TB_ACIDENTES SET ' ||C1.COLUMN_NAME || '= NULL WHERE LOWER(TRIM('||C1.COLUMN_NAME||')) = ''(null)''';
        EXECUTE IMMEDIATE VSQL ;
    END LOOP;
END;
/