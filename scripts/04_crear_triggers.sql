-- 04_crear_triggers.sql
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

-- Trigger que valida si hay stock suficiente antes de insertar en DetalleVenta

CREATE TRIGGER trg_ValidarStock
ON DetalleVenta
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM INSERTED i
        JOIN Productos p ON i.ProductoID = p.ProductoID
        WHERE i.Cantidad > p.StockActual
    )
    BEGIN
        RAISERROR ('No hay suficiente stock para completar la venta.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- Si hay stock suficiente, insertamos el detalle y restamos stock
    INSERT INTO DetalleVenta (VentaID, ProductoID, Cantidad, Subtotal)
    SELECT VentaID, ProductoID, Cantidad, Subtotal
    FROM INSERTED;

    UPDATE p
    SET p.StockActual = p.StockActual - i.Cantidad
    FROM Productos p
    JOIN INSERTED i ON i.ProductoID = p.ProductoID;
END;
GO

-- Trigger de auditoría en Productos
CREATE TRIGGER trg_Auditoria_Productos
ON Productos
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        INSERT INTO AuditoriaCambios (TablaAfectada, Operacion, UsuarioSistema, RegistroAfectado)
        SELECT 'Productos', 'INSERT/UPDATE', SYSTEM_USER,
               CONCAT('ProductoID: ', ProductoID, ', Nombre: ', NombreProducto, ', Precio: ', Precio)
        FROM inserted;
    END

    IF EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO AuditoriaCambios (TablaAfectada, Operacion, UsuarioSistema, RegistroAfectado)
        SELECT 'Productos', 'DELETE', SYSTEM_USER,
               CONCAT('ProductoID: ', ProductoID, ', Nombre: ', NombreProducto, ', Precio: ', Precio)
        FROM deleted;
    END
END;
GO
