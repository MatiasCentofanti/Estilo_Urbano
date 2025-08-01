-- 05_crear_stored_procedure.sql
-- Stored Procedure para registrar una venta completa
CREATE PROCEDURE sp_RegistrarVenta
    @ProductoID INT,
    @Cantidad INT
AS
BEGIN
    DECLARE @Precio DECIMAL(10,2);
    DECLARE @Subtotal DECIMAL(10,2);
    DECLARE @VentaID INT;

    -- Obtener precio del producto
    SELECT @Precio = Precio FROM Productos WHERE ProductoID = @ProductoID;

    SET @Subtotal = @Precio * @Cantidad;

    -- Insertar venta
    INSERT INTO Ventas (Total) VALUES (@Subtotal);

    -- Obtener el ID de la venta recién insertada
    SET @VentaID = SCOPE_IDENTITY();

    -- Insertar detalle de la venta
    INSERT INTO DetalleVenta (VentaID, ProductoID, Cantidad, Subtotal)
    VALUES (@VentaID, @ProductoID, @Cantidad, @Subtotal);

    -- Actualizar stock
    UPDATE Productos
    SET StockActual = StockActual - @Cantidad
    WHERE ProductoID = @ProductoID;
END;



