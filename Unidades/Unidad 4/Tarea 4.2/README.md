# Unidad 4 - Tarea 4.2: Proceso Paso a Paso de Normalización del Proyecto (0FN a 3FN/FNBC) y Script DDL Corregido

Este directorio contiene los entregables y recursos de la **Actividad 4.2 de la Unidad 4** de la materia **Fundamentos de Bases de Datos** (5to Semestre), impartida en el **Tecnológico Nacional de México (Campus Monclova)** por el docente Rubén Miguel Riojas Rodríguez y desarrollada por el alumno José Luis Luna García (Matrícula: I24050385).

---

## Caso Práctico: Normalización del Sistema de Gestión de Gimnasios

Esta práctica documenta la reingeniería estructural y metodológica del sistema transaccional del gimnasio, partiendo de una **tabla monolítica universal (0FN)** con severas anomalías operativas hasta alcanzar un esquema relacional normalizado en **Tercera Forma Normal (3FN)** y **Forma Normal de Boyce-Codd (FNBC)**, garantizando la integridad de datos a nivel de motor en **Microsoft SQL Server Express**.

### Evolución Metodológica Paso a Paso:

1. **Estado Desnormalizado Inicial (0FN - `REGISTRO_CONTRATO_GIMNASIO_0FN`):**
   * Concentración de 16 atributos mezclando transacciones, catálogos y datos personales en una sola entidad.
   * **Patologías detectadas:** Nombres no atómicos, listas de teléfonos en una celda, anomalías de inserción (imposibilidad de registrar casilleros o membresías sin contratos activos), anomalías de actualización (redundancia de precios y salarios) y anomalías de borrado (pérdida de infraestructura física o catálogos al cancelar un pago).

2. **Transición a Primera Forma Normal (1FN):**
   * **Atomización de Atributos Compuestos:** Descomposición de `Nombre_Completo_Cliente` en `Nombre_Pila`, `Apellido_Paterno` y `Apellido_Materno` para permitir búsquedas e indexaciones eficientes.
   * **Aislamiento de Multivalorados:** Creación de la tabla subordinada `TELEFONO` con clave primaria compuesta `(ID_Usuario, Numero_Telefono)` vinculada mediante `ON DELETE CASCADE`.

3. **Transición a Segunda Forma Normal (2FN):**
   * **Erradicación de Dependencias Parciales:** Extracción de atributos descriptivos hacia tablas maestras independientes (`MEMBRESIA`, `EMPLEADO`, `LOCKER`).
   * **Dependencia Completa en Tablas Asociativas:** En `ASIGNACION_RUTINA` con clave compuesta `(ID_Cliente, ID_Rutina)`, se garantiza que únicamente `Fecha_Asignacion` dependa de la totalidad de la clave primaria.

4. **Transición a Tercera Forma Normal (3FN) y Validación de FNBC:**
   * **Supresión de Atributos Derivados:** Eliminación de la columna calculada `Vigencia_Fin` en `PAGO_MEMBRESIA`, computándola dinámicamente (`DATEADD`) para erradicar dependencias transitivas.
   * **Cumplimiento de FNBC en `LOCKER`:** Desacoplamiento de la clave foránea ubicando `ID_Pago` dentro de `LOCKER` con restricción `UNIQUE` y soporte de valores `NULL`, permitiendo casilleros libres y garantizando que todo determinante funcional sea clave candidata única.
   * **Especialización Limpia:** Herencia directa de `USUARIO` hacia `CLIENTE` y `EMPLEADO` compartiendo clave primaria y foránea simultánea.

---

## Contenido de la Carpeta

A continuación se detalla la función y el contenido de cada archivo que integra esta entrega:

### 1. `Actividad 4.2 U_4 Fundamentos Base de datos.pdf`
Documento formal completo en formato PDF listo para entrega y evaluación académica. Incluye:
* **Portada institucional** con datos académicos del TecNM Campus Monclova.
* **Introducción y planteamiento del problema:** Justificación del diseño en entornos transaccionales OLTP.
* **Diagnóstico exhaustivo de 0FN:** Análisis de la estructura monolítica, patologías de diseño y tabla ilustrativa de datos duplicados.
* **Desarrollo paso a paso (1FN, 2FN, 3FN y FNBC):** Reglas formales, justificación teórica y transformaciones estructurales.
* **Matriz comparativa de evolución:** Cuadro de patologías erradicadas y condiciones resultantes por fase.
* **Diagramas relacionales:** Comparativa gráfica del estado 0FN frente al modelo relacional final normalizado en 3FN/FNBC.
* **Script DDL SQL corregido y probado en SQL Server.**
* **Conclusiones y beneficios de integridad obtenidos.**

---

### 2. `Actividad 4.2.md`
Reporte íntegro en formato Markdown. Contiene el desarrollo textual completo de la práctica, las tablas de diagnóstico de anomalías, los bloques de diagramas de entidad-relación en sintaxis Mermaid (`erDiagram`) de 0FN y 3FN, así como el código DDL de creación de la base de datos.

---

### 3. `normalized squema.sql`
Script formal DDL optimizado y corregido para su ejecución en **Microsoft SQL Server Express**:
* Sentencias de inicialización: `CREATE DATABASE gimnasio_normalizado; GO USE gimnasio_normalizado; GO`.
* Creación secuencial de las **10 tablas normalizadas**: `TIPO_USUARIO`, `USUARIO`, `TELEFONO`, `CLIENTE`, `EMPLEADO`, `MEMBRESIA`, `PAGO_MEMBRESIA`, `LOCKER`, `RUTINA` y `ASIGNACION_RUTINA`.
* Integración completa de restricciones de integridad:
  * Llaves primarias (`PK`) e identidades autoincrementables (`IDENTITY(1,1)`).
  * Llaves foráneas (`FK`) con reglas de acción `ON DELETE CASCADE` y `ON DELETE SET NULL`.
  * Restricciones de unicidad (`UNIQUE`) en CURP, nombre de tipo de usuario, número de casillero y asignación de pago a casillero (`UQ_Locker_Pago`).
  * Restricciones de validación de dominio (`CHECK`) para salarios, costos y duraciones positivas.

---

### 4. `Link Video YouTube.md`
Archivo de texto con el acceso directo a la sustentación y explicación en video de la actividad:
* **Enlace:** [Video Actividad 4.2 Fundamentos Base de datos](https://www.youtube.com/watch?v=_U86XPmuCFs)

---
---
