/*
	Realiza una consulta que devuelva el nombre de todos los clientes que hayan recibido un pedido tarde (fechaeentrega despues
	de fechaesperada). Muestralos y, a cada uno de ellos, aumentales en 50 su limite de credito. Antes de hacerlo muestra
	cual era su limite y despues cual es el nuevo.
*/

set serveroutput on
DECLARE
CURSOR cli_entregatarde is select nombrecliente,codigocliente,limitecredito from clientes where codigocliente in 
	(select codigocliente from pedidos where fechaesperada<fechaentrega group by codigocliente);
clientesafec cli_entregatarde%ROWTYPE;
limit_nuevo clientes.limitecredito%TYPE;


BEGIN

OPEN cli_entregatarde;

LOOP 
	FETCH cli_entregatarde INTO clientesafec;
	EXIT WHEN cli_entregatarde%NOTFOUND;
	DBMS_OUTPUT.PUT_LINE('El cliente '||clientesafec.nombrecliente||' ha recibido pedidos retrasados.');
	DBMS_OUTPUT.PUT_LINE('Su limite de credito actual es: '||clientesafec.limitecredito);
	update clientes set limitecredito=clientesafec.limitecredito+50 where codigocliente=clientesafec.codigocliente;
	select limitecredito into limit_nuevo from clientes where codigocliente=clientesafec.codigocliente;
	DBMS_OUTPUT.PUT_LINE('Despues del aumento su limite de credito es: '||limit_nuevo);
	
END LOOP;

CLOSE cli_entregatarde;
END;
/

