-- 02_insertar_datos.sql
-- Inserción de datos de prueba para Estilo Urbano

-- Categorías
INSERT INTO Categorias (NombreCategoria) VALUES 
('Remeras'), 
('Pantalones'), 
('Camperas'), 
('Zapatillas');

-- Productos
INSERT INTO Productos (NombreProducto, Talle, Precio, StockActual, CategoriaID) VALUES
('Remera Básica Blanca', 'M', 5500.00, 20, 1),
('Remera Estampada Negra', 'L', 6300.00, 15, 1),
('Pantalón Chino Beige', 'M', 10500.00, 10, 2),
('Campera de Jean', 'L', 14500.00, 5, 3),
('Zapatillas Urbanas', '42', 18900.00, 8, 4);
