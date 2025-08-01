-- Trigger de auditoría en Productos
CREATE TRIGGER trg_Auditoria_Productos
ON Productos
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        INSERT INTO AuditoriaCambios (TablaAfectada, Operacion, UsuarioSistema, RegistroAfectado)
        SELECT 'Productos', 'INSERT/UPDATE', SYSTEM_USER,
               CONCAT('ProductoID: ', ProductoID, ', Nombre: ', NombreProducto, ', Precio: ', Precio)
        FROM inserted;
    END

    IF EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO AuditoriaCambios (TablaAfectada, Operacion, UsuarioSistema, RegistroAfectado)
        SELECT 'Productos', 'DELETE', SYSTEM_USER,
               CONCAT('ProductoID: ', ProductoID, ', Nombre: ', NombreProducto, ', Precio: ', Precio)
        FROM deleted;
    END
END;

-- Tabla de auditoría
CREATE TABLE AuditoriaCambios (
    ID INT PRIMARY KEY IDENTITY(1,1),
    TablaAfectada VARCHAR(50),
    Operacion VARCHAR(10),
    FechaHora DATETIME DEFAULT GETDATE(),
    UsuarioSistema VARCHAR(100),
    RegistroAfectado VARCHAR(MAX)
);


