
set serveroutput on
DECLARE
npedido int:=9;
mipedido pedidos%ROWTYPE;
TIEMPO_ENTREGA_EXCEDIDO EXCEPTION; --definimos nuestra escepcion

BEGIN

select * into mipedido from pedidos where codigopedido=npedido;

IF mipedido.fechaesperada<mipedido.fechaentrega THEN 
	RAISE TIEMPO_ENTREGA_EXCEDIDO; --hacemos que se lance en el momento que consideremos oportuno
END IF;

EXCEPTION
	WHEN TIEMPO_ENTREGA_EXCEDIDO THEN --capturamos la excepcion igual que las otras
		DBMS_OUTPUT.PUT_LINE('El pedido ha llegado con retraso');
END;
/