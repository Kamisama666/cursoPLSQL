CREATE OR REPLACE FUNCTION nombredejefe (codigomiempleado int)
RETURN varchar2
IS
codigomijefe int;
mijefe empleados%ROWTYPE;
nombremijefe varchar2(60);
BEGIN
select codigojefe into codigomijefe from empleados where codigoempleado=codigomiempleado;
select * into mijefe from empleados where codigoempleado=codigomijefe;
nombremijefe:=mijefe.nombre||' '||mijefe.apellido1||' '||mijefe.apellido2;
RETURN nombremijefe;
END;
/