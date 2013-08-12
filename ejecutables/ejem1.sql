
/*Estructira básica del pl/sql*/
DECLARE
/* Aquí se definen las variables que vamos a necesitar*/
	nombre tipo; /*Podemos iniciarlas sin darles valor todavía*/
	nombre2 tipo2:=definicion; /*También podemos definirlas y darle su valor al mismo tiempo*/
	nombre3 constant tipo3:=definicion; --Si ponemos "constant" esto es una constante y no puede modificarse su valor posteriormente

BEGIN
	--Instrucciones a ejecutar
	intruccion1;
	instruccion2;

EXCEPTION
	--aquí definimos lo que ocurre cuando se da un fallo
	excepciones;
END; --con end terminamos el programa
/ --al poner "/" indicamos que nos compile el programa. Si no lo hacemos el porgrama falla



