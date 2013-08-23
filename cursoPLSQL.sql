/*
  ____                       ____  _        ______   ___  _     
 / ___|   _ _ __ ___  ___   |  _ \| |      / / ___| / _ \| |    
| |  | | | | '__/ __|/ _ \  | |_) | |     / /\___ \| | | | |    
| |__| |_| | |  \__ \ (_) | |  __/| |___ / /  ___) | |_| | |___ 
 \____\__,_|_|  |___/\___/  |_|   |_____/_/  |____/ \__\_\_____|
                                                                
				Kamisama666
				v 0.8

En este curso aprenderemos los fundamentos del lenguaje PL/SQL, un lenguaje de programación
diseñado para ser usado con en motor de bases de datos Oracle. Por esta razón solo podrá 
usarse con esta base de datos y no otra. Para realizar este curso es necesario conocer
el lenguaje de consultas SQL, el lenguaje de manipulacion DML y algunos conceptos básicos de programación.

Como en cualquier otro lenguaje, las istrucciones de PL/SQL se guardan en archivos de texto plano 
denominados scripts. Para ejercutarlos usaremos la orden:
	@<ruta_archivo>;
Junto con el curso se adjunta una carpeta llamada "ejecutables" en la que se guardan los scripts usados en el
curso para que puedan ser directamente ejecutado. A lo largo del curso se indicará el nombre del 
script usado con la sintaxis.
	--script: <nombre>
Tambien encontraras varioes ejercicios para realizar en la carpeta ejercicios asi como su solucion.
A lo largo del curso se indicara cuando se puede realizar cada uno con la sintaxis:
	--ejercio: <nombre>
Esa guía ha sido realizada usando Oracle 11g r2 en un CentOS 6.4

*/

-------------------------------------------------------------------------------------------------------------

	--#Comandos oracle
	--Para ver las tablas de una schema:
	select table_name from user_tables;



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
	usamos el comando
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


--ejercicio: ejer1.slq (solucion:ejer1solu.sql)



-------------------------------------------------------------------------------------------------------------
/*	Estructuras de control
		-If
		-case
		-loop
		-while
		-for

*/

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

--ejercicio: ejer2.sql (solucion:eje2solu.sql)
-------------------------------------------------------------------------------------------------------------
/*
	9. CASE

	Case tiene dos utilidades:
		-Evaluar una serie de condiciones hasta que una sea correcto, momento en que se ejecuta el codigo
		que corresponda a esa condicion
		-Evaluar una el contenido de una variable con una serie de valores hasta que coinciza con
		uno de ellos. Entonces ejecutara el codigo que le corresponda.


La sentencia case va comprobando el valor de una variable y, cuando coincide con el valor con el que los estamos comparando,
devuelve un valor. Esto es importante. La sentencia no ejecuta instrucciones sino que devuelve valores.
Esto significa que para capturar lo que devuelve habrá que meterlo dentro de una variable o mostrarlo con un 
DBMS_OUTPUT.PUT_LINE()
*/

--Podemos hacerlo de dos formas:

--1. Vamos haciendo comparaciones con el valor exacto de la varible:

--script:ejem8a.sql

set serveroutput on
DECLARE
nota varchar(5):='B';
texto varchar(10);

BEGIN
texto:=CASE nota 
WHEN 'A' THEN 'Muy buena' 
WHEN 'B' THEN 'Buena' --Esta es la correcta 
WHEN 'C' THEN 'Normal' 
WHEN 'D' THEN 'Mala' 
ELSE 'Desconocida' 
END; --Con un END indicamos que se termina el CASE
dbms_output.put_line(texto);
END;
--Como en nota hay 'B' en texto se guardara la cadena 'buena'


--Tambien podemos hacerlo con PUT_LINE:

--script:ejem8b.sql
SET SERVEROUTPUT ON
DECLARE
nota varchar(5):='B';

BEGIN
CASE nota 
WHEN 'A' THEN 
DBMS_OUTPUT.PUT_LINE('Muy buena');
WHEN 'B' THEN 
DBMS_OUTPUT.PUT_LINE('Buena');
WHEN 'C' THEN 
DBMS_OUTPUT.PUT_LINE('Normal');
WHEN 'D' THEN 
DBMS_OUTPUT.PUT_LINE('Mala');
ELSE 
DBMS_OUTPUT.PUT_LINE('Desconocida'); -- Tambien podemos usar ELSE para ejecutar una instruccion en el caso
--de que ninguni de los valores coincida

END CASE; --cuando el CASE no devuelve un valor que hay que guardar en la variable se ha de terminar con END CASE

END;

--De esta forma no hay que guardarlo en una variable


--Por ultimo, en vez de que se haga una comparacion entre la variable y los posibles valores podemos definir nuestras propias
-- comparaciones

--script:ejem8c.sql
SET SERVEROUTPUT ON

DECLARE
nota NUMBER(3,1):=8.5;

BEGIN

CASE

WHEN nota < 5 AND nota >= 0 THEN 
	DBMS_OUTPUT.PUT_LINE('Suspenso');
WHEN nota >= 5 AND nota <7 THEN
	DBMS_OUTPUT.PUT_LINE('Aprobado');
WHEN nota >=7 AND nota <9 THEN 
	DBMS_OUTPUT.PUT_LINE('Notable');
WHEN nota >=9 AND nota <= 10 THEN 
	DBMS_OUTPUT.PUT_LINE('SOBRESALIENTE');
ELSE 
	DBMS_OUTPUT.PUT_LINE('Nota incorrecta');
END CASE;

END;

--De esta froma no estamos tan limitados en cuanto a las variables que usamos o las comparaciones que podemos hacer



-------------------------------------------------------------------------------------------------------------
/*
	10. LOOP
	Siguiendo con las sentencias de control de flujo, LOOP nos permite crear un bucle, es decir, ejecutar unas istrucciones
	repetidamente de forma indefinida. Si solo hacemos esto, el codigo se ejectura eternamente creando un bucle infinito,
	haciendo que el programa falle. Por esta razon, todo bucle debe ejecutar en algun momento la instruccion EXIT.
	Para controlar el momento en que ocurra esto definiremos alguna condicion para decir si es el momento de salir del bucle.

	Su estructura basica es

	LOOP
		<instrucciones>
		<instruccion_salida>
	END LOOP;
	
	Esta condicion puede ser definida de dos formas: usando el WHEN y el IF. Vamos a ver ambas en unos ejemplos en los
	que guardaremos el codigo de empleado mas alto e iremos imprimiendo el nombre del primer empleado, despues
	del segundo y así hasta llegar hasta el ultimo.
*/

--script: ejem9a.sql
set serveroutput on
DECLARE
mayor int;
nombreempleado varchar2(50);
contador int:=1;
BEGIN
select codigoempleado INTO mayor from empleados where codigoempleado >= all (select codigoempleado from empleados);

LOOP
select nombre into nombreempleado from empleados where codigoempleado=contador;
dbms_output.put_line(nombreempleado);
EXIT WHEN contador=mayor;
contador:=contador+1;
END LOOP;

END;




--script ejem9b.sql

set serveroutput on
DECLARE
mayor int;
nombreempleado varchar2(50);
contador int:=1;
BEGIN
select codigoempleado INTO mayor from empleados where codigoempleado >= all (select codigoempleado from empleados);

LOOP
    select nombre into nombreempleado from empleados where codigoempleado=contador;
    dbms_output.put_line(nombreempleado);
    if contador=mayor THEN
            EXIT;
    END IF;
    contador:=contador+1; 
END LOOP;

END;



-------------------------------------------------------------------------------------------------------------
/*
	11. WHILE
	De la misma forma que loop, WHILE ejecuta instrucciones dentro de un bucle pero él lleva integrado una condicion
	de salida de forma que no hay que crearla nosotros como con loop usando.

	Su estructura basica es

	WHILE <condicion> LOOP
		<instrucciones>
	END LOOP;

	Para comprobarlo haremos el mismo ejemplo anterior pero usando WHILE:
*/


--script:ejem10.sql

set serveroutput on

DECLARE
mayor int;
nombreempleado varchar2(50);
contador int:=1;

BEGIN
select codigoempleado INTO mayor from empleados where codigoempleado >= all (select codigoempleado from empleados);

WHILE contador<=mayor LOOP --como ves en la propia definicion de WHILE indicamos la condicion para que se siga ejecutando
select nombre into nombreempleado from empleados where codigoempleado=contador;
dbms_output.put_line(nombreempleado);
contador:=contador+1;
END LOOP; 

END;
/



-------------------------------------------------------------------------------------------------------------
/*
	12. FOR
	Como has podido observar, en los anteriores bucles hemos usado un indice numerico para determinar en que momento 
	debiamos terminar el bucle. Aunque la condicion podria ser cualquier otra, resulta muy util usar un indice.
	Por ello el bucle FOR lleva incorporado uno en su definion y decidira si continuar o salir en funcion de este.

	Para ello crea una variable que solo puede ser accedida dentro del bucle. La da un valor inicial y lo va incrementando
	hasta llegar a un valor final tambien especificado. Hasta entonces ejecuta las instrucciones de dentro.
	Como ves esto nos permite manejar un indice facilmente y dificulta crear un bucle infinito.

	Su estructura básica es:

	FOR <indice> IN <valor_inicio> .. <valor_final> LOOP
		<instrucciones>
	END LOOP;

	De nuevo lo veremos el funcionamiento con el mismo ejemplo:
*/
--script: ejem11a.sql

set serveroutput on
DECLARE
mayor int;
nombreempleado varchar2(50);
BEGIN
select codigoempleado INTO mayor from empleados where codigoempleado >= all (select codigoempleado from empleados);

FOR contador IN 1 .. mayor LOOP
select nombre into nombreempleado from empleados where codigoempleado=contador;
dbms_output.put_line(nombreempleado);
END LOOP;

END;


--Mediante la instruccion REVERSE podemos hacer que el contador empiece en el valor final y vaya hasta
--el inicial
--De esta forma mostraremos los nombre empezando por el último:

--script: ejem11b.sql
set serveroutput on
DECLARE
mayor int;
nombreempleado varchar2(50);
BEGIN
select codigoempleado INTO mayor from empleados where codigoempleado >= all (select codigoempleado from empleados);

FOR contador IN REVERSE 1 .. mayor LOOP
select nombre into nombreempleado from empleados where codigoempleado=contador;
dbms_output.put_line(nombreempleado);
END LOOP;

END;
/

--ejercicio:ejer3.sql (solucion:ejer3asolu.sql,ejer3bsolu.sql) y ejer4.sql (solucion:ejer4solu.sql)




-------------------------------------------------------------------------------------------------------------
/*
	13. CURSORES
	
	Los cursores son espacios de memoria, al igual que las variables, que nos permiten guardar el resultado de consultas.
	Existen dos tipos: los implicitos y los explicitos. En realidad, los primeros ya los hemos vistos. Cada vez que 
	realizamos una consulta y guardamos los resultados en una variable estamos usando un cursor implicito. Son cursores que 
	crean y manejan el sistema por si mismo y a los que no podemos acceder facilmente.	De ahí que solo podamos guardar
	un dato o una fila. Sin embargo, para poder acceder a todas las filas de una consulta podemos declarar
	un cursor explicito. Al declararlo con un nombre que lo identifique, podremos trabajar con él de forma más
	completa. Para ello, un puntero ira señalando cada una de las filas que devuelva la consulta para poder recuperar
	datos de ella. A la hora de trabajar con un cursor explicito hemos de seguir una serie de pasos:

		-Declarar el cursor: Le damos un nombre que lo identifique y hacemos la consulta que queremos guardar en el
		cursor.
		-Abrir el cursor: La consulta se realiza y se guarda en el cursor. Además, el puntero se coloca en la 
		primera fila.
		-Recuperar datos: Mediante la instruccion FETCH recuperamos los datos de una fila y los introducimos
		es una variable. A continuación el puntero pasa a señalar la siguiente fila. De esta forma iremos recuperando
		los datos fila por fila. Normalmente lo haremos a través de un bucle.
		-Cerramos el cursor. Se libera la memoria en la que se había guardado la consulta.

	Para poder trabajar con ellos, los cursores tienen una serie de propiedades. Gracias a estos podremos, por ejemplo,
	 cuando salir del bucle que recorre el cursor. Las que vamos a usar son:

		-%ISOPEN: devuelve TRUE si el cursor ha sido abierto.
		-%FOUND: devulve TRUE si el ultimo FETCH devolvió una fila. Por lo tanto, cuando hayamos recorrido
		todas las filas devolverá FALSE.
		-%NOTFOUND: lo contrario de la anterior.
		-%ROWCOUNT: indica el numero de filas que hemos recorrido.

	Veamoslo con un ejemplo. Realizaremos una consulta que devuelva el nombre de los clientes junto con el de sus
	representantes de ventas. Los iremos mostrando uno por uno junto con el numero de fila por la que vamos:
*/

--script: ejem12.sql
set serveroutput on
DECLARE
--Declaramos el cursor mediante la sintaxis: CURSOR <nombre> IS <consulta>
CURSOR cli_rep is select nombrecliente,nombre from clientes join empleados on codigoempleadorepventas=codigoempleado;
resultado cli_rep%ROWTYPE; --En esta variable guardaremos las filas que devulva la consulta. Como los datos
--son de varias tablas hacemos que coja los campos del cursor


BEGIN
OPEN cli_rep; --Abrimos el cursor con la sintaxis: OPEN <nombre>

FETCH cli_rep INTO resultado; --Hemos de hacer el FETCH antes de empezar el bucle para que %ISOPEN devulva TRUE
DBMS_OUTPUT.PUT_LINE(cli_rep%ROWCOUNT||'. '||resultado.nombrecliente||' tiene como representante a '||resultado.nombre);

WHILE cli_rep%FOUND LOOP
        FETCH cli_rep INTO resultado;
        DBMS_OUTPUT.PUT_LINE(cli_rep%ROWCOUNT||'. '||resultado.nombrecliente||' tiene como representante a '||resultado.nombre);
END LOOP;

CLOSE cli_rep; --Cerramos el cursor con la sentencia CLOSE

END;
/

--ejercicio:ejer5.sql (solu:ejer5solu.sql)


-------------------------------------------------------------------------------------------------------------
/*
	14. Excepciones
	Una excepcion es un error que se produce en el programa por diversas razones. Nosotros podemos manejar
	esas excepciones y ejecutar el codigo que creamos necesario, ya sea informando al usuario de lo
	que ha ocurrido o cancelando las operaciones realizadas para provocar inconsistencias en la base
	de datos (algo que veremos en el proximo apartado). Existen tres tipos de excepciones:

		-Internamente definidas: son excepciones definidas por Oracle. Tienen un número asignado para
		identificarlas.
		-Predefinidas internamente: Son como las anteriores pero, dado su frecuencia de ocurrecia, 
		Oracle las ha asignado un nombre para que sean más fáciles de manejar.
		-Definidas por el usuario: como dice el nombre, son excepciones definidas por nosotros.

	Independientemente de cual utilicemos, las ecepciones serán manejadas (especicando lo que queremos ejecutar) en
	la sección EXCEPTION, que se añade a las que ya conocíamos, DECLARE y BEGIN. En ella utilizaremos la siguiente
	sitaxis:

		WHEN <nombre_excepcion1> THEN
			codigo a ejecutar si se produce esta excepcion
		WHEN <nombre_excepcion2> THEN
			codigo a ejecutar si se produce esta excepcion
		WHEN OTHERS THEN
			codigo a ejecutar si se ha producido una excepcion que no es ninguna de las anteriores

	Como veis definimos que hacer en caso de que ocurran una serie de excepciones y, ademas, opcionalmente podemos
	usar WHEN OTHERS para definir que hacer en caso de que ocurra una excepcion que no hayamos preveido y, por lo
	tanto, no se encuentre entre las anteriores.


	Ahora veremos como trabajar con los tres tipos:


	
*/

/*

	-Internamente definidas:

	Dado que este tipo de instrucciones no tienen asignadas un nombre, la forma más comoda de trabajar con ellas
	es asignarle uno. Esto lo haremos de la siguiente manera:

	Lo que haremos será usar la excepcion -01422 que se da cuando intentamos introducir varios columnas en 
	una variable que no es un cursor. Esta excepcion esta predefinida pero nosotros la usaremos como si no.
*/

--script:ejem13.sql

set serveroutput on
DECLARE
ofinasspain oficinas%ROWTYPE; --aqui introduciremos el resultado de la consulta. 
demasiadas_columnas EXCEPTION; --delclaramos el nombre de la excepcion con la sintaxis: <nombre_excepcion> EXCEPTION
PRAGMA EXCEPTION_INIT(demasiadas_columnas,-01422); --asignamos el nombre que acabamos de definir a la excepcion
--que hemos elejido. Usamos la sintaxis: PRAGMA EXCEPTION_INIT(<nombre_excepcion>,<numero_excepcion>)

BEGIN

select * into ofinasspain from oficinas where pais='España';

EXCEPTION
	WHEN demasiadas_columnas THEN --Capturamos la excepcion
		DBMS_OUTPUT.PUT_LINE('La consulta tiene demasiadas columas'); --definimos lo que se ha de ejecutar
END;


/*
	-Excepciones predefinidas:

	Estas son excepciones comunes a las que el sistema les ha asignado un nombre (aunque también se pueden referenciar
	por su número identificador). Por lo tanto, no es necesario que las definamos nosotros, sino que podemos usarlas
	directamente.

	Las excepciones predefinidas más importantes son:

		-NO_DATA_FOUND (ORA-1403): Una consulta select no ha devuelto resultados.
		-TOO_MANY_ROWS (ORA-01422): una consulta ha devuelto más filas de las que puede almacenar la variable en la que se guarda
		-INVALID_CURSOR (ORA-01001): operación invalida con un cursor.
		-ZERO_DIVIDE (ORA-01476): División de un número por cero.
		-DUV_VAL_ON_INDEX (ORA-01017): inserción de un registro duplicado.

	En el anterior ejemplo usamos TOO_MANY_ROWS, pero a través de su identificador. Por ellos tuvimos que darle un nombre.
	Ahora realizaremos el mismo ejemplo pero usando su nombre predefinido
*/

--script: ejem14.sql
set serveroutput on
DECLARE
ofinasspain oficinas%ROWTYPE; --aqui introduciremos el resultado de la consulta. 

BEGIN
select * into ofinasspain from oficinas where pais='España';

EXCEPTION
	WHEN TOO_MANY_ROWS THEN --Como es una excepcion predefinida, podemos usarla sin tener que definirla nosotros
		DBMS_OUTPUT.PUT_LINE('La consulta tiene demasiadas columas'); 
END;


/*
	-Definidas por el usuario

	Son excepciones cuyo nombre definimos nosotros asi como cuando se activan, es decir, bajo cuales
	condiciones ocurrirá la excpcion. Lo primero que hacemos es definirla con la sintaxis:

		<nombre_excepcion> EXCEPTION;

	Despues, durante la ejecución del programa, definimos situaciones bajo las cuales se activaran las
	excepciones. Para lanzar las excepciones usamos:
	
		RAISE <nombre_excepcion>

	Para comprobarlo haremos una excepcion que ocurra si la fecha esperada de un pedido es anterior a su fecha 
	de entrega.
*/

--script: ejem15.sql
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


--ejercicio:ejer6.sql (solu:ejer6asolu.sql y ejer6bsolu.sql)





-------------------------------------------------------------------------------------------------------------
/*
	15. Transacciones	
	Una transacción es una o más sentencias que son tratadas como una sola unidad. Esto quiere decir que todas
	las intrucciones deben realizarse o ninguna lo hará. Por ejemplo, si realizamos un update de 20 campos y
	el número 10 provoca un error, todos los anteriores serán cancelados ya que no se han realizado todas
	las operaciones. Esto no permite realizar cambios sabiendo que, de ocurrir algún fallo, todas las acciones
	anteriores se cancelarían evitando asi inconsistencias en la base de datos. 

	Para entender su utilidad,imagina que estamos trabajando con la base de datos de un banco. Hemos de realizar 
	una transferencia de una cuenta a otra. Para ello, primero restamos la cantidad de una de las cuentas pero,
	al ir a sumarsela a la otra, se produce un error. Esto causaría que esa cantidad de dinero desapareciera
	virtualmente y dejara de existir para el sistema. Esto sería catastrofico. Para evitarlo podemos
	tratar toda la operación como una transacción de forma que, al producirse el error, la operación
	anterior se cancele y no se pierda el dinero.

	Por defecto, Oracle cada sentencia que ejecutemos como una transacción individual. Para evitar esto hemos de ejecutar
	la sentencia

			SET AUTOCOMMIT OFF

	A partir de entonces todas las sentencias que introduzcamos serán consideradas parte de una misma transacción y no
	se ejecutarán hasta que aceptemos o cancelemos la transacción.

	Para terminar una transacción y hacer que se ejecuten todas las instrucciones que contiene usamos las sentencia:

		COMMIT WORK

	Para terminar la transacción cancelando todas las instrucciones anteriores se utiliza:

		ROLLBACK WORK


	Veamos un ejemplo. Introduciremos un nuevo empleado en la base de datos y despues cambiaremos el codigooficina por
	uno erroneo para que surja un error. Capturaremos el error y ejecutaremos un rollback para cancelar la creación
	del empleado.
*/

SET AUTOCOMMIT OFF
SET SERVEROUTPUT ON
DECLARE
error_integridad EXCEPTION;
PRAGMA EXCEPTION_INIT(error_integridad,-02291);
nuevoempleado empleados%ROWTYPE;

BEGIN
insert into empleados values(32,'Juan','Lopez','Perales','10','emailj@k.com','PAR-FR',29,'becario'); --creamos el empleado si problemas
select * into nuevoempleado from empleados where codigoempleado=32;
dbms_output.put_line(nuevoempleado.codigoempleado||' '||nuevoempleado.nombre);
update empleados set CodigoOficina=10 where codigoempleado=32; 
COMMIT WORK;

EXCEPTION
WHEN error_integridad THEN
        ROLLBACK WORK;
        DBMS_OUTPUT.PUT_LINE('Se ha producido un error de integridad');
END;





-------------------------------------------------------------------------------------------------------------
/*
	16. Procedimientos
	Hasta ahora los scripts que hemos estado haciendo eran código anónimo, es decir, se ejecutaban una sola
	vez y no se podían volver a utilizar salvo volviendo a ejecutarlos. Sin embargo, los procedimientos
	nos permiten empaquetar una serie de instrucciones que realicen una función y que, una vez se ejecuten,
	quedarán guardadas e identificadas por un nombre para poder volver a usarlas. De esta forma podremos 
	llamarlos cada vez que los necesitemos sin tener que volver a compilar desde el código fuente.
	Además, al llamarlos, podemos pasarlos una serie de valores para que puedan trabajar con ellos.

	La estructura básica de un procedimiento es:


CREATE OR REPLACE PROCEDURE nombreProcedimiento (parámetro1 [modelo] tipoDatos, parámetro2 [modelo] tipoDatos) 
IS
declaraciones
BEGIN
instrucciones
EXCEPTION
captura de excepcioes
END;


	Poner OR REPLACE es opcional pero hace que, si ya existe un procedimiento con el mismo nombre, se replace con el nuestro.
	Los parametros también pueden omitirse, en cuyo caso no se necesita poner parentesis ni al crearlo ni al invocarlo.
	Lo que va después del IS corresponder a la parte de DECLARE.

	Hay que tener en cuenta que el tipo de los parametros no debe especificar su longitud. Es decir, no podemos
	poner varchar(30), solo varchar.

	El modelo que se pasa junto con las variables se refiere al uso que se le va a dar a esa variable. Pueden ser:

		IN: son variables que han sido definidas y que se le pasan al procedimiento para que use su contenido.
		OUT: estas se definen al declararlas y se les da contenido durante el procedimiento. De esta forma, podemos
		almacenar dentro algun dato durante la ejecucución del procedimiento y, cuando termine, podremos acceder a ellas
		desde el programa principal.
		INOUT: son una mezcla de las anteriores. Cuando se las pasa al procedimiento ya han sido definidas
		y contienen algún valor. Hacemos las operaciones necesaria con esa variable y, cuando se termina el
		procedimiento, podemos acceder a su nuevo valor desde el programa principal.

	Para llamar a un procedimiento dentro de un script tan solo hemos de poner su nombre y, si es necesario, 
	los parametros entre parentesis. De esta forma

		nombreProcedimiento(paramentro1, paramentro2);

	Si lo queremos llamar desde la línea de comando usarmos:

		call nombreProcedimiento(paramentro1, paramentro2);

	Vamos a ver un ejemplo de un procedimiento que tomara como parametro el codigo de un empleado y escribira en
	pantalla el nombre de su jefe.
*/

--script: ejem17.sql

set serveroutput on
CREATE OR REPLACE PROCEDURE escribejefe (codigoemp IN int)
IS
codigomijefe int;
nombrejefe varchar2(50);
BEGIN
select codigojefe into codigomijefe from empleados where codigoempleado=codigoemp;
select nombre into nombrejefe from empleados where codigoempleado=codigomijefe;
DBMS_OUTPUT.PUT_LINE(nombrejefe);
END;

/*
Ahora vamos a ver otro ejemplo similar al anterior. Pero en esta ocasion el procedimiento tamará como
paramentros el codigo del empleados y el nombre de una variable en la que almacenaremos el nombre 
completo del jefe. Esta vez no lo mostraremos directamente en pantalla sino que habra de ser mostrado
desde el programa principal.
*/

--script: ejem18.sql

set serveroutput on
CREATE OR REPLACE PROCEDURE devuelvejefe (codigoemp IN int, nombrejefecompleto OUT varchar2)
IS
codigomijefe int;
nombrejefe empleados%ROWTYPE;
BEGIN
select codigojefe into codigomijefe from empleados where codigoempleado=codigoemp;
select * into nombrejefe from empleados where codigoempleado=codigomijefe;
nombrejefecompleto:=nombrejefe.nombre||' '||nombrejefe.apellido1||' '||nombrejefe.apellido2;
END;

/*
Para poder ver el funcionamiento del anterior script haremos otro que ejecute el procedimiento e
imprima el nombre del jefe. Este script debe ser ejecutado despues de introducir el procedimiento.
*/

--script:ejem18b.sql

set serveroutput on
DECLARE
nombrejefe varchar(70);
BEGIN
devuelvejefe(31,nombrejefe);
DBMS_OUTPUT.PUT_LINE(nombrejefe);
END;


/*
	Para borrar un procedimiento que ha sido almacenado usamos:

		DROP PROCEDURE nombre_procedimiento;
*/




-------------------------------------------------------------------------------------------------------------
/*
	17. Funciones

	Las funciones son un tipo especial de procedimiento y todo lo que sabemos sobre ellos se aplican a las 
	funciones. La diferencia devuelven un valor. Además, no pueden ser llamadas con la sentencia CALL como los
	procedimientos, tan solo pueden invocarse desde un script o un procedimiento.

	Para devolver el valor usaremos la instrucción:

		RETURN variable_devuelta;

	Tambien habremos de indicar al principio el tipo de dato que vamos a devolver. Es importante tener en mente que
	todos los parametros han de ser de tipo IN (es el que se pone por defecto, asi que no hay que especificarlo) y
	que no podemos usar sentencias de transacciones.


	Su estructura básica es:

CREATE OR REPLACE FUNCTION nombreFunción (parámetro1 tipoDatos,parámetro2 tipoDatos)
RETURN tipoDatoDevuelto
IS
secciónDeDeclaraciones
BEGIN
instrucciones
RETURN datodevuelto
EXCEPTION
controlDeExcepciones
END;

Haremos un ejemplo similar al anterior en que la función reciba el codigo de un empleado y devuelva
el nombre de su jefe. También haremos otro que llame a esta función.

*/

--script:ejem19.sql

CREATE OR REPLACE FUNCTION nombredejefe (codigomiempleado int)
RETURN varchar2
IS
codigomijefe int;
mijefe empleados%ROWTYPE;
nombremijefe varchar2(60);
BEGIN
select codigojefe into codigomijefe from empleados where codigoempleado=codigomiempleado;
select * into mijefe from empleados where codigoempleado=codigomijefe;
nombremijefe:=mijefe.nombre||' '||mijefe.apellido1||' '||mijefe.apellido2;
RETURN nombremijefe;
END;


--Con este lo llamaremos y mostraremos lo que devuelve

--script:ejem19b.sql

set serveroutput on
DECLARE
nombrejefe varchar2(60);
codigoempleado int:=31;
BEGIN
nombrejefe:=nombredejefe(codigoempleado);
DBMS_OUTPUT.PUT_LINE(nombrejefe);
END;


--Estos ejercicios incluyen todo lo que hemos dado recientemente: errores, transacciones, procedimientos y funciones.
--ejercicios: ejer7.sql, ejer8.sql