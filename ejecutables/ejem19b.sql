set serveroutput on
DECLARE
nombrejefe varchar2(60);
codigoempleado int:=31;
BEGIN
nombrejefe:=nombredejefe(codigoempleado);
DBMS_OUTPUT.PUT_LINE(nombrejefe);
END;
/