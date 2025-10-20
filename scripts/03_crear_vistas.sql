/********************************************************************************************
* PROYECTO: Base de Datos para E-commerce "Estilo Urbano"
* SCRIPT: 03 - Creación de Vistas
* AUTOR: Matias Centofanti
* FECHA: 20/10/2025
* DESCRIPCIÓN:
* Este script crea un conjunto de vistas para simplificar las consultas comunes,
* mejorar la seguridad y facilitar el acceso a datos complejos para análisis y reportes.
********************************************************************************************/

-- =========================================================================================
-- VISTA 1: INVENTARIO ACTUAL DE PRODUCTOS
-- Propósito: Ofrecer una visión rápida y clara del inventario disponible, combinando
-- información del producto con su categoría para facilitar la gestión de stock y reportes.
-- =========================================================================================
CREATE VIEW vw_Inventario AS
SELECT
    p.ProductoID,
    p.NombreProducto,
    p.Talle,
    p.Precio,
    p.StockActual,
    c.NombreCategoria
FROM
    Productos p
LEFT JOIN
    Categorias c ON p.CategoriaID = c.CategoriaID;
GO

-- =========================================================================================
-- VISTA 2: DETALLE GRANULAR DE VENTAS
-- Propósito: Desglosar cada venta en sus productos individuales, permitiendo un análisis
-- detallado del rendimiento de cada artículo en transacciones específicas. Es la base
-- para análisis de carritos de compra y performance de productos.
-- =========================================================================================
CREATE VIEW vw_VentasDetalle AS
SELECT
    v.VentaID,
    v.FechaVenta,
    dv.ProductoID,
    p.NombreProducto,
    dv.Cantidad,
    dv.Subtotal
FROM
    Ventas v
INNER JOIN
    DetalleVenta dv ON v.VentaID = dv.VentaID
INNER JOIN
    Productos p ON dv.ProductoID = p.ProductoID;
GO
