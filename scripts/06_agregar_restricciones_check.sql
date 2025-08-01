-- Asegura que el precio no sea negativo
ALTER TABLE Productos
ADD CONSTRAINT chk_Precio_positivo CHECK (Precio >= 0);

-- Asegura que el stock no sea negativo
ALTER TABLE Productos
ADD CONSTRAINT chk_Stock_positivo CHECK (StockActual >= 0);

-- Asegura que la cantidad en DetalleVenta no sea menor a 1
ALTER TABLE DetalleVenta
ADD CONSTRAINT chk_Cantidad_valida CHECK (Cantidad >= 1);

