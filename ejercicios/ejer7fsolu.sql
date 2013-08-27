SET SERVEROUTPUT ON
DECLARE
codigocli number:=1;
totalpedidos number(30);
BEGIN

totalpedidos:=totalImportePedidos(codigocli);
DBMS_OUTPUT.PUT_LINE('El total del importe de los pedidos es: '||totalpedidos);
END;