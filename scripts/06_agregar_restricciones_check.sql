/********************************************************************************************
* PROYECTO: Base de Datos para E-commerce "Estilo Urbano"
* SCRIPT: 06 - Adición de Restricciones (Constraints)
* AUTOR: Matias Centofanti
* FECHA: 20/10/2025
* DESCRIPCIÓN:
* Este script aplica un conjunto de restricciones CHECK y UNIQUE para garantizar la
* integridad, consistencia y adherencia a las reglas de negocio de los datos en la BD.
********************************************************************************************/

-- =========================================================================================
-- SECCIÓN 1: RESTRICCIONES DE VERIFICACIÓN (CHECK)
-- Propósito: Asegurar que los valores numéricos se mantengan dentro de rangos lógicos
-- para el negocio, previniendo datos inconsistentes como precios o cantidades negativas.
-- =========================================================================================

-- Restricción para asegurar que el precio de un producto nunca sea negativo.
ALTER TABLE Productos
ADD CONSTRAINT chk_Precio_positivo CHECK (Precio >= 0);
GO

-- Restricción para asegurar que el stock de un producto nunca sea negativo.
ALTER TABLE Productos
ADD CONSTRAINT chk_Stock_positivo CHECK (StockActual >= 0);
GO

-- Restricción para asegurar que la cantidad en un detalle de venta sea siempre al menos 1.
ALTER TABLE DetalleVenta
ADD CONSTRAINT chk_Cantidad_valida CHECK (Cantidad >= 1);
GO
