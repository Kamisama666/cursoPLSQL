SET AUTOCOMMIT OFF
SET SERVEROUTPUT ON
DECLARE
error_integridad EXCEPTION;
PRAGMA EXCEPTION_INIT(error_integridad,-02291);
nuevoempleado empleados%ROWTYPE;

BEGIN
insert into empleados values(32,'Juan','Lopez','Perales','10','emailj@k.com','PAR-FR',29,'becario'); --creamos el empleado si problemas
select * into nuevoempleado from empleados where codigoempleado=32;
dbms_output.put_line(nuevoempleado.codigoempleado||' '||nuevoempleado.nombre);
update empleados set CodigoOficina=10 where codigoempleado=32; 
COMMIT WORK;

EXCEPTION
WHEN error_integridad THEN
        ROLLBACK WORK;
        DBMS_OUTPUT.PUT_LINE('Se ha producido un error de integridad');
END;
/
