-- 02_insertar_datos.sql
-- Inserci�n de datos de prueba para Estilo Urbano

-- Categor�as
INSERT INTO Categorias (NombreCategoria) VALUES 
('Remeras'), 
('Pantalones'), 
('Camperas'), 
('Zapatillas');

-- Productos
INSERT INTO Productos (NombreProducto, Talle, Precio, StockActual, CategoriaID) VALUES
('Remera B�sica Blanca', 'M', 5500.00, 20, 1),
('Remera Estampada Negra', 'L', 6300.00, 15, 1),
('Pantal�n Chino Beige', 'M', 10500.00, 10, 2),
('Campera de Jean', 'L', 14500.00, 5, 3),
('Zapatillas Urbanas', '42', 18900.00, 8, 4);
