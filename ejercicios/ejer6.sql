/*
Vamos a provocar un par de errores y a capturarlos. Realiza estos dos ejercicios (ejer5a y ejer5b):

Primero divide 0 entre otro numero y muestra el resultado. Como dara error captura
la excepcion que corresponda mostrando el mensaje "No puede divir 0 por otro numero". 

Después vas a capturar el error ORA-00001. Este se produce cuando se introduce un valor repetido en un campo que no lo permite. 
Para ello usa la insercción que dejo más abajo. La razón de que lance el error es que ya hay un empleado con el codigo
31. Puedes comprobarlo realizando la insercción con otro codigo como 40 y viendo que no se produce ningún error.
Caundo captures este error muestra un mensaje diciendo "No puedes introducir campos primarios duplicados".

*/


insert into empleados values(32,'Juan','Lopez','Perales','10','emailj@k.com','PAR-FR',29,'becario');
update empleados set CodigoOficina=10 where codigoempleado=32; 
