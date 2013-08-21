set serveroutput on
DECLARE
ofinasspain oficinas%ROWTYPE; --aqui introduciremos el resultado de la consulta. 

BEGIN
select * into ofinasspain from oficinas where pais='España';

EXCEPTION
	WHEN TOO_MANY_ROWS THEN --Como es una excepcion predefinida, podemos usarla sin tener que definirla nosotros
		DBMS_OUTPUT.PUT_LINE('La consulta tiene demasiadas columas'); 
END;
/