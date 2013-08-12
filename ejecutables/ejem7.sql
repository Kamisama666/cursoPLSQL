SET SERVEROUTPUT ON
DECLARE
valor1 int:=5;
valor2 int:=2;

BEGIN

if valor1=5 THEN
        DBMS_OUTPUT.PUT_LINE('Esto se ejecuta seguro');
END IF;


if valor1 > valor2 THEN
	DBMS_OUTPUT.PUT_LINE('Se cumple la condicion');
END IF;

if valor1 < valor2 THEN
	DBMS_OUTPUT.PUT_LINE('En este no se cumplira');
END IF;

--Tambien podemos usar "else". Lo que pongamos dentro del else se ejecutara si no se cumple la condicion. Solo podemos poner uno

if valor1 < valor2 THEN
	DBMS_OUTPUT.PUT_LINE('En este no se cumplira');

ELSE 
	DBMS_OUTPUT.PUT_LINE('como no se cumple la condicion yo sí me ejecutare');
END IF;

/* 
También podemos usar "ELSIF". Con esto vamos comprobando una por una cada condicion hasta que una se cumpla.
De esta forma, en cuanto lleguemos a una condicion que se cumple, ya no ejecutaremos ninguna de las siguientes
*/

if valor1 < valor2 THEN
	DBMS_OUTPUT.PUT_LINE('En este no se cumplira');

elsif valor1<10 THEN
	DBMS_OUTPUT.PUT_LINE('YO sí me ejecuto');
elsif valor2<10 THEN
	DBMS_OUTPUT.PUT_LINE('Como la anterior es valida yo no llego a ejecutarme');	
END IF;


--Como es logico tambien podemos poner un else al final de los elsif 
if valor1 < valor2 THEN
	DBMS_OUTPUT.PUT_LINE('En este no se cumplira');

elsif valor1>10 THEN
	DBMS_OUTPUT.PUT_LINE('YO no me ejecuto');
elsif valor2>10 THEN
	DBMS_OUTPUT.PUT_LINE('Yo tampoco');

ELSE 
	DBMS_OUTPUT.PUT_LINE('Como ninguna de las anteriores es correcta yo me ejecuto');
END IF;

END;
/
