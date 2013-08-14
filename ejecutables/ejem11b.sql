set serveroutput on
DECLARE
mayor int;
nombreempleado varchar2(50);
BEGIN
select codigoempleado INTO mayor from empleados where codigoempleado >= all (select codigoempleado from empleados);

FOR contador IN REVERSE 1 .. mayor LOOP
select nombre into nombreempleado from empleados where codigoempleado=contador;
dbms_output.put_line(nombreempleado);
END LOOP;

END;
/