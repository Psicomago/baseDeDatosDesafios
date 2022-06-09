


-- El cliente usuario01 -> id 1 ha realizado la siguiente compra:
-- ●producto: producto9. -> id 9
-- ●cantidad: 5.
-- ●fecha: fecha del sistema.


-- conectar a la base de datos
\c clientes

1.- El cliente usuario01 ha realizado la siguiente compra:
● producto: producto9.
● cantidad: 5.
● fecha: fecha del sistema.
Mediante el uso de transacciones, realiza las consultas correspondientes para este
requerimiento y luego consulta la tabla producto para validar si fue efectivamente
descontado en el stock. (3 Puntos)

--consulta stock del producto 9 antes de la transacción
SELECT descripcion,stock FROM producto WHERE id = 9;

BEGIN TRANSACTION;
    
    INSERT INTO compra(id,cliente_id,fecha) VALUES (33,(SELECT id FROM cliente WHERE nombre='usuario01'),Current_timestamp);
    INSERT INTO detalle_compra(id,producto_id,compra_id,cantidad) VALUES (43,9,33,5);
    UPDATE producto SET stock = stock - 5 WHERE id = 9;

COMMIT;


--consulta stock del producto 9 después de la transacción
SELECT descripcion,stock FROM producto WHERE id = 9;
----------------------------------------


-- 3. El cliente usuario02 ha realizado la siguiente compra:
-- ● producto: producto1, producto 2, producto 8.
-- ● cantidad: 3 de cada producto.
-- ● fecha: fecha del sistema.
-- Mediante el uso de transacciones, realiza las consultas correspondientes para este
-- requerimiento y luego consulta la tabla producto para validar que si alguno de ellos
-- se queda sin stock, no se realice la compra. (3 Puntos)

--consulta stock de los productos 1, 2 y 8 antes de la transacción
SELECT descripcion, stock FROM producto WHERE id = 1 OR id = 2 OR id = 8;


BEGIN TRANSACTION;
    
    INSERT INTO compra(id,cliente_id,fecha) VALUES (34,(SELECT id FROM cliente WHERE nombre='usuario02'),Current_timestamp);
    INSERT INTO detalle_compra(id,producto_id,compra_id,cantidad) VALUES (44,1,34,3);
    UPDATE producto SET stock = stock - 3 WHERE id = 1;
    INSERT INTO detalle_compra(id,producto_id,compra_id,cantidad) VALUES (45,2,34,3);
    UPDATE producto SET stock = stock - 3 WHERE id = 2;
    SAVEPOINT transaccion1;
    INSERT INTO detalle_compra(id,producto_id,compra_id,cantidad) VALUES (46,8,34,3);
    UPDATE producto SET stock = stock - 3 WHERE id = 8;
    ROLLBACK TO transaccion1;
COMMIT;

--consulta stock de los productos 1, 2 y 8 despues de la transacción
SELECT descripcion, stock FROM producto WHERE id = 1 OR id = 2 OR id = 8;
------------------------------------------------------------------------------

-- Realizar las siguientes consultas (2 Puntos):
-- a. Deshabilitar el AUTOCOMMIT .
-- b. Insertar un nuevo cliente.
-- c. Confirmar que fue agregado en la tabla cliente.
-- d. Realizar un ROLLBACK.
-- e. Confirmar que se restauró la información, sin considerar la inserción del
-- punto b.
-- f. Habilitar de nuevo el AUTOCOMMIT.

-- desactiva el autocommit
\echo :AUTOCOMMIT

\set AUTOCOMMIT off

INSERT INTO cliente(id,nombre,email) VALUES(11,'usuario011','usuario011@hotmail.com');

SELECT * FROM cliente;
ROLLBACK;

SELECT * FROM cliente;
COMMIT;
\set AUTOCOMMIT on
