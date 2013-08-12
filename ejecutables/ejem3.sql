/*En PL/SQL se permiten utilizar todos los operadores de SQL: los operadores aritméticos (+ - * /), condicionales 
(> < != <> >= <= OR AND NOT) y de cadena (||).A estos operadores, PL/SQL 
añade el operador de potencia **. Por ejemplo 4**3 es 43*/

SET SERVEROUTPUT ON
DECLARE
valor1 int:=5;
valor2 int:=2;
resul int;
cadena1 varchar(10):='Aragorn';
cadena2 varchar(20):='Hijo de Arathorn';
sumcadena varchar(30);
BEGIN
resul:=valor1+valor2;
dbms_output.put_line(resul);
resul:=valor1-valor2;
dbms_output.put_line(resul);
resul:=valor1*valor2;
dbms_output.put_line(resul);
resul:=valor1/valor2;
dbms_output.put_line(resul);
resul:=valor1**valor2;
dbms_output.put_line(resul);

sumcadena:=cadena1||cadena2;--con "||" concatenamos dos cadenas
dbms_output.put_line(sumcadena);
END;
/
