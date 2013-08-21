set serveroutput on
DECLARE
ofinasspain oficinas%ROWTYPE; --aqui introduciremos el resultado de la consulta. 
demasiadas_columnas EXCEPTION; --delclaramos el nombre de la excepcion con la sintaxis: <nombre_excepcion> EXCEPTION
PRAGMA EXCEPTION_INIT(demasiadas_columnas,-01422); --asignamos el nombre que acabamos de definir a la excepcion
--que hemos elejido. Usamos la sintaxis: PRAGMA EXCEPTION_INIT(<nombre_excepcion>,<numero_excepcion>)

BEGIN
select * into ofinasspain from oficinas where pais='España';

EXCEPTION
	WHEN demasiadas_columnas THEN --Capturamos la excepcion
		DBMS_OUTPUT.PUT_LINE('La consulta tiene demasiadas columas'); --definimos lo que se ha de ejecutar
END;
/