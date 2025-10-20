Proyecto de Base de Datos: E-commerce "Estilo Urbano"

Base de datos transaccional y analítica para un e-commerce, implementada en T-SQL (SQL Server). El proyecto se enfoca en la integridad de datos, automatización de reglas de negocio y análisis visual con Power BI.

Stack Tecnológico

Lenguaje: T-SQL
Gestor de BD: Microsoft SQL Server
Visualización: Power BI

Visualización del Proyecto

La arquitectura de la base de datos y el resultado del análisis de negocio se pueden ver a continuación.

Diagrama Entidad-Relación (ERD)
![Diagrama de Base de Datos Estilo Urbano](https://raw.githubusercontent.com/MatiasCentofanti/Estilo_Urbano/main/docs/erd.png)

Dashboard de Business Intelligence
Inserta aquí la captura de tu dashboard.

➡️ Ver Dashboard Interactivo en la Web Reemplaza esto con el enlace público que generaste desde Power BI.

Características Técnicas
Integridad de Datos: Uso de CONSTRAINTS (CHECK, UNIQUE) y claves primarias/foráneas para garantizar la consistencia de los datos.

Automatización con Triggers: Gestión de stock en tiempo real, reposición por devoluciones y auditoría de cambios en tablas críticas.

Lógica Encapsulada: Stored Procedures con manejo de transacciones y errores (TRY...CATCH) para ejecutar operaciones complejas de forma segura.

Seguridad: Implementación de Roles (Admin, Vendedor, Auditor) con permisos específicos para proteger los datos.

Eficiencia: Uso de Table-Valued Parameters (TVP) para procesar transacciones de múltiples artículos en una sola llamada.

Instalación y Prueba
Clona el repositorio.

Ejecuta los scripts SQL en orden numérico (de 01 a 07) en SQL Server para crear y poblar la base de datos.

(Opcional) Ejecuta 08_demostracion.sql para ver la lógica del sistema en acción.
