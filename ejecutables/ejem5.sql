/*
Ejemplo de uso para %TYPE y %ROWTYPE
*/
set serveroutput on
DECLARE
fila empleados%ROWTYPE; --Ahora fila contiene todos los campos de la tabla empleados
valor empleados.nombre%TYPE; --valor es del mismo tipo que el campo nombre de la tabla empleados. Es decir, varchar(50)
BEGIN

select nombre into valor from empleados where codigoempleado=1;
DBMS_OUTPUT.PUT_LINE(valor);

select * into fila from empleados where codigoempleado=1;
DBMS_OUTPUT.PUT_LINE(fila.nombre||' '||fila.codigoempleado); --como ves podemos referenciar a los campos individualmente
fila.nombre:='Juan'; --tambien podemos modificar los valores de cada campo
DBMS_OUTPUT.PUT_LINE(fila.nombre||' '||fila.codigoempleado);


END;
/