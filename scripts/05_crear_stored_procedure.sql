/********************************************************************************************
* PROYECTO: Base de Datos para E-commerce "Estilo Urbano"
* SCRIPT: 05 - Creación de Stored Procedures
* AUTOR: Matias Centofanti
* FECHA: 20/10/2025
* DESCRIPCIÓN:
* Creación de procedimientos almacenados para encapsular la lógica de negocio,
* centralizar operaciones complejas y proveer una interfaz segura para la
* manipulación de datos.
********************************************************************************************/

SET NOCOUNT ON;
GO

-- =========================================================================================
-- PROCEDIMIENTO 1: REGISTRAR UNA VENTA SIMPLE (VERSIÓN MEJORADA)
-- Propósito: Registra la venta de un único producto. Esta versión mejorada incluye
-- manejo transaccional para garantizar la atomicidad (o todo se ejecuta o nada) y
-- control de errores. Delega la actualización de stock al trigger 'trg_GestionarVenta'.
--
-- PARÁMETROS:
-- @ClienteID: ID del cliente que realiza la compra.
-- @EmpleadoID: ID del empleado que registra la venta.
-- @ProductoID: ID del producto a vender.
-- @Cantidad: Número de unidades a vender.
-- @NuevaVentaID: Parámetro de salida que devolverá el ID de la venta creada.
-- =========================================================================================
CREATE PROCEDURE sp_RegistrarVentaSimple
    @ClienteID INT,
    @EmpleadoID INT,
    @ProductoID INT,
    @Cantidad INT,
    @NuevaVentaID INT OUTPUT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @PrecioUnitario DECIMAL(10, 2);
        DECLARE @TotalVenta DECIMAL(10, 2);

        -- 1. Obtener el precio del producto
        SELECT @PrecioUnitario = Precio FROM Productos WHERE ProductoID = @ProductoID;
        IF @PrecioUnitario IS NULL
        BEGIN
            RAISERROR('El producto especificado no existe.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END;

        SET @TotalVenta = @PrecioUnitario * @Cantidad;

        -- 2. Crear el registro maestro de la venta
        INSERT INTO Ventas (ClienteID, EmpleadoID, Total)
        VALUES (@ClienteID, @EmpleadoID, @TotalVenta);

        -- 3. Obtener el ID de la venta recién creada
        SET @NuevaVentaID = SCOPE_IDENTITY();

        -- 4. Insertar el detalle de la venta.
        -- NOTA: El trigger 'trg_GestionarVenta' se encargará automáticamente
        -- de validar y actualizar el stock. No lo hacemos aquí para evitar redundancia.
        INSERT INTO DetalleVenta (VentaID, ProductoID, Cantidad, Subtotal)
        VALUES (@NuevaVentaID, @ProductoID, @Cantidad, @TotalVenta);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Si ocurre cualquier error, se revierte toda la transacción
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Relanzar el error para que la aplicación cliente lo reciba
        THROW;
    END CATCH;
END;
GO

---
### ## 💡 Procedimientos Adicionales para un Portfolio de Alto Impacto

Los siguientes procedimientos demuestran técnicas más avanzadas y resuelven problemas del mundo real.

-- =========================================================================================
-- TIPO DE DATO PERSONALIZADO (TVP) PARA CARRITO DE COMPRAS
-- Propósito: Crear una estructura (un tipo de tabla) que nos permitirá pasar una lista
-- de productos (el carrito) a un stored procedure en una sola llamada.
-- =========================================================================================
CREATE TYPE dbo.TipoCarrito AS TABLE (
    ProductoID INT,
    Cantidad INT
);
GO

-- =========================================================================================
-- PROCEDIMIENTO 2 (AVANZADO): REGISTRAR VENTA DE UN CARRITO COMPLETO
-- Propósito: Procesa una venta con múltiples productos. Utiliza el TVP 'TipoCarrito'
-- para recibir todos los artículos en una sola llamada, lo cual es extremadamente
-- eficiente y una práctica común en aplicaciones reales.
-- =========================================================================================
CREATE PROCEDURE sp_RegistrarVentaCompleta
    @ClienteID INT,
    @EmpleadoID INT,
    @Carrito dbo.TipoCarrito READONLY, -- El carrito se pasa como una tabla
    @NuevaVentaID INT OUTPUT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @TotalVenta DECIMAL(10, 2);

        -- 1. Calcular el total de la venta sumando los subtotales de todos los productos del carrito
        SELECT @TotalVenta = SUM(p.Precio * c.Cantidad)
        FROM @Carrito c
        JOIN Productos p ON c.ProductoID = p.ProductoID;

        -- 2. Crear el registro maestro de la venta con el total calculado
        INSERT INTO Ventas (ClienteID, EmpleadoID, Total)
        VALUES (@ClienteID, @EmpleadoID, @TotalVenta);

        SET @NuevaVentaID = SCOPE_IDENTITY();

        -- 3. Insertar todos los productos del carrito en DetalleVenta
        -- El trigger 'trg_GestionarVenta' se ejecutará por cada fila insertada
        INSERT INTO DetalleVenta (VentaID, ProductoID, Cantidad, Subtotal)
        SELECT @NuevaVentaID, c.ProductoID, c.Cantidad, p.Precio * c.Cantidad
        FROM @Carrito c
        JOIN Productos p ON c.ProductoID = p.ProductoID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
GO

-- =========================================================================================
-- PROCEDIMIENTO 3 (UTILIDAD): BÚSQUEDA DE PRODUCTOS
-- Propósito: Ofrecer una forma centralizada y segura de buscar productos en el catálogo,
-- por ejemplo, desde una barra de búsqueda en una aplicación.
-- =========================================================================================
CREATE PROCEDURE sp_BuscarProducto
    @TerminoBusqueda VARCHAR(100)
AS
BEGIN
    SELECT
        p.ProductoID,
        p.NombreProducto,
        p.Talle,
        p.Precio,
        p.StockActual,
        c.NombreCategoria
    FROM vw_Inventario p
    LEFT JOIN Categorias c ON p.NombreCategoria = c.NombreCategoria
    WHERE p.NombreProducto LIKE '%' + @TerminoBusqueda + '%'
       OR c.NombreCategoria LIKE '%' + @TerminoBusqueda + '%';
END;
GO

-- =========================================================================================
-- PROCEDIMIENTO 4 (UTILIDAD): OBTENER HISTORIAL DE COMPRAS DE UN CLIENTE
-- Propósito: Obtener todas las compras realizadas por un cliente específico, utilizando
-- la vista maestra para obtener un reporte completo y detallado.
-- =========================================================================================
CREATE PROCEDURE sp_ObtenerHistorialCliente
    @ClienteID INT
AS
BEGIN
    SELECT
        FechaVenta,
        NombreProducto,
        NombreCategoria,
        Cantidad,
        Subtotal,
        NombreEmpleado
    FROM vw_VentasCompleto
    WHERE ClienteID = @ClienteID
    ORDER BY FechaVenta DESC;
END;
GO

/********************************************************************************************
* FIN DEL SCRIPT 05
********************************************************************************************/
