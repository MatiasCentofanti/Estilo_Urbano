/********************************************************************************************
* PROYECTO: Base de Datos para E-commerce "Estilo Urbano"
* SCRIPT: 07 - Creación de Roles y Asignación de Permisos
* AUTOR: Matias Centofanti
* FECHA: 20/10/2025
* DESCRIPCIÓN:
* Este script establece la capa de seguridad de la base de datos. Se crean roles
* específicos para diferentes funciones del negocio y se les asignan únicamente los
* permisos necesarios para realizar su trabajo, siguiendo el principio de mínimo privilegio.
********************************************************************************************/

-- =========================================================================================
-- SECCIÓN 1: CREACIÓN DE ROLES DE BASE DE DATOS
-- Propósito: Definir grupos lógicos de usuarios según su función en la empresa.
-- =========================================================================================

CREATE ROLE RolAdmin;       -- Para administración total de la base de datos.
CREATE ROLE RolVendedor;    -- Para usuarios que registran ventas y consultan productos/clientes.
CREATE ROLE RolAuditor;     -- Para usuarios que necesitan acceso de solo lectura para análisis.
GO

-- =========================================================================================
-- SECCIÓN 2: ASIGNACIÓN DE PERMISOS POR ROL
-- Propósito: Otorgar los permisos específicos a cada rol.
-- =========================================================================================

-- -----------------------------------------------------------------------------------------
-- PERMISOS PARA ROLVENDEDOR
-- Un vendedor puede consultar productos y clientes, pero solo puede modificar datos
-- a través de los Stored Procedures, lo que garantiza que se cumplan las reglas de negocio.
-- -----------------------------------------------------------------------------------------
PRINT 'Asignando permisos a RolVendedor...';
-- Permisos de consulta
GRANT SELECT ON dbo.Productos TO RolVendedor;
GRANT SELECT ON dbo.Clientes TO RolVendedor;
GRANT SELECT ON dbo.Categorias TO RolVendedor;

-- Permisos de ejecución sobre los procedimientos que necesita para trabajar
GRANT EXECUTE ON dbo.sp_RegistrarVentaSimple TO RolVendedor;
GRANT EXECUTE ON dbo.sp_RegistrarVentaCompleta TO RolVendedor;
GRANT EXECUTE ON dbo.sp_BuscarProducto TO RolVendedor;
GO

-- -----------------------------------------------------------------------------------------
-- PERMISOS PARA ROLAUDITOR
-- Un auditor tiene acceso de SOLO LECTURA a las vistas de resumen y a las tablas
-- de seguimiento, pero no puede modificar ningún dato.
-- -----------------------------------------------------------------------------------------
PRINT 'Asignando permisos a RolAuditor...';
-- Permisos de lectura sobre las vistas analíticas
GRANT SELECT ON dbo.vw_VentasCompleto TO RolAuditor;
GRANT SELECT ON dbo.vw_RendimientoProductos TO RolAuditor;
GRANT SELECT ON dbo.vw_ClientesResumen TO RolAuditor;
GRANT SELECT ON dbo.vw_Inventario TO RolAuditor;

-- Permiso para ver los registros de auditoría
GRANT SELECT ON dbo.AuditoriaCambios TO RolAuditor;
GO

-- -----------------------------------------------------------------------------------------
-- PERMISOS PARA ROLADMIN
-- Un administrador tiene control total sobre todos los objetos del esquema 'dbo'.
-- Esto le permite crear, modificar y eliminar tablas, vistas, procedimientos, etc.
-- -----------------------------------------------------------------------------------------
PRINT 'Asignando permisos a RolAdmin...';
GRANT CONTROL ON SCHEMA::dbo TO RolAdmin;
GO


-- =========================================================================================
-- SECCIÓN 3: EJEMPLO DE USO - CÓMO ASIGNAR UN USUARIO A UN ROL
-- Propósito: Demostrar el proceso completo para crear un nuevo inicio de sesión,
-- mapearlo a un usuario en la base de datos y añadirlo a uno de los roles creados.
-- (Estos comandos están comentados para no ejecutarse automáticamente).
-- =========================================================================================
/*

-- Paso 1: Crear un Login a nivel de servidor (si no existe)
CREATE LOGIN [laura_vendedora] WITH PASSWORD = 'UnaContraseñaSegura123!';

-- Paso 2: Crear un Usuario en la base de datos a partir de ese Login
CREATE USER [laura_vendedora] FOR LOGIN [laura_vendedora];

-- Paso 3: Añadir el usuario al rol deseado. Ahora Laura tendrá todos los permisos de RolVendedor.
ALTER ROLE RolVendedor ADD MEMBER [laura_vendedora];

*/

PRINT 'Proceso de creación de roles y permisos finalizado con éxito.';
GO
/********************************************************************************************
* FIN DEL SCRIPT 07
********************************************************************************************/
