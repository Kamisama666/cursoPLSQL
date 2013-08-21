set serveroutput on
DECLARE
resultado int;
dividendo int:=0;
divisor int:=10;

BEGIN

resultado:=dividendo/dividendo;
DBMS_OUTPUT.PUT_LINE(resultado);

EXCEPTION
when ZERO_DIVIDE THEN 
	DBMS_OUTPUT.PUT_LINE('No puede divir 0 por otro numero');

END;
/