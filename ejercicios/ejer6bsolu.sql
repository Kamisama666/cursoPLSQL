set serveroutput on
DECLARE
INSERT_DUPLICADA EXCEPTION;
PRAGMA EXCEPTION_INIT(INSERT_DUPLICADA,-00001);

BEGIN
insert into empleados values(31,'Pepe','gracia','tomoso','40','email@k.com','PAR-FR',30,'trabajador');

EXCEPTION
WHEN INSERT_DUPLICADA THEN 
	DBMS_OUTPUT.PUT_LINE('No puedes introducir campos primarios duplicados');
END;
/