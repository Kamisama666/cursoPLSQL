set serveroutput on
DECLARE
nombrejefecompleto varchar(70);
BEGIN
devuelvejefe(31,nombrejefecompleto);
DBMS_OUTPUT.PUT_LINE(nombrejefecompleto);
END;
/