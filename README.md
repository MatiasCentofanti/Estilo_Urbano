# Estilo Urbano - Sistema de Gestión de Tienda

Este proyecto contiene la estructura de base de datos y scripts T-SQL para gestionar una tienda de ropa urbana, **Estilo Urbano**. Incluye tablas para productos, ventas, descuentos, campañas publicitarias, y más, junto con un diagrama ERD para visualizar las relaciones.

🧪 **Objetivo**
- Diseñar y gestionar una base de datos para una tienda de ropa urbana.
- Implementar scripts T-SQL para crear tablas, insertar datos, triggers, vistas y modificaciones.
- Visualizar la estructura de la base de datos mediante un diagrama ERD en PlantUML.

🧰 **Requisitos**
- SQL Server (2016 o superior recomendado)
- SQL Server Management Studio (SSMS)
- PlantUML o un servidor PlantUML online (como http://www.plantuml.com/plantuml/)
- Carpeta con permisos de escritura para scripts y diagramas (ej. `C:\Estilo_Urbano`)

📁 **Archivos**
- **/scripts**:
  - `update_descuentos.sql`: Script T-SQL para añadir `ProductoID` y `CampañaID` como claves foráneas a la tabla `Descuentos`.
  - Otros scripts para creación de tablas, inserciones, triggers y vistas.
- **/docs**:
  - `erd.puml`: Diagrama de Entidad-Relación en formato PlantUML.

🚀 **Cómo usar**
1. **Configurar el entorno**:
   - Clona el repositorio: `git clone https://github.com/MatiasCentofanti/Estilo_Urbano.git`
   - Abre SSMS y conecta con tu instancia de SQL Server.
2. **Ejecutar scripts T-SQL**:
   - Navega a la carpeta `scripts` y ejecuta los scripts en orden (creación de tablas primero, luego modificaciones como `update_descuentos.sql`).
   - Respalda la base de datos antes de aplicar modificaciones.
3. **Visualizar el ERD**:
   - Copia el contenido de `docs/erd.puml` en un servidor PlantUML (http://www.plantuml.com/plantuml/) para generar el diagrama.
   - O usa el enlace directo:  
     ![Diagrama ERD](http://www.plantuml.com/plantuml/proxy?cache=no&src=https://raw.githubusercontent.com/MatiasCentofanti/Estilo_Urbano/main/docs/erd.puml)
4. **Verificar cambios**:
   - Revisa la estructura de la tabla `Descuentos` tras ejecutar `update_descuentos.sql`:
     ```sql
     EXEC sp_help 'Descuentos';
     ```

📢 **Actualizaciones Recientes**
- **Tabla `Descuentos`**: Se añadieron las columnas `ProductoID` (FK a `Productos`) y `CampañaID` (FK a `CampañasPublicitarias`) para vincular descuentos a productos y campañas. Ver `scripts/update_descuentos.sql`.
- **Diagrama ERD**: Actualizado para reflejar las nuevas relaciones de `Descuentos`. Ver `docs/erd.puml`.

🤝 **Contribuir**
- Clona el repositorio y crea una rama: `git checkout -b nombre-rama`
- Añade tus cambios y envía un pull request.
- Reporta problemas o sugerencias en la sección de Issues.

📧 **Contacto**
Para consultas, contacta a [MatiasCentofanti](https://github.com/MatiasCentofanti).
