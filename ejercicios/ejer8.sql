/*
	Este ejercicio tiene dos partes:

	Primero has de crear una funcion llamada solvenciacliente(). Esta tendra un parametro de entrada que tomara un 
	codigo de cliente. De este cliente comprobara si lo que debe (totalpedido-totalpagado) es menor que su 
	limite de credito. Si es asi devolvera  0. Si ha superado su limite devolvera 1. Es decir, devuelve un entero.
	Te recomiendo usar las funciones creadas en el ejercicio anterior para calculas los totales.

	Despues, crea un script (un bloque de código anónimo) que añada un nuevo pedido a la cuenta de un cliente.
	El escript usará transacciones asi que asugate de desconectar el autocommit. Primero comprobaras que dicho cliente
	(por ejemplo, el de codigocliente = 1) es solvente usando la función anterior. Si lo es, seguirás con el programa.
	Si no, saltará una excepcion que debes haber creado previamente y que debes capturar enseñando un mensaje de que
	el cliente no es solvente y terminando la transacción. En el caso de que no ocurra este error deberás crear un nuevo pedido
	y después los detalles del pedido. Para hacerlo asegurate de que introduces los datos correctos. De todas formas, 
	si se produce algun error durante el proceso, capturalo con en el error OTHERS y haz un ROLLBACK para cancelar los cambios.


*/

