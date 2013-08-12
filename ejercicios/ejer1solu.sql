/*
Ejercicio 1.
Muestra por pantalla el codigocliente, el nombrecliente y el nombre del empleado de ventas cuyo codigo 
coincida con el codigoempleadorepventas del cliente cuyo codigo sea igual a 10.
*/
set serveroutput on --Como hay que mostrar datos por pantalla nos aseguramos de que serveroutput este on
DECLARE
cliente clientes%ROWTYPE; --aqui guardaremos el resultado de la consulta a la tabla cliente
empleado empleados%ROWTYPE; --aquí la de empleados
codigorepventas clientes.codigoempleadorepventas%TYPE; --aqui almacenamos el codigoempleadorepventas del cliente para 
--seleccionar el empleado que corresponda
BEGIN
select * into cliente from clientes where codigocliente=10; --Buscamos el cliente con codigo 10 y lo metemos en "cliente"
codigorepventas:=cliente.codigoempleadorepventas; --guardamos el codigo del representante de ventas
select * into empleado from empleados where codigoempleado=codigorepventas; --buscamos el empleado que coincida con ese codigo y 
--lo guardamos en empleaod

DBMS_OUTPUT.PUT_LINE(cliente.codigocliente||' '||cliente.nombrecliente||' '||empleado.nombre); --Mostramos todo
END;
/
