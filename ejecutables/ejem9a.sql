set serveroutput on
DECLARE
mayor int;
nombreempleado varchar2(50);
contador int:=1;
BEGIN
select codigoempleado INTO mayor from empleados where codigoempleado >= all (select codigoempleado from empleados);

LOOP
select nombre into nombreempleado from empleados where codigoempleado=contador;
dbms_output.put_line(nombreempleado);
EXIT WHEN contador=mayor;
contador:=contador+1;
END LOOP;

END;
/
