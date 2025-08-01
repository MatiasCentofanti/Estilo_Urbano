-- Crear roles
CREATE ROLE RolAdmin;
CREATE ROLE RolVendedor;
CREATE ROLE RolAuditor;

-- Asignar permisos
-- Admin: acceso total
GRANT SELECT, INSERT, UPDATE, DELETE ON Productos TO RolAdmin;
GRANT SELECT, INSERT, UPDATE, DELETE ON Ventas TO RolAdmin;

-- Vendedor: solo lectura de productos y escritura en ventas
GRANT SELECT ON Productos TO RolVendedor;
GRANT INSERT, SELECT ON Ventas TO RolVendedor;

-- Auditor: solo lectura
GRANT SELECT ON Productos TO RolAuditor;
GRANT SELECT ON Ventas TO RolAuditor;
