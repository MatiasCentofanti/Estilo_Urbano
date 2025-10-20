/********************************************************************************************
* PROYECTO: Base de Datos para E-commerce "Estilo Urbano"
* SCRIPT: 04 - Creación de Triggers
* AUTOR: Matias Centofanti
* FECHA: 20/10/2025
* DESCRIPCIÓN:
* Implementación de triggers para automatizar reglas de negocio críticas, garantizar
* la integridad de los datos y auditar cambios importantes en la base de datos.
********************************************************************************************/

-- =========================================================================================
-- TRIGGER 1: GESTIÓN INTEGRAL DE VENTA Y STOCK (VERSIÓN MEJORADA)
-- Propósito: Combina la validación de stock y la actualización del inventario en un
-- único trigger 'INSTEAD OF INSERT'. Esto asegura que una venta solo se registre si hay
-- stock suficiente, evitando inconsistencias y errores.
-- =========================================================================================
CREATE TRIGGER trg_GestionarVenta
ON DetalleVenta
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Paso 1: Validar si hay stock para todos los productos en el intento de inserción.
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Productos p ON i.ProductoID = p.ProductoID
        WHERE i.Cantidad > p.StockActual
    )
    BEGIN
        -- Si para algún producto no hay stock, se cancela toda la transacción.
        RAISERROR ('No hay suficiente stock para uno o más productos. La venta ha sido cancelada.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;

    -- Paso 2: Si la validación es exitosa, se procede con la inserción real.
    INSERT INTO DetalleVenta (VentaID, ProductoID, Cantidad, Subtotal)
    SELECT VentaID, ProductoID, Cantidad, Subtotal
    FROM inserted;

    -- Paso 3: Se actualiza el stock de los productos correspondientes.
    UPDATE p
    SET p.StockActual = p.StockActual - i.Cantidad
    FROM Productos p
    JOIN inserted i ON p.ProductoID = i.ProductoID;
END;
GO

-- =========================================================================================
-- TRIGGER 2: AUDITORÍA DE CAMBIOS EN LA TABLA PRODUCTOS (VERSIÓN MEJORADA)
-- Propósito: Registrar automáticamente cualquier cambio (creación, actualización o
-- borrado) en la tabla Productos. El registro se guarda en un formato más detallado
-- para facilitar el seguimiento y la recuperación de información.
-- =========================================================================================
CREATE TRIGGER trg_Auditoria_Productos
ON Productos
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Auditoría para operaciones INSERT
    IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO AuditoriaCambios (TablaAfectada, Operacion, UsuarioSistema, RegistroAfectado)
        SELECT 'Productos', 'INSERT', SYSTEM_USER,
            CONCAT('Datos Nuevos: { "ProductoID": "', i.ProductoID, '", "Nombre": "', i.NombreProducto, '", "Precio": "', i.Precio, '" }')
        FROM inserted i;
    END

    -- Auditoría para operaciones UPDATE
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO AuditoriaCambios (TablaAfectada, Operacion, UsuarioSistema, RegistroAfectado)
        SELECT 'Productos', 'UPDATE', SYSTEM_USER,
            CONCAT('Datos Anteriores: { "ProductoID": "', d.ProductoID, '", "Nombre": "', d.NombreProducto, '", "Precio": "', d.Precio, '" } | ',
                   'Datos Nuevos: { "ProductoID": "', i.ProductoID, '", "Nombre": "', i.NombreProducto, '", "Precio": "', i.Precio, '" }')
        FROM inserted i
        JOIN deleted d ON i.ProductoID = d.ProductoID;
    END

    -- Auditoría para operaciones DELETE
    IF EXISTS (SELECT * FROM deleted) AND NOT EXISTS (SELECT * FROM inserted)
    BEGIN
        INSERT INTO AuditoriaCambios (TablaAfectada, Operacion, UsuarioSistema, RegistroAfectado)
        SELECT 'Productos', 'DELETE', SYSTEM_USER,
            CONCAT('Datos Eliminados: { "ProductoID": "', d.ProductoID, '", "Nombre": "', d.NombreProducto, '", "Precio": "', d.Precio, '" }')
        FROM deleted d;
    END
END;
GO
