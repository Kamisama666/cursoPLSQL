--Pone una N al principio del nombre de todos los empleados cuyo codigo sea mayor que 10 y borra al empleado 
--con codigo 40
DECLARE
inicial char:='N';
codigo int:=40;
BEGIN
UPDATE empleados SET nombre = inicial||nombre WHERE codigoempleado>10;
delete from empleados where codigoempleado=codigo;
END;
/