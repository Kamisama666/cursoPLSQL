CREATE OR REPLACE FUNCTION totalImportePedidos (codigocli number)
return number
IS
totalpedido number(30);
BEGIN

select sum(cantidad*preciounidad) as total into totalpedido from detallepedidos natural join pedidos where codigocliente=codigocli;
RETURN totalpedido;
END;