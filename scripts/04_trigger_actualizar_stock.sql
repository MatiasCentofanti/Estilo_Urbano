-- 04_trigger_actualizar_stock.sql
-- Trigger que actualiza el stock en Productos después de insertar un detalle de venta

CREATE TRIGGER trg_ActualizarStock
ON DetalleVenta
AFTER INSERT
AS
BEGIN
    -- Actualiza el stock restando la cantidad vendida
    UPDATE p
    SET p.StockActual = p.StockActual - i.Cantidad
    FROM Productos p
    INNER JOIN inserted i ON p.ProductoID = i.ProductoID;
END;
GO

