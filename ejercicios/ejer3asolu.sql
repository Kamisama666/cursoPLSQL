/*
	Imprime por pantalla todas las tablas de multiplicar del 1 al 10. Usa este formato:
		<tabla> x <numero> = <resultado>
*/

SET SERVEROUTPUT ON

DECLARE
TABLA INT:=1;
N INT:=1;

BEGIN

WHILE TABLA <= 10 LOOP
	N:=1;
	WHILE N <=10 LOOP
		DBMS_OUTPUT.PUT_LINE(TABLA||'x'||N||'='||(TABLA*N));
		N:=N+1;
	END LOOP;
	DBMS_OUTPUT.PUT_LINE('----------------');
	TABLA:=TABLA+1;
	
END LOOP;
END;
/