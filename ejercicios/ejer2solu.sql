/*
	Ejercicio 2:
Almacena en una variable int un numero que corresponda a un codigo de pedido cualquiera (por ejemplo 17).
Despues comprueba si el pedido ha sido entrgado a tiempo (la fecha de entrega es anterior o igual a la esperada).
Si lo ha sido, muestra un mensaje de "Pedido entregado a tiempo". Si no, uno de "Pedido no entregado a tiempo".
Ve variando el numero de pedido para comprobar que funciona correctamente
*/

set serveroutput on 

DECLARE
numpedido int:=17;
mipedido pedido%ROWTYOE;
BEGIN

select * into mipedido from pedidos where codigopedido=numpedido;

IF mipedido.fechaentrega<=mipedido.fechaesperada THEN
	DBMS_OUTPUT.PUT_LINE('Pedido entregado a tiempo');
ELSE
	DBMS_OUTPUT.PUT_LINE('Pedido no entregado a tiempo');
END IF;

END;