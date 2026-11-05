# Unidad 6 - Tarea 6.1: Sintaxis y Clasificación de Sentencias SQL (DDL y DML)

Este directorio contiene los entregables y recursos de la **Actividad 6.1 de la Unidad 6** de la materia **Fundamentos de Bases de Datos** (5to Semestre), impartida en el **Tecnológico Nacional de México (Campus Monclova)** por el docente Rubén Miguel Riojas Rodríguez y desarrollada por el alumno José Luis Luna García (Matrícula: I24050385).

---

## Alcance Metodológico y Técnico del Lenguaje SQL

Esta entrega aborda la fundamentación arquitectónica, formal y taxonómica de **SQL (Structured Query Language)** como estándar internacional (ANSI/ISO) para la definición, manipulación y administración de sistemas gestores de bases de datos relacionales (RDBMS), contextualizado en el motor **Microsoft SQL Server** y aplicado sobre el proyecto **`gimnasio_normalizado`**:

### Pilares y Fundamentos del Lenguaje:
* **Naturaleza Declarativa:** El usuario define el *qué* (conjunto de resultados o mutación) mientras que el Optimizador de Consultas del motor determina el *cómo* (plan de ejecución óptimo mediante escaneos de índices B-Tree).
* **Propiedad de Clausura Relacional:** Toda sentencia toma como entrada una o más tablas y retorna invariablemente una nueva relación, habilitando la recursividad y anidamiento de subconsultas.
* **Independencia de Datos (ANSI/SPARC):** Separación estricta entre esquemas conceptuales y el almacenamiento físico.
* **Garantía Transaccional ACID:** Operaciones respaldadas por la bitácora activa de transacciones (*Transaction Log*).
* **Modularidad en Sublenguajes:** Diferenciación entre DDL (arquitectura de objetos) y DML (persistencia y consulta de tuplas).

---

### Taxonomía de Sentencias Analizadas (Sintaxis y Casos Prácticos):

1. **Lenguaje de Definición de Datos (DDL):**
   * **`CREATE TABLE`:** Creación de tablas, claves subrogadas (`IDENTITY(seed, increment)`), clave primaria con índice agrupado (*Clustered Index*), llaves foráneas con reglas de acción (`ON DELETE CASCADE / SET NULL`) y restricciones de dominio (`CHECK`).
   * **`ALTER TABLE`:** Modificación estructural en caliente (`ADD/DROP COLUMN`, `ADD/DROP CONSTRAINT` y cláusula `WITH NOCHECK` para optimización en tablas masivas).
   * **`DROP TABLE`:** Destrucción definitiva del objeto y liberación de páginas, implementando la cláusula de seguridad `IF EXISTS` y gestionando bloqueos por claves foráneas activas.
   * **`TRUNCATE TABLE`:** Operación de alto rendimiento mínimamente registrada en log que desasigna cadenas de páginas (*extents*), reinicia el contador `IDENTITY` y restringe el vaciado si existen llaves foráneas referenciándolo.

2. **Lenguaje de Manipulación de Datos (DML):**
   * **`INSERT`:** Inserción multi-fila, inserción por consulta (`INSERT INTO ... SELECT`), cláusula avanzada `OUTPUT inserted.*` y uso de `SET IDENTITY_INSERT`.
   * **`UPDATE`:** Mutación condicional con `WHERE`, actualización mediante cruces relacionales (`UPDATE ... FROM ... JOIN`) y auditoría simultánea mediante `OUTPUT deleted.*, inserted.*`.
   * **`DELETE`:** Eliminación fila por fila con logueo completo en Transaction Log para soporte de `ROLLBACK`, disparo de triggers (`AFTER/INSTEAD OF DELETE`) y preservación del contador consecutivo `IDENTITY`.
   * **`SELECT`:** Recuperación y proyección relacional. Se detalla el **orden lógico de procesamiento interno del motor**:
     $$\text{FROM / JOIN} \longrightarrow \text{WHERE} \longrightarrow \text{GROUP BY} \longrightarrow \text{HAVING} \longrightarrow \text{SELECT} \longrightarrow \text{DISTINCT} \longrightarrow \text{ORDER BY}$$

3. **Matriz Crítica de Eliminación de Datos (`DROP` vs. `TRUNCATE` vs. `DELETE`):**
   * Comparativa exhaustiva respecto a sublenguaje, preservación de metadatos, cláusula `WHERE`, reinicio de `IDENTITY`, sobrecarga en el Transaction Log, activación de triggers y compatibilidad con claves foráneas.

---

## Contenido de la Carpeta

A continuación se detalla la función de los archivos que integran esta entrega:

### 1. `Actividad 6.1 U_6 Fundamentos Base de datos.pdf`
Documento formal completo en formato PDF listo para entrega y evaluación académica. Incluye:
* **Portada institucional** con los datos oficiales del TecNM Campus Monclova, materia, docente y alumno.
* **Fundamentos del lenguaje SQL y principios arquitectónicos.**
* **Tabla comparativa y taxonómica de comandos SQL:** Ámbito funcional, nivel de acción, tipo de registro en Transaction Log y tipos de bloqueos concurrentes generados en SQL Server (bloqueos de esquema `Sch-M` vs. bloqueos de grano fino `X`, `IX`, `S`).
* **Sintaxis formal ANSI / T-SQL:** Parámetros, opciones avanzadas y ejemplos reales aplicados al esquema del gimnasio para cada sentencia DDL y DML.
* **Matriz crítica comparativa:** Análisis técnico diferencial entre `DROP`, `TRUNCATE` y `DELETE`.
* **Conclusiones metodológicas y referencias bibliográficas.**

---

### 2. `Actividad 6.1.md`
Reporte técnico completo en formato Markdown. Contiene la totalidad de la documentación teórica, las tablas taxonómicas, los bloques de sintaxis formal y los ejemplos de código SQL estructurados para su lectura en plataformas de control de versiones.

---

### 3. `Link Video YouTube.md`
Archivo de texto con el enlace directo a la sustentación y explicación en video de la actividad:
* **Enlace:** [Video Actividad 6.1 Fundamentos Base de datos](https://www.youtube.com/watch?v=4_SR_JOAGmM&amp;t=6s)

---
