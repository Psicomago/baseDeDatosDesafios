-- El cliente usuario01 -> id 1 ha realizado la siguiente compra:
-- ●producto: producto9. -> id 9
-- ●cantidad: 5.
-- ●fecha: fecha del sistema.



SELECT * FROM producto WHERE id = 9;

BEGIN TRANSACTION;
    
    INSERT INTO compra(id,cliente_id,fecha) VALUES (34,(SELECT id FROM cliente WHERE nombre='usuario01'),Current_timestamp);
    INSERT INTO detalle_compra(id,producto_id,compra_id,cantidad) VALUES (44,9,34,5);
    UPDATE producto SET stock = stock - 5 WHERE id = 9;

COMMIT;

SELECT * FROM producto WHERE id = 9;