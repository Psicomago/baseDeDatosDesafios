-- este script(reiniciar.sql) reestablece los valores iniciales de las tablas,
-- para poder ejecutar el scripts de las consultas del desafío sin errores de duplicado

UPDATE producto SET stock = stock + 5 WHERE id = 9;
UPDATE producto SET stock = stock + 3 WHERE id = 1;
UPDATE producto SET stock = stock + 3 WHERE id = 2;
DELETE FROM detalle_compra WHERE id = 45;
DELETE FROM detalle_compra WHERE id = 44;
DELETE FROM detalle_compra WHERE id = 43;
DELETE FROM compra WHERE id = 34;
DELETE FROM compra WHERE id = 33;
DELETE FROM cliente WHERE id = 11;
SELECT * FROM producto;
SELECT * FROM detalle_compra;
SELECT * FROM compra;