/*
  ____                       ____  _        ______   ___  _     
 / ___|   _ _ __ ___  ___   |  _ \| |      / / ___| / _ \| |    
| |  | | | | '__/ __|/ _ \  | |_) | |     / /\___ \| | | | |    
| |__| |_| | |  \__ \ (_) | |  __/| |___ / /  ___) | |_| | |___ 
 \____\__,_|_|  |___/\___/  |_|   |_____/_/  |____/ \__\_\_____|
                                                                
				Kamisama666
				v 0.3

En este curso aprenderemos los fundamentos del lenguaje PL/SQL, un lenguaje de programación
diseñado para ser usado con en motor de bases de datos Oracle. Por esta razón solo podrá 
usarse con esta base de datos y no otra. Para realizar este curso es necesario conocer
el lenguaje de consultas SQL, el lenguaje de manipulacion DML y algunos conceptos básicos de programación.
Es preferible que este curso se realice junto con el apoyo de otros recursos adicionales.

Como en cualquier otro lenguaje, las instrucciones de PL/SQL se guardan en archivos de texto plano 
denominados scripts. Para ejercutarlos usaremos la orden:
	@<ruta_archivo>;

Junto con el curso se adjunta una carpeta llamada "ejecutables" en la que se guardan los scripts usados en el
curso para que puedan ser directamente ejecutado. A lo largo del curso se indicará el nombre del 
script usado con la sintaxis.
	--script: <nombre>

Tambien encontraras varios ejercicios para realizar en la carpeta ejercicios asi como su solucion.
A lo largo del curso se indicara cuando se puede realizar cada uno con la sintaxis:
	--ejercicio: <nombre>

Este curso ha sido realizada usando Oracle 11g r2 en un CentOS 6.4

*/

/*-------------------------------------------------------------------------------------------------------------
!!	1. Estructura básica de pl/sql
	Los scripts que ejcutaremos tienen la siguiente estructura básica:
	
	DECLARE
		aquí se declaran las variables y otros datos que vamos a usar
	BEGIN
		instrucciones a ejecutar
	END; 
*/



/*-------------------------------------------------------------------------------------------------------------
!!	2. Declaración de variables
	La variables se declaran dentro del apartado DECLARE
	Ejemplo:
*/

--script: ejem1.sql (este ejemplo no puede ejecutarse ya que usa terminos explicativos que no pertenecen al lenguaje)
DECLARE
/* Aquí se definen las variables que vamos a necesitar*/
	nombre tipo; /*Podemos iniciarlas sin darles valor todavía*/
	nombre2 tipo2:=definicion; /*También podemos definirlas y darle su valor al mismo tiempo*/
	nombre3 constant tipo3:=definicion; /*Si ponemos "constant" esto es una constante y no puede modificarse su valor posteriormente*/

BEGIN
	nombre:=valor; --Como hemos declarado esta variable ahora podemos darlo un valor;
	nombre2:=nuevovalor; --Aunque a esta variable ya le habiamos dado una valor, es posible cambiarlo. De ahí que se llame "variable"

EXCEPTION
	/*aquí definimos lo que ocurre cuando se da un fallo*/
	excepciones;
END; /*con end terminamos el programa*/
/  /*al poner "/" indicamos que nos compile el programa. Si no lo hacemos el programa fallará*/

/*
	Los tipos de datos son similares a los usados en sql. Los más importantes son:
		-INT: numeros enteros
		-NUMBER: enteros y de coma flotante
		-CHAR: caracteres. Van entre ''
		-VARCHAR: cadenas de texto. Van entre ''
		-BOOLEAN: valores booleannos, es decir, puede ser TRUE o FALSE. 
		-DATE: fechas
		-Atributos de tipo: son %TYPE y %ROWTYPE. Se explicaran más adelante
		
*/




/*-------------------------------------------------------------------------------------------------------------
	3. Mostrar datos por pantalla
	Para poder mostrar el contenido de una variable o una cadena de texto
	usamos el comando:
	dbms_output.put_line(dato a mostar);
*/

--script:ejem2.sql
/*Para mostrar datos por pantalla hay que habilitar poner la variable:*/
SET SERVEROUTPUT ON
/*Despues ya podemos devolver datos por pantalla*/

DECLARE
nombre varchar(10):="Pepe"
BEGIN
DBMS_OUTPUT.PUT_LINE("Hola mundo");
DBMS_OUTPUT.PUT_LINE(nombre);
END;



/*-------------------------------------------------------------------------------------------------------------
	4.Operadores
	En PL/SQL se permiten utilizar todos los operadores de SQL: los operadores aritméticos (+ - * /), condicionales 
	(> < <> >= <= OR AND NOT) y de concatenacion (||). A estos operadores, PL/SQL 
	añade el operador de potencia **. Por ejemplo 4**3 es 43 */

--script:ejem3.sql
DECLARE
valor1 int:=5;
valor2 int:=2;
resul int:=0;
cadena1 varchar(10):="Aragorn";
cadena2 varchar(10):=" Hijo de Arathorn";
sumcadena varchar(20);
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

sumcadena:=cadena1||cadena2; --con "||" concatenamos dos cadenas
dbms_output.put_line(sumcadena);
END;



/*-------------------------------------------------------------------------------------------------------------
	5.Inserción de datos procedentes de una consulta

	Dentro de una variable también podemos insertar el resultado de una consulta. Eso sí, de momento 
	hemos de asegurarnos que sea del mismo tipo y de que la consulta devuelva un solo valor para guardarlo en la variable.
	En el futuro  podremos almacenar varias columnas y filas
*/

--script:ejem4.sql
/* Crearemos una variable llamanda "nombre_empleado" donde guardaremos el nombre del empleado con codigo=1 de
la tabla empleados. 
*/
DECLARE
nombre_empleado VARCHAR(50);
BEGIN
select nombre into nombre_empleado from empleados where codigoempleado=1; 
--La consulta es igual a una normal con la diferencia de que usamos "into <variable>" para indicar donde guardar el resultado
END;




/*-------------------------------------------------------------------------------------------------------------
	6.Atributos de tipo: %TYPE y %ROWTYPE
	A la hora de definir el tipo de una variable podemos hacerlo indicandolo explicitamente (ejemplo: int o varchar)
	o usando estos tipos comodines.

	%TYPE representa el tipo de otra variable o el campo de alguna tabla
	%ROWTYPE representa todos los campos de una tabla permitiendo introducir dentro de la variable una fila entera
	como resultado de una consulta. O, incluso, referenciando a cada campo por sepadado.
*/

--script:ejem5.sql
/*
Ejemplo de uso para %TYPE y %ROWTYPE
*/
set serveroutput on
DECLARE
fila empleados%ROWTYPE; --Ahora fila contiene todos los campos de la tabla empleados
valor empleados.nombre%TYPE; --valor es del mismo tipo que el campo nombre de la tabla empleados. Es decir, varchar(50)
BEGIN

select nombre into valor from empleados where codigoempleado=1;
DBMS_OUTPUT.PUT_LINE(valor);

select * into fila from empleados where codigoempleado=1;
DBMS_OUTPUT.PUT_LINE(fila.nombre||' '||fila.codigoempleado); --como ves podemos referenciar a los campos individualmente
fila.nombre:='Juan'; --tambien podemos modificar los valores de cada campo
DBMS_OUTPUT.PUT_LINE(fila.nombre||' '||fila.codigoempleado);
END;



/*-------------------------------------------------------------------------------------------------------------
	7. Actualizar y borrar datos
	Para actualizar o borrar datos de una tabla lo haremos usando las expresiones del lenguaje DML, solo que
	dentro de la estructura de un script PL/SQL
*/

--script:ejem6.sql
--Pone una N al principio del nombre de todos los empleados cuyo codigo sea mayor que 10 y borra al empleado 
--con codigo 40
DECLARE
inicial char:='N';
codigo int:=40;
BEGIN
UPDATE empleados SET nombre = inicial||nombre WHERE codigoempleado>10;
delete from empleados where codigoempleado=codigo;
END;



/*-------------------------------------------------------------------------------------------------------------
	8. Sentencias condicionales

	Mediante una sentencia condional podemos ejecutar o no una serie de instrucciones en funcion de si cumplen
	determinadas caracteristicas. Esto nos permitira controlar el flujo del programa y hacer que se adapte 
	segun las condiciones que definamos.

	esta es la estructura mas simple del if:

		if <condicion> THEN
			sentencias que se ejecutan si se cumplen
		END IF
*/

--script:ejem7.sql
SET SERVEROUTPUT ON
DECLARE
valor1 int:=5;
valor2 int:=2;

BEGIN

if valor1 > valor2 THEN
	DBMS_OUTPUT.PUT_LINE('Se cumple la condicion');
END IF;

if valor1 < valor2 THEN
	DBMS_OUTPUT.PUT_LINE('En este no se cumplira');
END IF;

--Tambien podemos usar "else". Lo que pongamos dentro del else se ejecutara si no se cumple la condicion. Solo podemos poner uno

if valor1 < valor2 THEN
	DBMS_OUTPUT.PUT_LINE('En este no se cumplira');

ELSE 
	DBMS_OUTPUT.PUT_LINE('como no se cumple la condicion yo sí me ejecutare');
END IF;

/* 
También podemos usar "ELSIF". Con esto vamos comprobando una por una cada condicion hasta que una se cumpla.
De esta forma, en cuanto lleguemos a una condicion que se cumple, ya no ejecutaremos ninguna de las siguientes
*/

if valor1 < valor2 THEN
	DBMS_OUTPUT.PUT_LINE('En este no se cumplira');

elsif valor1<10 THEN
	DBMS_OUTPUT.PUT_LINE('YO sí me ejecuto');
elsif valor2<10 THEN
	DBMS_OUTPUT.PUT_LINE('Como la anterior es valida yo no llego a ejecutarme');	
END IF;


--Como es logico tambien podemos poner un else al final de los elsif
if valor1 < valor2 THEN
	DBMS_OUTPUT.PUT_LINE('En este no se cumplira');

elsif valor1>10 THEN
	DBMS_OUTPUT.PUT_LINE('YO no me ejecuto');
elsif valor2>10 THEN
	DBMS_OUTPUT.PUT_LINE('Yo tampoco');

ELSE 
	DBMS_OUTPUT.PUT_LINE('Como ninguna de las anteriores es correcta yo me ejecuto');
END IF;

END;
/


--ejercicio: ejer1.slq (solucion:ejer1solu.sql)