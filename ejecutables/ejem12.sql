set serveroutput on
DECLARE
--Declaramos el cursor mediante la sintaxis: CURSOR <nombre> IS <consulta>
CURSOR cli_rep is select nombrecliente,nombre from clientes join empleados on codigoempleadorepventas=codigoempleado;
resultado cli_rep%ROWTYPE; --En esta variable guardaremos las filas que devulva la consulta. Como los datos
--son de varias tablas hacemos que coja los campos del cursor


BEGIN
OPEN cli_rep; --Abrimos el cursor con la sintaxis: OPEN <nombre>

FETCH cli_rep INTO resultado; --Hemos de hacer el FETCH antes de empezar el bucle para que %ISOPEN devulva TRUE
DBMS_OUTPUT.PUT_LINE(cli_rep%ROWCOUNT||'. '||resultado.nombrecliente||' tiene como representante a '||resultado.nombre);

WHILE cli_rep%FOUND LOOP
        FETCH cli_rep INTO resultado;
        DBMS_OUTPUT.PUT_LINE(cli_rep%ROWCOUNT||'. '||resultado.nombrecliente||' tiene como representante a '||resultado.nombre);
END LOOP;

CLOSE cli_rep; --Cerramos el cursor con la sentencia CLOSE

END;
/
