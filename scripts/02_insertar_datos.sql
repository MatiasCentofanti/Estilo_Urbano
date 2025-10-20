/********************************************************************************************
* PROYECTO: Base de Datos para E-commerce "Estilo Urbano"
* SCRIPT: 02 - Inserción de Datos de Prueba (Seed)
* AUTOR: Matias Centofanti
* FECHA: 20/10/2025
* DESCRIPCIÓN:
* Este script puebla la base de datos con un conjunto de datos de prueba coherentes
* para simular el funcionamiento de la tienda y permitir el análisis de datos.
********************************************************************************************/

-- =========================================================================================
-- SECCIÓN 1: DATOS FUNDAMENTALES (CORE)
-- Inserción en tablas maestras que sirven como base para el resto de los datos.
-- =========================================================================================

-- Inserción de Categorías
INSERT INTO Categorias (NombreCategoria) VALUES
('Remeras'),
('Pantalones'),
('Camperas'),
('Zapatillas');

-- Inserción de Proveedores
INSERT INTO Proveedores (NombreProveedor, Telefono, Email) VALUES
('Moda Urbana S.A.', '1155338801', 'contacto@modaurbana.com'),
('Estilo Joven SRL', '1144223377', 'ventas@estilojoven.com'),
('SportLine Distribuciones', '1133665544', 'info@sportline.com'),
('Punto Streetwear', '1122889911', 'contacto@puntostreet.com'),
('Indumentaria Patagonia', '1166772200', 'ventas@patagoniaind.com'),
('Zapas al Tope', '1155667788', 'zapatillas@altopestyle.com'),
('Ropa y Más', '1133554466', 'info@ropaymas.com'),
('Distribuidora UrbanStyle', '1144778899', 'urban@distristyle.com'),
('Camperas y Abrigos S.R.L.', '1122113344', 'ventas@camperasabrigos.com'),
('Todo Pantalones', '1177990022', 'contacto@todopantalones.com');

-- Inserción de Clientes
INSERT INTO Clientes (NombreCompleto, Email, Telefono, Direccion) VALUES
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

-- Inserción de Empleados
INSERT INTO Empleados (Nombre, Rol) VALUES
('Carlos Pérez', 'Vendedor'),
('Laura Gómez', 'Cajera'),
('Sofía Martínez', 'Vendedor'),
('Marcos Díaz', 'Encargado'),
('Romina Torres', 'Vendedor');

-- Inserción de Cajas
INSERT INTO Cajas (NombreCaja, SaldoInicial, SaldoActual) VALUES
('Caja Principal', 50000.00, 50000.00),
('Caja Secundaria', 20000.00, 20000.00);

-- =========================================================================================
-- SECCIÓN 2: GESTIÓN DE PRODUCTOS E INVENTARIO
-- =========================================================================================

-- Inserción de Productos
INSERT INTO Productos (NombreProducto, Talle, Precio, StockActual, CategoriaID, ProveedorID) VALUES
-- Remeras (Cat 1, Prov 1)
('Remera Básica Blanca', 'M', 5500.00, 20, 1, 1),
('Remera Estampada Negra', 'L', 6300.00, 15, 1, 1),
('Remera Básica Negra', 'M', 1500.00, 10, 1, 1),
('Remera Estampada', 'L', 1800.00, 8, 1, 1),
('Remera Manga Larga', 'S', 1600.00, 12, 1, 1),
('Remera Deportiva', 'M', 2000.00, 15, 1, 1),
('Remera Oversize', 'XL', 1900.00, 14, 1, 1),
-- Pantalones (Cat 2, Prov 10)
('Pantalón Chino Beige', 'M', 10500.00, 10, 2, 10),
('Jean Clásico', '32', 3000.00, 6, 2, 10),
('Jean Slim Fit', '30', 3200.00, 4, 2, 10),
('Jean Relaxed Fit', '34', 2800.00, 5, 2, 10),
('Pantalón Chino', '32', 2700.00, 7, 2, 10),
-- Camperas (Cat 3, Prov 9)
('Campera de Jean', 'L', 14500.00, 5, 3, 9),
('Campera de Cuero', 'L', 8500.00, 2, 3, 9),
('Campera Jeans', 'M', 4800.00, 6, 3, 9),
-- Zapatillas (Cat 4, Prov 6)
('Zapatillas Urbanas', '42', 18900.00, 8, 4, 6),
('Zapatilla Deportiva', '42', 7000.00, 5, 4, 6),
('Zapatilla Casual', '41', 6500.00, 7, 4, 6),
('Zapatilla Running', '43', 7200.00, 8, 4, 6),
('Zapatilla de Skate', '44', 6800.00, 4, 4, 6);

-- Inserción de stock inicial basado en los productos ya cargados
INSERT INTO EntradasStock (ProductoID, Cantidad, FechaEntrada, ProveedorID, Observaciones)
SELECT ProductoID, StockActual, '2025-07-31', ProveedorID, 'Carga de stock inicial'
FROM Productos WHERE StockActual > 0;

-- =========================================================================================
-- SECCIÓN 3: GESTIÓN DE VENTAS Y TRANSACCIONES
-- =========================================================================================

-- Inserción de Ventas (aún sin ClienteID ni EmpleadoID)
INSERT INTO Ventas (Total, FechaVenta) VALUES
(10500.00, '2025-08-01 10:30:00'), (8700.00, '2025-08-01 11:15:00'),
(14300.00, '2025-08-02 12:00:00'), (21000.00, '2025-08-02 14:20:00'),
(5600.00, '2025-08-03 16:00:00'), (9800.00, '2025-08-03 17:45:00'),
(11700.00, '2025-08-04 10:10:00'), (13400.00, '2025-08-04 11:30:00'),
(6900.00, '2025-08-05 15:00:00'), (8500.00, '2025-08-05 16:40:00'),
(9200.00, '2025-08-06 18:00:00'), (7600.00, '2025-08-06 19:15:00'),
(6300.00, '2025-08-07 12:25:00'), (11300.00, '2025-08-07 13:50:00'),
(15700.00, '2025-08-08 14:05:00'), (8900.00, '2025-08-08 15:30:00'),
(14800.00, '2025-08-09 11:00:00'), (7900.00, '2025-08-09 12:45:00'),
(12100.00, '2025-08-10 16:20:00'), (9900.00, '2025-08-10 17:55:00');

-- Asignación de Clientes y Empleados a las Ventas
-- Nota: Se asigna un cliente aleatorio a cada venta para simular datos reales.
UPDATE Ventas SET ClienteID = ABS(CHECKSUM(NEWID()) % 10) + 1 WHERE ClienteID IS NULL;

-- Nota: Se asignan vendedores a bloques de ventas de forma consolidada.
UPDATE Ventas SET EmpleadoID =
    CASE
        WHEN VentaID IN (1, 14, 15, 16, 17, 18) THEN 1 -- Atendidas por Carlos Pérez
        WHEN VentaID IN (2, 3, 4, 5, 6, 19, 20) THEN 3 -- Atendidas por Sofía Martínez
        WHEN VentaID BETWEEN 7 AND 13 THEN 5           -- Atendidas por Romina Torres
    END
WHERE EmpleadoID IS NULL;

-- Inserción del Detalle de cada Venta
INSERT INTO DetalleVenta (VentaID, ProductoID, Cantidad, Subtotal) VALUES
(1, 1, 1, 5500.00), (1, 8, 1, 5000.00), -- Venta 1
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

-- Generación de Facturas y Pagos a partir de las ventas
INSERT INTO Facturas (VentaID, NumeroFactura, FechaEmision, Total)
SELECT VentaID, 'FAC-' + CAST(VentaID AS VARCHAR(10)), CAST(FechaVenta AS DATE), Total FROM Ventas;

INSERT INTO Pagos (VentaID, Monto, MetodoPago, FechaPago)
SELECT VentaID, Total, 'Efectivo', CAST(FechaVenta AS DATE) FROM Ventas;

-- Simulación de cambio de método de pago para algunas transacciones
UPDATE Pagos SET MetodoPago = 'Tarjeta de Crédito' WHERE VentaID % 2 = 0;

-- Simulación de Salidas de Stock por Venta
INSERT INTO SalidasStock (ProductoID, Cantidad, FechaSalida, Motivo)
SELECT dv.ProductoID, dv.Cantidad, CAST(v.FechaVenta AS DATE), 'Venta-' + CAST(v.VentaID AS VARCHAR(10))
FROM DetalleVenta dv JOIN Ventas v ON dv.VentaID = v.VentaID;


-- =========================================================================================
-- SECCIÓN 4: GESTIÓN DE CLIENTES (CRM)
-- =========================================================================================
INSERT INTO PuntosClientes (ClienteID, PuntosAcumulados, FechaUltimaActualizacion)
SELECT ClienteID, COUNT(VentaID) * 10, MAX(FechaVenta)
FROM Ventas WHERE ClienteID IS NOT NULL GROUP BY ClienteID;

-- =========================================================================================
-- SECCIÓN 5: GESTIÓN DE PERSONAL (RRHH)
-- =========================================================================================
INSERT INTO Vendedores (EmpleadoID) VALUES (1), (3), (5);

INSERT INTO AsistenciasEmpleados (EmpleadoID, Fecha, Estado) VALUES
(1, '2025-08-01', 'Presente'), (2, '2025-08-01', 'Presente'), (3, '2025-08-01', 'Ausente'), (4, '2025-08-01', 'Presente'), (5, '2025-08-01', 'Tarde'),
(1, '2025-08-02', 'Presente'), (2, '2025-08-02', 'Presente'), (3, '2025-08-02', 'Presente'), (4, '2025-08-02', 'Licencia'), (5, '2025-08-02', 'Presente'),
(1, '2025-08-03', 'Ausente'), (2, '2025-08-03', 'Presente'), (3, '2025-08-03', 'Presente'), (4, '2025-08-03', 'Presente'), (5, '2025-08-03', 'Presente');

INSERT INTO Salarios (EmpleadoID, Monto, FechaPago) VALUES
(1, 250000.00, '2025-07-31'), (2, 230000.00, '2025-07-31'), (3, 240000.00, '2025-07-31'), (4, 300000.00, '2025-07-31'), (5, 220000.00, '2025-07-31'),
(1, 250000.00, '2025-08-31'), (2, 230000.00, '2025-08-31'), (3, 240000.00, '2025-08-31'), (4, 300000.00, '2025-08-31'), (5, 220000.00, '2025-08-31');

-- =========================================================================================
-- SECCIÓN 6: GESTIÓN DE PROVEEDORES
-- =========================================================================================
INSERT INTO PedidosProveedores (ProveedorID, FechaPedido, Estado) VALUES
(1, '2025-07-02', 'Pendiente'), (6, '2025-07-05', 'Completado'), (9, '2025-07-08', 'En tránsito'),
(10, '2025-07-10', 'Pendiente'), (1, '2025-07-12', 'Completado');

INSERT INTO DetallePedidoProveedor (PedidoProveedorID, ProductoID, Cantidad, PrecioUnitario) VALUES
(1, 1, 20, 5500.00), (1, 2, 15, 6300.00),
(2, 16, 12, 18000.00), (2, 17, 8, 7000.00),
(3, 13, 5, 14000.00), (3, 14, 7, 8000.00),
(4, 8, 10, 10000.00), (4, 9, 15, 2800.00),
(5, 3, 10, 1400.00), (5, 4, 8, 1700.00);

-- =========================================================================================
-- SECCIÓN 7: SISTEMA, SEGURIDAD Y AUDITORÍA
-- =========================================================================================
INSERT INTO Roles (NombreRol) VALUES ('Vendedor'), ('Cajero'), ('Encargado'), ('Administrador');

INSERT INTO MovimientosCaja (CajaID, FechaMovimiento, TipoMovimiento, Monto, Descripcion) VALUES
(1, '2025-08-01', 'Ingreso', 10000.00, 'Venta del día'),
(1, '2025-08-02', 'Egreso', 5000.00, 'Pago a proveedores'),
(2, '2025-08-01', 'Ingreso', 4000.00, 'Fondo inicial'),
(2, '2025-08-03', 'Egreso', 2000.00, 'Compra de materiales');

/********************************************************************************************
* FIN DEL SCRIPT 02
********************************************************************************************/
