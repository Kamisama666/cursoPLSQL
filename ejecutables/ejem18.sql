set serveroutput on
CREATE OR REPLACE PROCEDURE devuelvejefe (codigoemp IN int, nombrejefecompleto OUT varchar2)
IS
codigomijefe int;
nombrejefe empleados%ROWTYPE;
BEGIN
select codigojefe into codigomijefe from empleados where codigoempleado=codigoemp;
select * into nombrejefe from empleados where codigoempleado=codigomijefe;
nombrejefecompleto:=nombrejefe.nombre||' '||nombrejefe.apellido1||' '||nombrejefe.apellido2;
END;
/