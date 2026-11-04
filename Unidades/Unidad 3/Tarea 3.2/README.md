# Actividad 3.2: Generación del Esquema Físico en SGBD, Diccionario de Datos y Script DDL (SQL)

Este directorio contiene los entregables y recursos de la **Actividad 3.2 de la Unidad 3** de la materia **Fundamentos de Bases de Datos** (5to Semestre), impartida en el **Tecnológico Nacional de México (Campus Monclova)** por el docente Rubén Miguel Riojas Rodríguez y desarrollada por el alumno José Luis Luna García (Matrícula: I24050385).

---

## Alcance Técnico del Esquema Físico

Esta entrega culmina el ciclo de diseño de bases de datos para el **Sistema de Gestión de Gimnasios**, implementando la arquitectura física relacional normalizada en **Tercera Forma Normal (3FN)** dentro de un Sistema Gestor de Bases de Datos (SGBD) relacional (SQL Server / ANSI SQL):

* **Superclase e Integridad de Herencia:** La tabla central `USUARIO` aplana el nombre compuesto a 1FN (`Nombre_Pila`, `Apellido_Paterno`, `Apellido_Materno`), mientras que `CLIENTE` y `EMPLEADO` reutilizan `ID_Usuario` simultáneamente como **Llave Primaria (PK)** y **Llave Foránea (FK)** sin identificadores artificiales redundantes.
* **Atributo Multivalorado:** Teléfonos aislados en `TELEFONO` con relación 1:N vinculada mediante `ON DELETE CASCADE`.
* **Transacción Central y Contratación Vigente:** La tabla `PAGO_MEMBRESIA` consolida la relación ternaria entre socio, empleado cobrador y el plan contratado (`MEMBRESIA`).
* **Asignación Física de Casilleros:** La tabla `LOCKER` enlaza el casillero con la transacción activa (`ID_Pago`) mediante una restricción `UNIQUE` (1:1 opcional), admitiendo valores `NULL` cuando el casillero está disponible y preservando el activo físico mediante `ON DELETE SET NULL`.
* **Desacoplamiento N:M de Entrenamientos:** La tabla puente `ASIGNACION_RUTINA` implementa una llave primaria compuesta `(ID_Cliente, ID_Rutina)` para el seguimiento histórico de rutinas.

---

## Contenido de la Carpeta

A continuación se detalla el propósito de cada uno de los archivos que integran este módulo:

### 1. `Actividad 3.2 U_3 Fundamentos Base de datos.pdf`
Documento formal completo en formato PDF listo para entrega y evaluación académica. Incluye:
* **Portada institucional** y datos de identificación académica.
* **Introducción y alcance del esquema físico relacional.**
* **Diagrama relacional gráfico en notación Crow's Foot (Patas de Gallo)** con sus 10 entidades y cardinalidades formales.
* **Diccionario de datos exhaustivo:** Especificación técnica detallada de las 10 tablas del sistema (`TIPO_USUARIO`, `USUARIO`, `TELEFONO`, `CLIENTE`, `EMPLEADO`, `MEMBRESIA`, `PAGO_MEMBRESIA`, `LOCKER`, `RUTINA` y `ASIGNACION_RUTINA`), describiendo columnas, tipos de datos físicos, nulabilidad, llaves (PK/FK/UQ), restricciones `CHECK`, valores por defecto y función operativa.
* **Script formal DDL en ANSI SQL estándar.**
* **Conclusiones y validación de reglas de integridad referencial.**

---

### 2. `Actividad 3.2.md`
Reporte íntegro en formato Markdown. Contiene el cuerpo teórico completo, el diagrama relacional implementado en sintaxis **Mermaid (`erDiagram`)**, el diccionario de datos tabulado y el script SQL de creación de tablas.

---

### 3. `Squema.sql`
Script formal de lenguaje de definición de datos (**DDL**) estructurado y probado para su ejecución en **Microsoft SQL Server Express**:
* Sentencias de creación y activación: `CREATE DATABASE GIMNASIO; GO USE GIMNASIO; GO`.
* Creación secuencial de las 10 tablas respetando el orden estricto de dependencias e integridad referencial.
* Definición de llaves primarias (`PK`), foráneas (`FK`), restricciones de unicidad (`UQ`), reglas de validación (`CHECK`) y acciones referenciales (`ON DELETE CASCADE` y `ON DELETE SET NULL`).

---

### 4. `Link Video YouTube.md`
Archivo de texto con el acceso directo a la sustentación y explicación en video de la actividad:
* **Enlace:** [Video Actividad 3.2 Fundamentos Base de datos](https://www.youtube.com/watch?v=adDSyO_VG1I&amp;t=37s)

---
