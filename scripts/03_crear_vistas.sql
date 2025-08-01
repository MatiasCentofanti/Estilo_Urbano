-- Crear vista para mostrar el inventario actual junto con la categoría del producto
CREATE VIEW vw_Inventario AS
SELECT 
    p.ProductoID,         -- ID del producto
    p.NombreProducto,     -- Nombre del producto
    p.Talle,              -- Talle del producto (ejemplo: S, M, L)
    p.Precio,             -- Precio unitario
    p.StockActual,        -- Cantidad disponible en stock
    c.NombreCategoria     -- Nombre de la categoría (ejemplo: Remeras, Pantalones)
FROM Productos p
LEFT JOIN Categorias c ON p.CategoriaID = c.CategoriaID;
GO

-- Crear vista para mostrar el detalle de las ventas con información del producto
CREATE VIEW vw_VentasDetalle AS
SELECT 
    v.VentaID,            -- ID de la venta
    v.FechaVenta,         -- Fecha en que se realizó la venta
    dv.ProductoID,        -- ID del producto vendido
    p.NombreProducto,     -- Nombre del producto vendido
    dv.Cantidad,          -- Cantidad vendida de ese producto
    dv.Subtotal           -- Subtotal (cantidad * precio) para ese producto en la venta
FROM Ventas v
INNER JOIN DetalleVenta dv ON v.VentaID = dv.VentaID
INNER JOIN Productos p ON dv.ProductoID = p.ProductoID;
GO
