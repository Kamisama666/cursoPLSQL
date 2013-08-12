/*Para mostrar datos por pantalla hay que habilitar poner la variable*/
SET SERVEROUTPUT ON
/*Despues ya podemos devolver datos por pantalla*/

DECLARE
nombre varchar(10):='Pepe';
BEGIN
DBMS_OUTPUT.PUT_LINE('Hola mundo');
DBMS_OUTPUT.PUT_LINE(nombre);
END;
/
