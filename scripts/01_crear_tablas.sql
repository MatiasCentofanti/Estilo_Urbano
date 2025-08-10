-- 01_creacion_tablas.sql
-- Script de creación de tablas para la tienda de ropa Estilo Urbano

CREATE TABLE Categorias (
    CategoriaID INT PRIMARY KEY IDENTITY(1,1),
    NombreCategoria VARCHAR(50) NOT NULL
);

CREATE TABLE Productos (
    ProductoID INT PRIMARY KEY IDENTITY(1,1),
    NombreProducto VARCHAR(100) NOT NULL,
    Talle VARCHAR(10) NOT NULL,
    Precio DECIMAL(10,2) NOT NULL,
    StockActual INT NOT NULL DEFAULT 0,
    CategoriaID INT,
    FOREIGN KEY (CategoriaID) REFERENCES Categorias(CategoriaID)
);

CREATE TABLE Ventas (
    VentaID INT PRIMARY KEY IDENTITY(1,1),
    FechaVenta DATETIME DEFAULT GETDATE(),
    Total DECIMAL(10,2)
);

CREATE TABLE DetalleVenta (
    DetalleID INT PRIMARY KEY IDENTITY(1,1),
    VentaID INT,
    ProductoID INT,
    Cantidad INT,
    Subtotal DECIMAL(10,2),
    FOREIGN KEY (VentaID) REFERENCES Ventas(VentaID),
    FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID)
);

CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY IDENTITY(1,1),
    NombreCompleto VARCHAR(100),
    Email VARCHAR(100),
    Telefono VARCHAR(20),
    Direccion VARCHAR(150)
);

ALTER TABLE Ventas ADD ClienteID INT FOREIGN KEY REFERENCES Clientes(ClienteID);

CREATE TABLE Empleados (
    EmpleadoID INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(100),
    Rol VARCHAR(50)
);

ALTER TABLE Ventas ADD EmpleadoID INT FOREIGN KEY REFERENCES Empleados(EmpleadoID);

CREATE TABLE Roles (
    RolID INT PRIMARY KEY IDENTITY(1,1),
    NombreRol VARCHAR(50)
);

CREATE TABLE Usuarios (
    UsuarioID INT PRIMARY KEY IDENTITY(1,1),
    NombreUsuario VARCHAR(50),
    PasswordHash VARCHAR(255),
    RolID INT FOREIGN KEY REFERENCES Roles(RolID)
);

CREATE TABLE Proveedores (
    ProveedorID INT PRIMARY KEY IDENTITY(1,1),
    NombreProveedor VARCHAR(100),
    Telefono VARCHAR(20),
    Email VARCHAR(100)
);

ALTER TABLE Productos ADD ProveedorID INT FOREIGN KEY REFERENCES Proveedores(ProveedorID);

CREATE TABLE HistorialPrecios (
    ID INT PRIMARY KEY IDENTITY(1,1),
    ProductoID INT FOREIGN KEY REFERENCES Productos(ProductoID),
    PrecioAnterior DECIMAL(10,2),
    PrecioNuevo DECIMAL(10,2),
    FechaCambio DATETIME DEFAULT GETDATE()
);

CREATE TABLE Vendedores (
    VendedorID INT PRIMARY KEY IDENTITY(1,1),
    EmpleadoID INT UNIQUE FOREIGN KEY REFERENCES Empleados(EmpleadoID)
);

CREATE TABLE AuditoriaCambios (
    ID INT PRIMARY KEY IDENTITY(1,1),
    TablaAfectada VARCHAR(50),
    Operacion VARCHAR(10),
    FechaHora DATETIME DEFAULT GETDATE(),
    UsuarioSistema VARCHAR(100),
    RegistroAfectado VARCHAR(MAX)
);

ALTER TABLE AuditoriaCambios
ALTER COLUMN Operacion VARCHAR(20);

CREATE TABLE EntradasStock (
    EntradaID INT IDENTITY(1,1) PRIMARY KEY,
    ProductoID INT NOT NULL,
    Cantidad INT NOT NULL,
    FechaEntrada DATE NOT NULL DEFAULT GETDATE(),
    ProveedorID INT NOT NULL,
    Observaciones NVARCHAR(255),
    CONSTRAINT FK_EntradasStock_Producto FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID),
    CONSTRAINT FK_EntradasStock_Proveedor FOREIGN KEY (ProveedorID) REFERENCES Proveedores(ProveedorID)
);

CREATE TABLE SalidasStock (
    SalidaID INT IDENTITY(1,1) PRIMARY KEY,
    ProductoID INT NOT NULL,
    Cantidad INT NOT NULL,
    FechaSalida DATE NOT NULL DEFAULT GETDATE(),
    Motivo NVARCHAR(100) NOT NULL,
    CONSTRAINT FK_SalidasStock_Producto FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID)
);

CREATE TABLE Pagos (
    PagoID INT IDENTITY(1,1) PRIMARY KEY,
    VentaID INT NOT NULL,
    Monto DECIMAL(10,2) NOT NULL,
    MetodoPago NVARCHAR(50) NOT NULL,
    FechaPago DATE NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Pagos_Venta FOREIGN KEY (VentaID) REFERENCES Ventas(VentaID)
);

CREATE TABLE Facturas (
    FacturaID INT IDENTITY(1,1) PRIMARY KEY,
    VentaID INT NOT NULL,
    NumeroFactura NVARCHAR(50) NOT NULL,
    FechaEmision DATE NOT NULL DEFAULT GETDATE(),
    Total DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_Facturas_Venta FOREIGN KEY (VentaID) REFERENCES Ventas(VentaID)
);

CREATE TABLE Descuentos (
    DescuentoID INT IDENTITY(1,1) PRIMARY KEY,
    NombreDescuento NVARCHAR(100) NOT NULL,
    Porcentaje DECIMAL(5,2) NOT NULL,
    FechaInicio DATE NOT NULL,
    FechaFin DATE NOT NULL
);

CREATE TABLE HistorialComprasClientes (
    HistorialID INT IDENTITY(1,1) PRIMARY KEY,
    ClienteID INT NOT NULL,
    ProductoID INT NOT NULL,
    FechaCompra DATE NOT NULL DEFAULT GETDATE(),
    Cantidad INT NOT NULL,
    CONSTRAINT FK_Historial_Cliente FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID),
    CONSTRAINT FK_Historial_Producto FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID)
);

CREATE TABLE AsistenciasEmpleados (
    AsistenciaID INT IDENTITY(1,1) PRIMARY KEY,
    EmpleadoID INT NOT NULL,
    Fecha DATE NOT NULL DEFAULT GETDATE(),
    Estado NVARCHAR(50) NOT NULL,
    CONSTRAINT FK_Asistencia_Empleado FOREIGN KEY (EmpleadoID) REFERENCES Empleados(EmpleadoID)
);

CREATE TABLE Salarios (
    SalarioID INT IDENTITY(1,1) PRIMARY KEY,
    EmpleadoID INT NOT NULL,
    Monto DECIMAL(10,2) NOT NULL,
    FechaPago DATE NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Salarios_Empleado FOREIGN KEY (EmpleadoID) REFERENCES Empleados(EmpleadoID)
);

CREATE TABLE Devoluciones (
    DevolucionID INT IDENTITY(1,1) PRIMARY KEY,
    VentaID INT NOT NULL,
    ProductoID INT NOT NULL,
    Cantidad INT NOT NULL,
    FechaDevolucion DATE NOT NULL DEFAULT GETDATE(),
    Motivo NVARCHAR(255) NOT NULL,
    CONSTRAINT FK_Devoluciones_Venta FOREIGN KEY (VentaID) REFERENCES Ventas(VentaID),
    CONSTRAINT FK_Devoluciones_Producto FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID)
);

CREATE TABLE PedidosProveedores (
    PedidoProveedorID INT IDENTITY(1,1) PRIMARY KEY,
    ProveedorID INT NOT NULL,
    FechaPedido DATE NOT NULL DEFAULT GETDATE(),
    Estado NVARCHAR(50) NOT NULL,
    CONSTRAINT FK_PedidosProveedores_Proveedor FOREIGN KEY (ProveedorID) REFERENCES Proveedores(ProveedorID)
);

CREATE TABLE DetallePedidoProveedor (
    DetalleID INT IDENTITY(1,1) PRIMARY KEY,
    PedidoProveedorID INT NOT NULL,
    ProductoID INT NOT NULL,
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_DetallePedido_Pedido FOREIGN KEY (PedidoProveedorID) REFERENCES PedidosProveedores(PedidoProveedorID),
    CONSTRAINT FK_DetallePedido_Producto FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID)
);

CREATE TABLE Cajas (
    CajaID INT IDENTITY(1,1) PRIMARY KEY,
    NombreCaja NVARCHAR(50) NOT NULL,
    SaldoInicial DECIMAL(10,2) NOT NULL,
    SaldoActual DECIMAL(10,2) NOT NULL
);

CREATE TABLE MovimientosCaja (
    MovimientoID INT IDENTITY(1,1) PRIMARY KEY,
    CajaID INT NOT NULL,
    FechaMovimiento DATE NOT NULL DEFAULT GETDATE(),
    TipoMovimiento NVARCHAR(50) NOT NULL,
    Monto DECIMAL(10,2) NOT NULL,
    Descripcion NVARCHAR(255),
    CONSTRAINT FK_MovimientosCaja_Caja FOREIGN KEY (CajaID) REFERENCES Cajas(CajaID)
);

CREATE TABLE PuntosClientes (
    PuntoID INT IDENTITY(1,1) PRIMARY KEY,
    ClienteID INT NOT NULL,
    PuntosAcumulados INT NOT NULL DEFAULT 0,
    FechaUltimaActualizacion DATE NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_PuntosClientes_Cliente FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

CREATE TABLE CampañasPublicitarias (
    CampañaID INT IDENTITY(1,1) PRIMARY KEY,
    NombreCampaña NVARCHAR(100) NOT NULL,
    Descripcion NVARCHAR(255),
    FechaInicio DATE NOT NULL,
    FechaFin DATE NOT NULL,
    Presupuesto DECIMAL(10,2) NOT NULL
);

ALTER TABLE Descuentos
ADD ProductoID INT NULL,
    CampañaID INT NULL;

ALTER TABLE Descuentos
ADD CONSTRAINT FK_Descuentos_Productos
FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID);

ALTER TABLE Descuentos
ADD CONSTRAINT FK_Descuentos_CampañasPublicitarias
FOREIGN KEY (CampañaID) REFERENCES CampañasPublicitarias(CampañaID);
