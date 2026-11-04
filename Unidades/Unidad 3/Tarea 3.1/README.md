# Unidad 3 - Tareas 3.1: Modelo Relacional y Transformación de EER a Esquema Físico (SQL)

Este directorio contiene los entregables y recursos de la **Actividad 3.1 de la Unidad 3** para la materia **Fundamentos de Bases de Datos** (5to Semestre), impartida en el **Tecnológico Nacional de México (Campus Monclova)** por el docente Rubén Miguel Riojas Rodríguez y desarrollada por el alumno José Luis Luna García (Matrícula: I24050385).

---

## Contenido y Alcance de la Entrega

Esta actividad se divide en dos fases formativas fundamentales que articulan la teoría formal con la práctica de ingeniería de bases de datos:

### Tarea 1: Componentes Formales del Modelo Relacional y Restricciones de Integridad
* **Fundamentos Teóricos:** Definición del modelo relacional introducido por E. F. Codd (1970).
* **Bloques de Construcción:** Relaciones (tablas), tuplas (filas), atributos (columnas), dominios (conjunto de valores atómicos homogéneos) y claves (Primary Keys y Foreign Keys).
* **Reglas de Integridad:** Integridad de entidad (`PRIMARY KEY`, `NOT NULL`), integridad referencial (`FOREIGN KEY`) e integridad de dominio (tipado, restricciones `CHECK` y valores nulos).
* **Propiedades ACID y Normalización:** Aseguramiento de consistencia transaccional y eliminación de redundancias.

---

### Tarea 2: Transformación Metodológica de EER a Esquema Relacional (Caso Gimnasio)
Transformación formal del modelo conceptual EER del **Centro Deportivo (Gimnasio)** hacia un esquema relacional lógico normalizado en **Tercera Forma Normal (3FN)** y su implementación en código **SQL DDL**:
1. **Aplanamiento de Atributos Compuestos (1FN):** `NOMBRE` de `USUARIO` se descompone en `Nombre_Pila`, `Apellido_Paterno` y `Apellido_Materno`.
2. **Herencia Disjunta (`d`):** Mapeo de la superclase `USUARIO` hacia `CLIENTE` y `EMPLEADO` propagando `ID_Usuario` simultáneamente como **PK y FK**, evitando llaves artificiales.
3. **Atributo Multivalorado:** Aislamiento de teléfonos en la tabla independiente `TELEFONO` con `ON DELETE CASCADE`.
4. **Agregación Transaccional (`CONTRATACIÓN VIGENTE`):** La relación ternaria `PAGO_MEMBRESIA` formaliza el cobro asociando cliente, empleado y membresía.
5. **Asignación Física de Casilleros (`LOCKER`):** Conexión 1:1 opcional vinculada directamente a `PAGO_MEMBRESIA` mediante clave foránea con restricción `UNIQUE` (admite `NULL` cuando el casillero está libre).
6. **Resolución N:M:** Creación de la tabla asociativa `ASIGNACION_RUTINA` con clave primaria compuesta `(ID_Cliente, ID_Rutina)` para el seguimiento de entrenamientos.
7. **Atributos Derivados:** La vigencia de suscripción no se persiste físicamente para evitar anomalías (se computa dinámicamente: `Fecha_Pago + Duracion_Dias`).

---

## Archivos Incluidos en la Carpeta

A continuación se detalla la descripción de cada uno de los archivos que integran esta entrega:

### 1. `Actividad 3..1 U_3 Fundamentos Base de datos.pdf`
Documento formal completo en formato PDF listo para entrega y evaluación académica. Incluye:
* **Portada institucional** y datos oficiales del alumno, materia y docente.
* **Desarrollo teórico de la Tarea 1:** Definición formal de tablas, tuplas, atributos, dominios, reglas de integridad y ejemplos prácticos de enlace entre tablas.
* **Desarrollo técnico de la Tarea 2:** Contexto operativo del gimnasio, pilares del modelo EER, 8 reglas formales de transformación a esquema relacional, definición formal de relaciones textuales y matriz comparativa de correspondencia directa.
* **Diagrama Relacional Gráfico:** Esquema en notación *crow's foot* (pata de gallo).
* **Script DDL SQL Estándar:** Código listo para desplegar las 10 tablas en motores relacionales (PostgreSQL, MySQL, SQL Server) con restricciones de integridad, `CHECK`, llaves foráneas y borrados en cascada.
* **Conclusiones y referencias bibliográficas.**

---

### 2. `Actividad 3.1.md`
Reporte íntegro en formato Markdown. Contiene la totalidad del texto teórico, la formulación matemática/textual de las relaciones, el script SQL estándar y el código Mermaid integrado tanto del modelo EER como del esquema relacional.

---

### 3. `Diagrama Relacional Tarea.mmd`
Archivo de código fuente en sintaxis **Mermaid (`erDiagram`)** que modela el esquema relacional lógico completo bajo notación *crow's foot*:
* Definición de las 10 entidades/tablas: `TIPO_USUARIO`, `USUARIO`, `TELEFONO`, `CLIENTE`, `EMPLEADO`, `MEMBRESIA`, `PAGO_MEMBRESIA`, `LOCKER`, `RUTINA` y `ASIGNACION_RUTINA`.
* Tipado explícito de atributos (`int`, `string`, `float`, `date`) y especificación de llaves `PK` y `FK`.
* Cardinalidades y relaciones directas (`||--o{`, `||--o|`, `|o--o|`).

---

### 4. `Link Video YouTube.md`
Archivo de texto con el acceso directo a la sustentación y explicación en video de la actividad:
* **Enlace:** [Video Actividad 3.1 Fundamentos Base de datos](https://www.youtube.com/watch?v=wyS3voYElIo&amp;t=100s)

---
