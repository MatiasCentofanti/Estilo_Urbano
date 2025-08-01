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
('Remera Básica Negra', 'M', 1500.00, 10, 1),
('Remera Estampada', 'L', 1800.00, 8, 1),
('Jean Clásico', '32', 3000.00, 6, 2),
('Jean Slim Fit', '30', 3200.00, 4, 2),
('Zapatilla Deportiva', '42', 7000.00, 5, 3),
('Zapatilla Casual', '41', 6500.00, 7, 3);
('Remera Manga Larga', 'S', 1600.00, 12, 1),
('Remera Deportiva', 'M', 2000.00, 15, 1),
('Jean Relaxed Fit', '34', 2800.00, 5, 2),
('Pantalón Chino', '32', 2700.00, 7, 2),
('Campera de Cuero', 'L', 8500.00, 2, 3),
('Campera Jeans', 'M', 4800.00, 6, 3),
('Zapatilla Running', '43', 7200.00, 8, 4),
('Zapatilla de Skate', '44', 6800.00, 4, 4);
('Remera Oversize', 'XL', 1900.00, 14, 1),
('Remera Básica Blanca', 'M', 1400.00, 20, 1),
('Remera Polo', 'L', 2200.00, 10, 1),
('Remera de Algodón Orgánico', 'S', 2500.00, 9, 1),
('Jean Skinny', '28', 3100.00, 7, 2),
('Jean Tiro Alto', '30', 3300.00, 8, 2),
('Pantalón Cargo', '32', 2900.00, 11, 2),
('Pantalón Jogger', 'M', 2600.00, 13, 2),
('Campera Acolchada', 'L', 7000.00, 5, 3),
('Campera Softshell', 'M', 6800.00, 6, 3),
('Campera Rompeviento', 'S', 5500.00, 4, 3),
('Campera con Capucha', 'XL', 7200.00, 3, 3),
('Zapatilla Trail', '42', 7500.00, 12, 4),
('Zapatilla Casual de Lona', '41', 6200.00, 14, 4),
('Zapatilla de Baloncesto', '44', 9000.00, 7, 4),
('Zapatilla Minimalista', '43', 6800.00, 10, 4),
('Zapatilla para Gimnasio', '40', 6700.00, 8, 4),
('Zapatilla Running Pro', '42', 8300.00, 9, 4),
('Zapatilla Vintage', '41', 6400.00, 11, 4),
('Zapatilla con Luces', '39', 7200.00, 5, 4);
('Remera Vintage Estampada', 'M', 2100.00, 15, 1),
('Remera Deportiva Técnica', 'L', 2300.00, 13, 1),
('Remera Básica Azul', 'S', 1400.00, 18, 1),
('Remera Cuello V', 'M', 1600.00, 20, 1),
('Jean Ripped', '32', 3500.00, 6, 2),
('Jean Recto', '34', 3000.00, 9, 2),
('Pantalón Formal', '32', 4000.00, 4, 2),
('Pantalón de Tela', '30', 2800.00, 11, 2),
('Campera Parka', 'L', 7800.00, 5, 3),
('Campera de Lana', 'M', 7200.00, 7, 3),
('Campera Técnica', 'S', 8000.00, 3, 3),
('Campera Reflectiva', 'XL', 8500.00, 2, 3),
('Zapatilla de Montaña', '43', 9500.00, 6, 4),
('Zapatilla Casual Alta', '42', 6800.00, 14, 4),
('Zapatilla Running Ligera', '41', 7400.00, 9, 4),
('Zapatilla Crossfit', '40', 7100.00, 8, 4),
('Zapatilla Urbana', '44', 6900.00, 12, 4),
('Zapatilla Skate Low', '42', 6500.00, 7, 4),
('Remera Manga Corta Estampada', 'M', 1700.00, 16, 1),
('Remera de Algodón Premium', 'L', 2400.00, 10, 1),
('Remera Deportiva con Logo', 'S', 2200.00, 12, 1),
('Remera Básica Negra', 'XL', 1500.00, 18, 1),
('Jean Stretch', '30', 3200.00, 7, 2),
('Jean Tiro Medio', '32', 3100.00, 8, 2),
('Pantalón Deportivo', 'M', 2800.00, 14, 2),
('Pantalón Cargo Slim', '34', 3000.00, 9, 2),
('Campera Softshell Impermeable', 'L', 7800.00, 5, 3),
('Campera Acolchada Ligera', 'M', 7000.00, 7, 3),
('Campera con Capucha Desmontable', 'S', 7500.00, 4, 3),
('Campera de Jean Clásica', 'XL', 4900.00, 6, 3),
('Zapatilla Deportiva de Trail', '42', 9500.00, 8, 4),
('Zapatilla Casual Deportiva', '41', 6700.00, 10, 4),
('Zapatilla Running Profesional', '43', 8800.00, 7, 4),
('Zapatilla de Skate Alta', '44', 7000.00, 6, 4),
('Zapatilla Urbana Moderna', '42', 6900.00, 9, 4),
('Zapatilla con Soporte Extra', '40', 7200.00, 5, 4),
('Zapatilla Ligera para Gimnasio', '41', 6800.00, 11, 4),
('Zapatilla de Moda con Plataforma', '39', 7300.00, 4, 4);

-- Ventas
INSERT INTO Ventas (Total) VALUES (10500.00);
INSERT INTO Ventas (Total) VALUES (8700.00);
INSERT INTO Ventas (Total) VALUES (14300.00);
INSERT INTO Ventas (Total) VALUES (21000.00);
INSERT INTO Ventas (Total) VALUES (5600.00);
INSERT INTO Ventas (Total) VALUES (9800.00);
INSERT INTO Ventas (Total) VALUES (11700.00);
INSERT INTO Ventas (Total) VALUES (13400.00);
INSERT INTO Ventas (Total) VALUES (6900.00);
INSERT INTO Ventas (Total) VALUES (8500.00);
INSERT INTO Ventas (Total) VALUES (9200.00);
INSERT INTO Ventas (Total) VALUES (7600.00);
INSERT INTO Ventas (Total) VALUES (6300.00);
INSERT INTO Ventas (Total) VALUES (11300.00);
INSERT INTO Ventas (Total) VALUES (15700.00);
INSERT INTO Ventas (Total) VALUES (8900.00);
INSERT INTO Ventas (Total) VALUES (14800.00);
INSERT INTO Ventas (Total) VALUES (7900.00);
INSERT INTO Ventas (Total) VALUES (12100.00);
INSERT INTO Ventas (Total) VALUES (9900.00);

-- DetalleVenta
INSERT INTO DetalleVenta (VentaID, ProductoID, Cantidad, Subtotal) VALUES
(1, 1, 2, 10500.00),
(2, 3, 1, 8700.00),
(3, 5, 1, 14300.00),
(4, 2, 2, 21000.00),
(5, 7, 1, 5600.00),
(6, 6, 2, 9800.00),
(7, 8, 1, 11700.00),
(8, 4, 2, 13400.00),
(9, 9, 1, 6900.00),
(10, 10, 1, 8500.00),
(11, 11, 1, 9200.00),
(12, 12, 1, 7600.00),
(13, 13, 2, 6300.00),
(14, 14, 1, 11300.00),
(15, 15, 2, 15700.00),
(16, 16, 1, 8900.00),
(17, 17, 2, 14800.00),
(18, 18, 1, 7900.00),
(19, 19, 2, 12100.00),
(20, 20, 1, 9900.00);

INSERT INTO Clientes (NombreCompleto, Email, Telefono, Direccion)
VALUES 
('Lucía Fernández', 'lucia.fernandez@email.com', '1123456789', 'Av. Siempre Viva 123'),
('Carlos Gómez', 'carlos.gomez@email.com', '1167894321', 'Calle Falsa 456'),
('Mariana López', 'mariana.lopez@email.com', '1134567890', 'Boulevard Central 789'),
('Diego Ramírez', 'diego.ramirez@email.com', '1176543210', 'Pasaje Estrella 321'),
('Sofía Torres', 'sofia.torres@email.com', '1145678901', 'Ruta 8 Km 45'),
('Julián Pereyra', 'julian.pereyra@email.com', '1198765432', 'Diagonal Norte 111'),
('Camila Sosa', 'camila.sosa@email.com', '1122334455', 'Camino del Sol 555'),
('Martín Rivas', 'martin.rivas@email.com', '1166112233', 'San Martín 2020'),
('Agustina Vera', 'agustina.vera@email.com', '1155667788', 'Av. Libertad 987'),
('Nicolás Méndez', 'nicolas.mendez@email.com', '1177223344', 'Los Pinos 4040');

UPDATE Ventas
SET ClienteID = ABS(CHECKSUM(NEWID()) % 10) + 1
WHERE ClienteID IS NULL;

INSERT INTO Empleados (Nombre, Rol) VALUES
('Carlos Pérez', 'Vendedor'),
('Laura Gómez', 'Cajera'),
('Sofía Martínez', 'Vendedor'),
('Marcos Díaz', 'Encargado'),
('Romina Torres', 'Vendedor');

INSERT INTO Vendedores (EmpleadoID) VALUES (1), (3), (5);

update Ventas
set EmpleadoID = 1
where VentaID = 1;

update Ventas
set EmpleadoID = 3
where VentaID in (2, 3, 4, 5, 6);

update Ventas
set EmpleadoID = 5
where VentaID between 7 and 13;

update Ventas
set EmpleadoID = 1
where VentaID between 14 and 18;

update Ventas
set EmpleadoID = 3
where VentaID in (19, 20);
