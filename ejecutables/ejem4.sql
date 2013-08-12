/* Crearemos una variable llamanda "nombre_empleado" donde guardaremos el nombre del empleado con codigo=1 de
la tabla empleados. 
*/
set serveroutput on
DECLARE
nombre_empleado VARCHAR2(50);
BEGIN
select nombre into nombre_empleado from empleados where codigoempleado=1;
dbms_output.put_line(nombre_empleado); 
--La consulta es igual a una normal con la diferencia de que usamos "into <variable>" para indicar donde guardar el resultado
END;
/