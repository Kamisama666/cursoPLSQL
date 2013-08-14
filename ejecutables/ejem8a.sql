set serveroutput on
DECLARE
actitud varchar(5):='B';
texto varchar(10);

BEGIN
CASE actitud 
WHEN 'A' THEN 'Muy buena' 
WHEN 'B' THEN 'Buena' --Esta es la correcta 
WHEN 'C' THEN 'Normal' 
WHEN 'D' THEN 'Mala' 
ELSE 'Desconocida'
END; 

dbms_output.put_line(texto);
END;
/