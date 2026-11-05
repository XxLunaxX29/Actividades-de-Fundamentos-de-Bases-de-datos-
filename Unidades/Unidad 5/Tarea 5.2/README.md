# Unidad 5 - Tarea 5.2: Resolución de Consultas sobre el Esquema Relacional con Álgebra Formal y Validación en SQL Server

Este directorio contiene los entregables y recursos de la **Actividad 5.2 de la Unidad 5** de la materia **Fundamentos de Bases de Datos** (5to Semestre), impartida en el **Tecnológico Nacional de México (Campus Monclova)** por el docente Rubén Miguel Riojas Rodríguez y desarrollada por el alumno José Luis Luna García (Matrícula: I24050385).

---

## Alcance Metodológico y Técnico

Esta entrega constituye la fase de explotación y consulta formal sobre la base de datos normalizada (**3FN / FNBC**) del **Sistema de Gestión de Gimnasios** (`gimnasio_normalizado`). A través de **10 requerimientos de información de negocio**, se formaliza la resolución algorítmica de consultas mediante **Álgebra Relacional** y se valida su equivalencia física en **Transact-SQL (SQL Server Express)**:

### Catálogo de Consultas y Operadores Implementados:
1. **Consulta 1 (Personal con Salario &gt; $10,000):** Operadores unarios de selección ($\sigma$), proyección ($\pi$) y reunión theta ($\bowtie$) demostrando el beneficio de la selección temprana.
2. **Consulta 2 (Membresías de corta duración $\le$ 30 días):** Operadores unarios puros sobre tablas catálogo.
3. **Consulta 3 (Directorio telefónico por usuario):** Explotación del aislamiento de atributos multivalorados en 1FN mediante reunión natural.
4. **Consulta 4 (Clientes en rutinas de nivel 'Avanzado'):** Composición de múltiples joins cruzando la tabla asociativa puente 2FN (`ASIGNACION_RUTINA`) y filtrado con selección.
5. **Consulta 5 (Auditoría transaccional de cobros):** Aplicación crucial del operador formal de **renombramiento ($\rho$)** para resolver la autorreferencia donde dos claves foráneas (`ID_Cliente` e `ID_Empleado`) apuntan a la superclase `USUARIO`.
6. **Consulta 6 (Detección de casilleros libres/desocupados):** Operación de teoría de conjuntos de **diferencia de relaciones ($-$)** sobre la restricción `UNIQUE` que admite nulos en `LOCKER`.
7. **Consulta 7 (Auditoría de socios inactivos sin pagos):** Diferencia de conjuntos ($-$) entre el universo de clientes y clientes pagadores, vinculada a `USUARIO`.
8. **Consulta 8 (Desglose fiscal con IVA 16% y Subtotal):** Álgebra relacional extendida mediante **proyección generalizada ($\pi^*$)** para cálculos aritméticos al vuelo sin alterar el almacenamiento.
9. **Consulta 9 (Métricas analíticas de recaudación):** Álgebra relacional extendida mediante el **operador de agregación y agrupamiento ($\mathcal{G}$)** con `COUNT`, `SUM` y `AVG`.
10. **Consulta 10 (Socios que han completado todas las rutinas):** Operador binario avanzado de **División Relacional ($\div$)** para resolver consultas con cuantificador universal ($\forall$, consultas de tipo *"para todo"*).

---

## Contenido de la Carpeta

A continuación se detalla la función de cada archivo que integra esta entrega:

### 1. `Actividad 5.2 U_5 Fundamentos Base de datos.pdf`
Documento formal completo en formato PDF listo para entrega y evaluación académica. Incluye:
* **Portada institucional** con los datos de identificación académica del TecNM Campus Monclova.
* **Introducción teórica y propiedad de clausura:** Fundamentación del álgebra relacional como lenguaje formal de optimización en motores relacionales.
* **Esquema relacional base:** Especificación formal de las 10 tablas del gimnasio en 3FN/FNBC.
* **Catálogo técnico detallado de las 10 consultas:** Cada consulta incluye requerimiento en lenguaje natural, expresión matemática formal, desglose algorítmico paso a paso de tablas intermedias, script de validación en Transact-SQL y justificación relacional de optimización.
* **Matriz comparativa:** Resumen sinóptico de requerimientos, operadores algebraicos y cláusulas SQL equivalentes.
* **Conclusiones metodológicas.**

---

### 2. `Actividad 5.2.md`
Reporte íntegro en formato Markdown. Contiene la totalidad de la fundamentación matemática, el catálogo de las 10 consultas formales con sus tablas intermedias y la matriz comparativa de operadores y cláusulas.

---

### 3. `Datos Tablas.sql` *(Script de Poblado y Ajuste DDL)*
Script SQL estructurado para inicializar el entorno de pruebas en la base de datos `gimnasio_normalizado`:
* **Ajuste de índice filtrado:** Sustituye la restricción tradicional por un índice único filtrado (`UQ_Locker_Pago_Filtrado`) para optimizar el manejo de casilleros libres (`NULL`) en SQL Server.
* **Poblado controlado de datos (15 registros por tabla):** Inserción coherente de datos de prueba diseñados específicamente para validar los filtros de las 10 consultas (empleados con distintos salarios, miembros sin pagos, casilleros libres, y un socio que cumple con la totalidad del catálogo de rutinas para validar la división relacional).

---

### 4. `Consultas.sql` *(Script Completo de las 10 Consultas)*
Script ejecutable en Transact-SQL para SQL Server que contiene el catálogo completo de las 10 consultas formales documentadas, organizadas por bloques con mensajes explicativos (`PRINT`) para su verificación directa en el motor.

---

### 5. `Consultas Video.sql` *(Script Simplificado para Demostración)*
Extracto de consultas seleccionadas (`Consulta 4`, `Consulta 5` y `Consulta 10`) optimizado para la sustentación y ejecución demostrativa durante la grabación del video explicativo.

---

### 6. `Link Video YouTube.md`
Archivo de texto con el acceso directo a la sustentación y demostración en video de la actividad:
* **Enlace:** [Video Actividad 5.2 Fundamentos Base de datos](https://www.youtube.com/watch?v=c48_AoHOU_4)

---
