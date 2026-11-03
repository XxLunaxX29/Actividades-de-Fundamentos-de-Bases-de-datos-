# Sistema de Gestión de Gimnasios (`gimnasio_normalizado`)
**Materia:** Fundamentos de Bases de Datos  
**Maestro:** Rubén Miguel Riojas Rodriguez
**Motor SGBD:** Microsoft SQL Server / SQL Server Express (Transact-SQL)  
**Entorno de Ejecución:** SQL Server Management Studio (SSMS) / Azure Data Studio  
**Alumno:** José Luis Luna García
**Matricula:** I24050385
---

##Descripción del Proyecto
Este repositorio contiene la implementación física, poblado de datos representativos, consultas analíticas de manipulación y pruebas controladas de integridad referencial para el modelo de base de datos relacional de gestión de un gimnasio. El diseño se encuentra normalizado hasta la Tercera Forma Normal (3FN) y Forma Normal de Boyce-Codd (FNBC).

---

##Estructura del Repositorio
El repositorio organiza el ciclo de vida del script SQL en tres archivos secuenciales:

* **`01_schema_ddl.sql` (Fase LDD):**
  * Creación idempotente de la base de datos `gimnasio_normalizado`.
  * Definición de 10 tablas relacionales (`TIPO_USUARIO`, `USUARIO`, `TELEFONO`, `CLIENTE`, `EMPLEADO`, `MEMBRESIA`, `PAGO_MEMBRESIA`, `LOCKER`, `RUTINA`, `ASIGNACION_RUTINA`).
  * Asignación de claves primarias (`IDENTITY`), claves foráneas con reglas de acción referencial (`ON DELETE CASCADE`, `ON DELETE SET NULL`), restricciones de dominio (`CHECK`) e índice único filtrado para casilleros disponibles (`WHERE ID_Pago IS NOT NULL`).

* **`02_data_inserts.sql` (Fase LMD - Poblado):**
  * Inserción ordenada de registros representativos por tabla para garantizar la integridad referencial.
  * Inclusión de casos de prueba controlados: clientes activos, clientes inactivos (sin pagos registrados), casilleros asignados y casilleros libres (`NULL`).

* **`03_queries_dml.sql` (Fase LMD - Consultas y Mantenimiento):**
  * **Parte A (Consultas SELECT):** Implementación de filtros condicionales (`WHERE`), ordenamiento (`ORDER BY`), reuniones internas múltiples (`INNER JOIN`), reuniones externas (`LEFT JOIN`) y agregaciones agrupadas (`GROUP BY`, `HAVING`, `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`).
  * **Parte B (Mantenimiento):** Pruebas controladas con bloques `TRY/CATCH` que demuestran actualizaciones legítimas (`UPDATE`), rechazo de violaciones `CHECK`, bloqueo de borrado por llave foránea activa (`DELETE`) y propagación automática en cascada (`ON DELETE CASCADE`).

---

##Requisitos del Sistema
Para desplegar y verificar este proyecto se requiere:
* **SGBD:** Microsoft SQL Server 2019, 2022 o SQL Server Express.
* **Cliente de Gestión:** SQL Server Management Studio (SSMS v18 o superior) o Azure Data Studio.
* **Control de Versiones:** Git (cliente de consola o interfaz gráfica).

---

##Instrucciones de Clonación y Despliegue
### 1. Clonar el repositorio
Abre tu terminal o consola Git y ejecuta:
```bash
git clone [suspicious link removed]
cd Actividades-de-Fundamentos-de-Bases-de-datos-/Unidad 6/Tarea 6.2
```

###
