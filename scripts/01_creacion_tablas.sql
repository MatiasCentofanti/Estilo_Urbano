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
