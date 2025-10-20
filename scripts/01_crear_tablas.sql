/********************************************************************************************
* PROYECTO: Base de Datos para E-commerce "Estilo Urbano"
* SCRIPT: 01 - Creación de Tablas
* AUTOR: Matias Centofanti
* FECHA: 20/10/2025
* DESCRIPCIÓN:
* Este script crea la estructura completa de la base de datos, incluyendo todas las tablas,
* claves primarias, claves foráneas y relaciones para la gestión de la tienda.
********************************************************************************************/

-- =========================================================================================
-- SECCIÓN 1: TABLAS FUNDAMENTALES (CORE)
-- Tablas maestras con información esencial que no depende de otras.
-- =========================================================================================

CREATE TABLE Categorias (
    CategoriaID INT PRIMARY KEY IDENTITY(1,1),
    NombreCategoria VARCHAR(50) NOT NULL
);

CREATE TABLE Proveedores (
    ProveedorID INT PRIMARY KEY IDENTITY(1,1),
    NombreProveedor VARCHAR(100) NOT NULL,
    Telefono VARCHAR(20),
    Email VARCHAR(100)
);

CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY IDENTITY(1,1),
    NombreCompleto VARCHAR(100),
    Email VARCHAR(100) UNIQUE, -- El email debería ser único
    Telefono VARCHAR(20),
    Direccion VARCHAR(150)
);

CREATE TABLE Empleados (
    EmpleadoID INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(100) NOT NULL,
    Rol VARCHAR(50) NOT NULL
);

CREATE TABLE Cajas (
    CajaID INT PRIMARY KEY IDENTITY(1,1),
    NombreCaja NVARCHAR(50) NOT NULL,
    SaldoInicial DECIMAL(10,2) NOT NULL,
    SaldoActual DECIMAL(10,2) NOT NULL
);

CREATE TABLE CampañasPublicitarias (
    CampañaID INT PRIMARY KEY IDENTITY(1,1),
    NombreCampaña NVARCHAR(100) NOT NULL,
    Descripcion NVARCHAR(255),
    FechaInicio DATE NOT NULL,
    FechaFin DATE NOT NULL,
    Presupuesto DECIMAL(10,2)
);

-- =========================================================================================
-- SECCIÓN 2: GESTIÓN DE PRODUCTOS E INVENTARIO
-- Tablas relacionadas con productos, stock y precios.
-- =========================================================================================

CREATE TABLE Productos (
    ProductoID INT PRIMARY KEY IDENTITY(1,1),
    NombreProducto VARCHAR(100) NOT NULL,
    Talle VARCHAR(10),
    Precio DECIMAL(10,2) NOT NULL,
    StockActual INT NOT NULL DEFAULT 0,
    CategoriaID INT,
    ProveedorID INT,
    CONSTRAINT FK_Productos_Categorias FOREIGN KEY (CategoriaID) REFERENCES Categorias(CategoriaID),
    CONSTRAINT FK_Productos_Proveedores FOREIGN KEY (ProveedorID) REFERENCES Proveedores(ProveedorID)
);

CREATE TABLE EntradasStock (
    EntradaID INT PRIMARY KEY IDENTITY(1,1),
    ProductoID INT NOT NULL,
    ProveedorID INT NOT NULL,
    Cantidad INT NOT NULL,
    FechaEntrada DATE NOT NULL DEFAULT GETDATE(),
    Observaciones NVARCHAR(255),
    CONSTRAINT FK_EntradasStock_Producto FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID),
    CONSTRAINT FK_EntradasStock_Proveedor FOREIGN KEY (ProveedorID) REFERENCES Proveedores(ProveedorID)
);

CREATE TABLE SalidasStock (
    SalidaID INT PRIMARY KEY IDENTITY(1,1),
    ProductoID INT NOT NULL,
    Cantidad INT NOT NULL,
    FechaSalida DATE NOT NULL DEFAULT GETDATE(),
    Motivo NVARCHAR(100) NOT NULL,
    CONSTRAINT FK_SalidasStock_Producto FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID)
);

CREATE TABLE HistorialPrecios (
    ID INT PRIMARY KEY IDENTITY(1,1),
    ProductoID INT,
    PrecioAnterior DECIMAL(10,2),
    PrecioNuevo DECIMAL(10,2),
    FechaCambio DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_HistorialPrecios_Producto FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID)
);

-- =========================================================================================
-- SECCIÓN 3: GESTIÓN DE VENTAS Y TRANSACCIONES
-- Tablas centrales del negocio: ventas, detalles, pagos y facturas.
-- =========================================================================================

CREATE TABLE Ventas (
    VentaID INT PRIMARY KEY IDENTITY(1,1),
    ClienteID INT,
    EmpleadoID INT,
    FechaVenta DATETIME DEFAULT GETDATE(),
    Total DECIMAL(10,2),
    CONSTRAINT FK_Ventas_Clientes FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID),
    CONSTRAINT FK_Ventas_Empleados FOREIGN KEY (EmpleadoID) REFERENCES Empleados(EmpleadoID)
);

CREATE TABLE DetalleVenta (
    DetalleID INT PRIMARY KEY IDENTITY(1,1),
    VentaID INT,
    ProductoID INT,
    Cantidad INT,
    Subtotal DECIMAL(10,2),
    CONSTRAINT FK_DetalleVenta_Venta FOREIGN KEY (VentaID) REFERENCES Ventas(VentaID),
    CONSTRAINT FK_DetalleVenta_Producto FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID)
);

CREATE TABLE Pagos (
    PagoID INT PRIMARY KEY IDENTITY(1,1),
    VentaID INT NOT NULL,
    Monto DECIMAL(10,2) NOT NULL,
    MetodoPago NVARCHAR(50) NOT NULL,
    FechaPago DATE NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Pagos_Venta FOREIGN KEY (VentaID) REFERENCES Ventas(VentaID)
);

CREATE TABLE Facturas (
    FacturaID INT PRIMARY KEY IDENTITY(1,1),
    VentaID INT NOT NULL,
    NumeroFactura NVARCHAR(50) NOT NULL UNIQUE,
    FechaEmision DATE NOT NULL DEFAULT GETDATE(),
    Total DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_Facturas_Venta FOREIGN KEY (VentaID) REFERENCES Ventas(VentaID)
);

CREATE TABLE Devoluciones (
    DevolucionID INT PRIMARY KEY IDENTITY(1,1),
    VentaID INT NOT NULL,
    ProductoID INT NOT NULL,
    Cantidad INT NOT NULL,
    FechaDevolucion DATE NOT NULL DEFAULT GETDATE(),
    Motivo NVARCHAR(255) NOT NULL,
    CONSTRAINT FK_Devoluciones_Venta FOREIGN KEY (VentaID) REFERENCES Ventas(VentaID),
    CONSTRAINT FK_Devoluciones_Producto FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID)
);

-- =========================================================================================
-- SECCIÓN 4: GESTIÓN DE CLIENTES (CRM)
-- Tablas para seguimiento de clientes, puntos e historial.
-- =========================================================================================

CREATE TABLE PuntosClientes (
    PuntoID INT PRIMARY KEY IDENTITY(1,1),
    ClienteID INT NOT NULL,
    PuntosAcumulados INT NOT NULL DEFAULT 0,
    FechaUltimaActualizacion DATE NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_PuntosClientes_Cliente FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

CREATE TABLE HistorialComprasClientes (
    HistorialID INT PRIMARY KEY IDENTITY(1,1),
    ClienteID INT NOT NULL,
    ProductoID INT NOT NULL,
    FechaCompra DATE NOT NULL DEFAULT GETDATE(),
    Cantidad INT NOT NULL,
    CONSTRAINT FK_HistorialCompras_Cliente FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID),
    CONSTRAINT FK_HistorialCompras_Producto FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID)
);

-- =========================================================================================
-- SECCIÓN 5: GESTIÓN DE PERSONAL (RRHH)
-- Tablas relacionadas con el manejo de empleados.
-- =========================================================================================

CREATE TABLE Vendedores (
    VendedorID INT PRIMARY KEY IDENTITY(1,1),
    EmpleadoID INT UNIQUE NOT NULL,
    CONSTRAINT FK_Vendedores_Empleado FOREIGN KEY (EmpleadoID) REFERENCES Empleados(EmpleadoID)
);

CREATE TABLE AsistenciasEmpleados (
    AsistenciaID INT PRIMARY KEY IDENTITY(1,1),
    EmpleadoID INT NOT NULL,
    Fecha DATE NOT NULL DEFAULT GETDATE(),
    Estado NVARCHAR(50) NOT NULL, -- Ej: 'Presente', 'Ausente', 'Tardanza'
    CONSTRAINT FK_Asistencia_Empleado FOREIGN KEY (EmpleadoID) REFERENCES Empleados(EmpleadoID)
);

CREATE TABLE Salarios (
    SalarioID INT PRIMARY KEY IDENTITY(1,1),
    EmpleadoID INT NOT NULL,
    Monto DECIMAL(10,2) NOT NULL,
    FechaPago DATE NOT NULL,
    CONSTRAINT FK_Salarios_Empleado FOREIGN KEY (EmpleadoID) REFERENCES Empleados(EmpleadoID)
);

-- =========================================================================================
-- SECCIÓN 6: GESTIÓN DE PROVEEDORES
-- Tablas para el manejo de pedidos a proveedores.
-- =========================================================================================

CREATE TABLE PedidosProveedores (
    PedidoProveedorID INT PRIMARY KEY IDENTITY(1,1),
    ProveedorID INT NOT NULL,
    FechaPedido DATE NOT NULL DEFAULT GETDATE(),
    Estado NVARCHAR(50) NOT NULL, -- Ej: 'Pendiente', 'Recibido', 'Cancelado'
    CONSTRAINT FK_PedidosProveedores_Proveedor FOREIGN KEY (ProveedorID) REFERENCES Proveedores(ProveedorID)
);

CREATE TABLE DetallePedidoProveedor (
    DetalleID INT PRIMARY KEY IDENTITY(1,1),
    PedidoProveedorID INT NOT NULL,
    ProductoID INT NOT NULL,
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_DetallePedido_Pedido FOREIGN KEY (PedidoProveedorID) REFERENCES PedidosProveedores(PedidoProveedorID),
    CONSTRAINT FK_DetallePedido_Producto FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID)
);

-- =========================================================================================
-- SECCIÓN 7: SISTEMA, SEGURIDAD Y AUDITORÍA
-- Tablas para usuarios, roles y seguimiento de cambios.
-- =========================================================================================

CREATE TABLE Roles (
    RolID INT PRIMARY KEY IDENTITY(1,1),
    NombreRol VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Usuarios (
    UsuarioID INT PRIMARY KEY IDENTITY(1,1),
    NombreUsuario VARCHAR(50) UNIQUE NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    RolID INT,
    CONSTRAINT FK_Usuarios_Roles FOREIGN KEY (RolID) REFERENCES Roles(RolID)
);

CREATE TABLE AuditoriaCambios (
    ID INT PRIMARY KEY IDENTITY(1,1),
    TablaAfectada VARCHAR(50),
    Operacion VARCHAR(20), -- Ej: 'INSERT', 'UPDATE', 'DELETE'
    FechaHora DATETIME DEFAULT GETDATE(),
    UsuarioSistema VARCHAR(100),
    RegistroAfectado VARCHAR(MAX) -- Para almacenar los datos viejos/nuevos en formato JSON o XML
);

CREATE TABLE MovimientosCaja (
    MovimientoID INT PRIMARY KEY IDENTITY(1,1),
    CajaID INT NOT NULL,
    FechaMovimiento DATE NOT NULL DEFAULT GETDATE(),
    TipoMovimiento NVARCHAR(50) NOT NULL, -- Ej: 'Ingreso Venta', 'Retiro', 'Ajuste'
    Monto DECIMAL(10,2) NOT NULL,
    Descripcion NVARCHAR(255),
    CONSTRAINT FK_MovimientosCaja_Caja FOREIGN KEY (CajaID) REFERENCES Cajas(CajaID)
);


-- =========================================================================================
-- SECCIÓN 8: DESCUENTOS Y PROMOCIONES
-- Se crea al final ya que puede tener múltiples relaciones.
-- =========================================================================================

CREATE TABLE Descuentos (
    DescuentoID INT PRIMARY KEY IDENTITY(1,1),
    NombreDescuento NVARCHAR(100) NOT NULL,
    Porcentaje DECIMAL(5,2) NOT NULL,
    FechaInicio DATE NOT NULL,
    FechaFin DATE NOT NULL,
    ProductoID INT NULL, -- Puede ser un descuento para un producto específico
    CampañaID INT NULL, -- O puede estar asociado a una campaña
    CONSTRAINT FK_Descuentos_Productos FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID),
    CONSTRAINT FK_Descuentos_Campañas FOREIGN KEY (CampañaID) REFERENCES CampañasPublicitarias(CampañaID)
);

/********************************************************************************************
* FIN DEL SCRIPT 01
********************************************************************************************/
