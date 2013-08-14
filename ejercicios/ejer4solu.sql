/*
Guarda en una variable el codigo de un cliente cualquiera. Calcula a cuanto asciende el total del coste de los pedidos que ha echo
y comparalo con su limite de credito. Si lo que ha gastado es mayor que su limite credito muestra un mensaje inidicandolo. 
Si no, muestra otro mensaje que lo refleje. Especifica el nombre de ambos clientes en los mensajes.
*/
set serveroutput on
DECLARE
micliente int:=1;
nombremicliente clientes.nombrecliente%TYPE;
limitecliente clientes.limitecredito%TYPE;
totalgastado number(50);

BEGIN

select sum(cantidad*preciounidad) into totalgastado from pedidos natural join detallepedidos where codigocliente=micliente group by codigocliente;
select limitecredito into limitecliente from clientes where codigocliente=micliente;
select nombrecliente into nombremicliente from clientes where codigocliente=micliente;

IF limitecliente>totalgastado THEN
	dbms_output.put_line('El cliente '||nombremicliente||' no ha superado su limite de credito');
ELSE
	dbms_output.put_line('El cliente '||nombremicliente||' ha superado su limite de credito');
END IF;

END;
/