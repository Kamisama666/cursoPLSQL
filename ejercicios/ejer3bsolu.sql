/*
	Imprime por pantalla todas las tablas de multiplicar del 1 al 10. Usa este formato:
		<tabla> x <numero> = <resultado>
	Hazlo tanto usando el WHILE como el FOR.
*/

SET SERVEROUTPUT ON

BEGIN

for tabla in 1 .. 10 loop 
	for n in 1 .. 10 loop 
		DBMS_OUTPUT.PUT_LINE(TABLA||'x'||N||'='||(TABLA*N));
	end loop;
	DBMS_OUTPUT.PUT_LINE('----------------');
end loop;
end ;
/
