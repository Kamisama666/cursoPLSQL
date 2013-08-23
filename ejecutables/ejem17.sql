set serveroutput on
CREATE OR REPLACE PROCEDURE escribejefe (codigoemp IN int)
IS
codigomijefe int;
nombrejefe varchar2(50);
BEGIN
select codigojefe into codigomijefe from empleados where codigoempleado=codigoemp;
select nombre into nombrejefe from empleados where codigoempleado=codigomijefe;
DBMS_OUTPUT.PUT_LINE(nombrejefe);
END;
/