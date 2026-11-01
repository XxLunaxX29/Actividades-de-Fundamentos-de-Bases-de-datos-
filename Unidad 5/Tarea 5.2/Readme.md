[Actividad 5.2 U_5 Fundamentos Base de datos.md]

Materia: Fundamentos Bases de Datos Actividad U.5 – Tarea 5.2 Maestro: Rubén Miguel Riojas Rodríguez Semestre: 5to Semestre Alumno: José Luis Luna García Matricula: I24050385 

### Contenido 

| Contenido  |  |
| --- | ---: |
| [**Unidad 5 – Tarea 5.2**](#unidad-5--tarea-52) | [3](#unidad-5--tarea-52) |
| [Resolución de consultas sobre el esquema relacional con álgebra formal](#resolución-de-consultas-sobre-el-esquema-relacional-con-álgebra-formal) | [3](#resolución-de-consultas-sobre-el-esquema-relacional-con-álgebra-formal) |
| [Introducción y Marco Teórico de Álgebra Relacional](#introducción-y-marco-teórico-de-álgebra-relacional) | [3](#introducción-y-marco-teórico-de-álgebra-relacional) |
| [Esquema Relacional Base del Gimnasio (3FN / FNBC)](#esquema-relacional-base-del-gimnasio-3fn--fnbc) | [4](#esquema-relacional-base-del-gimnasio-3fn--fnbc) |
| [Catálogo Técnico de Consultas en Álgebra Relacional](#catálogo-técnico-de-consultas-en-álgebra-relacional) | [5](#catálogo-técnico-de-consultas-en-álgebra-relacional) |
| [Matriz Comparativa y Beneficios de Optimización](#matriz-comparativa-y-beneficios-de-optimización) | [15](#matriz-comparativa-y-beneficios-de-optimización) |
| [Conclusiones Metodológicas](#conclusiones-metodológicas) | [15](#conclusiones-metodológicas) |

# Unidad 5 – Tarea 5.2 

## Resolución de consultas sobre el esquema relacional con álgebra formal 

### Introducción y Marco Teórico de Álgebra Relacional 

El álgebra relacional constituye el lenguaje formal procedimental de consulta por excelencia en el modelo relacional de bases de datos. Fundamentado en la teoría matemática de conjuntos y en la lógica de predicados de primer orden, define un conjunto cerrado de operadores que reciben una o más relaciones como entrada y producen invariablemente una nueva relación como resultado. Esta característica, formalmente conocida como **propiedad de clausura**, permite anidar operadores de manera secuencial o en árboles de consulta algebraicos, sirviendo de fundamento directo para los módulos optimizadores de consultas de los motores transaccionales (RDBMS). 

El presente reporte técnico formaliza la formulación matemática y resolución algorítmica de diez requerimientos de información esenciales para el proyecto del **Sistema de Gestión de Gimnasios**. Cada problema incluye su especificación en lenguaje natural, su formulación matemática en álgebra relacional, el desglose procedimental de tablas intermedias resultantes (con esquemas proyectados) y su validación mediante código declarativo en Transact-SQL para Microsoft SQL Server. 

### Esquema Relacional Base del Gimnasio (3FN / FNBC) 

Las expresiones algebraicas presentadas en este catálogo operan sobre el esquema normalizado en Tercera Forma Normal (3FN) y Forma Normal de Boyce- Codd (FNBC) del gimnasio, estructurado en las siguientes relaciones formales: 

**TIPO\_USUARIO (**ID\_TipoUsuario \[PK\], Nombre\_Tipo) 

**USUARIO (**ID\_Usuario \[PK\], ID\_TipoUsuario \[FK\], Nombre\_Pila, Apellido\_Paterno, Apellido\_Materno, CURP, Fecha\_Nacimiento) 

**TELEFONO (**ID\_Usuario \[PK, FK\], Numero\_Telefono \[PK\]) 

**CLIENTE (**ID\_Cliente \[PK, FK: USUARIO\], Fecha\_Registro) 

**EMPLEADO (**ID\_Empleado \[PK, FK: USUARIO\], Puesto, Salario) 

**MEMBRESIA (**ID\_Membresia \[PK\], Tipo\_Membresia, Costo, Duracion\_Dias) 

**PAGO\_MEMBRESIA (**ID\_Pago \[PK\], ID\_Cliente \[FK\], ID\_Empleado \[FK\], ID\_Membresia \[FK\], Fecha\_Pago, Monto\_Pagado) 

**LOCKER (**ID\_Locker \[PK\], Numero\_Locker, Ubicacion, ID\_Pago \[FK: UNIQUE, NULLABLE\]) 

**RUTINA (**ID\_Rutina \[PK\], Nombre\_Rutina, Nivel\_Dificultad) 

**ASIGNACION\_RUTINA (**ID\_Cliente \[PK, FK\], ID\_Rutina \[PK, FK\], Fecha\_Asignacion) 

### Catálogo Técnico de Consultas en Álgebra Relacional 

#### Consulta 1: Filtrado de Personal Operativo con Salario Superior a la Media Base Tipo de Operación: Operadores Unarios (Selección σ y Proyección π) y Reunión Theta (⋈) 

**Requerimiento en Lenguaje Natural:** "Obtener el nombre de pila, apellido paterno y puesto de trabajo de todos los empleados del gimnasio que perciben un salario mensual superior a $10,000 pesos." 

**Expresión Formal en Álgebra Relacional: π\_(Nombre\_Pila, Apellido\_Paterno, Puesto) ( σ\_(Salario \> 10000) (EMPLEADO) ⋈\_(ID\_Empleado = ID\_Usuario) USUARIO )** 

**Desglose Algorítmico de Tablas Intermedias:** 

- **Paso 1 (Selección σ):** R1 ← σ\_(Salario \> 10000) (EMPLEADO) Filtra horizontalmente las filas de la tabla EMPLEADO cuya remuneración excede el umbral estipulado. Esquema resultante: R1(ID\_Empleado, Puesto, Salario). 
- **Paso 2 (Reunión Theta ⋈):** R2 ← R1 ⋈\_(ID\_Empleado = ID\_Usuario) USUARIO 

Combina el subconjunto de empleados filtrados con sus registros maestros en USUARIO a través de la clave primaria-foránea heredada. Esquema: R2(ID\_Empleado, Puesto, Salario, ID\_Usuario, ID\_TipoUsuario, Nombre\_Pila, Apellido\_Paterno, Apellido\_Materno, CURP, Fecha\_Nacimiento). 

- **Paso 3 (Proyección π):** Resultado ← π\_(Nombre\_Pila, Apellido\_Paterno, Puesto) (R2) Realiza un corte vertical descartando claves técnicas y datos personales irrelevantes para el reporte. Esquema final: Resultado(Nombre\_Pila, Apellido\_Paterno, Puesto). 

**Validación Declarativa en Transact-SQL (SQL Server):** 

SELECT U.Nombre\_Pila, U.Apellido\_Paterno, E.Puesto FROM EMPLEADO E 

JOIN USUARIO U ON E.ID\_Empleado = U.ID\_Usuario WHERE E.Salario \> 10000.00; 

**Justificación Relacional:** La selección temprana sobre EMPLEADO antes del join reduce significativamente el tamaño del conjunto de tuplas que ingresa a la memoria del motor, optimizando el costo computacional del cruce. 

#### Consulta 2: Catálogo Comercial de Membresías de Corta Duración Tipo de Operación: Operadores Unarios Puros (Selección σ y Proyección π) Requerimiento en Lenguaje Natural: "Generar la lista del tipo de membresía y su costo al público para aquellos planes cuyo periodo de vigencia sea menor o igual a 30 días." 

**Expresión Formal en Álgebra Relacional: π\_(Tipo\_Membresia, Costo) ( σ\_(Duracion\_Dias ≤ 30) (MEMBRESIA) )** 

**Desglose Algorítmico de Tablas Intermedias:** 

- **Paso 1 (Selección σ):** R1 ← σ\_(Duracion\_Dias ≤ 30) (MEMBRESIA) Evalúa la condición sobre el catálogo base de planes, aislando contratos mensuales, quincenales o promocionales. Esquema: R1(ID\_Membresia, Tipo\_Membresia, Costo, Duracion\_Dias). 
- **Paso 2 (Proyección π):** Resultado ← π\_(Tipo\_Membresia, Costo) (R1) Suprime la clave técnica primaria y el valor de duración, conservando exclusivamente la información para exhibición comercial. Esquema final: Resultado(Tipo\_Membresia, Costo). 

**Validación Declarativa en Transact-SQL (SQL Server):** 

SELECT Tipo\_Membresia, Costo FROM MEMBRESIA 

WHERE Duracion\_Dias \<= 30; 

**Justificación Relacional:** Demuestra la aplicación estricta de operadores unarios sobre una entidad catálogo, garantizando atomicidad y suprimiendo duplicados conforme a la definición teórica de Codd. 

#### Consulta 3: Directorio Integral de Contactos Telefónicos por Usuario Tipo de Operación: Reunión Natural y Manejo de Atributos Multivalorados 1FN Requerimiento en Lenguaje Natural: "Obtener el listado general de números telefónicos registrados en el sistema, vinculados directamente con el nombre completo y la clave CURP del usuario propietario." 

**Expresión Formal en Álgebra Relacional: π\_(Nombre\_Pila, Apellido\_Paterno, CURP, Numero\_Telefono) ( USUARIO ⋈\_(USUARIO.ID\_Usuario = TELEFONO.ID\_Usuario) TELEFONO )** 

**Desglose Algorítmico de Tablas Intermedias:** 

- **Paso 1 (Reunión ⋈):** R1 ← USUARIO ⋈\_(USUARIO.ID\_Usuario = 

| TELEFONO.ID\_Usuario)  |  | TELEFONO |
| --- | --- | --- |
| 1FN). |  |  |
| CURP,  | Numero\_Telefono)  | (R1) |

Proyecta las columnas de identificación personal junto con el número de contacto. Si un usuario posee 2 teléfonos, se generarán dos tuplas independientes. Esquema final: Resultado(Nombre\_Pila, Apellido\_Paterno, CURP, Numero\_Telefono). 

**Validación Declarativa en Transact-SQL (SQL Server):** 

SELECT U.Nombre\_Pila, U.Apellido\_Paterno, U.CURP, T.Numero\_Telefono FROM USUARIO U 

JOIN TELEFONO T ON U.ID\_Usuario = T.ID\_Usuario; 

**Justificación Relacional:** Valida la efectividad del aislamiento del grupo repetitivo en 1FN: permite asociar múltiples canales de contacto sin introducir celdas compuestas ni violar la primera forma normal. 

#### Consulta 4: Clientes Asignados a Rutinas de Entrenamiento de Nivel Avanzado Tipo de Operación: Composición de Múltiples Joins y Selección por Criterio Específico 

**Requerimiento en Lenguaje Natural:** "Consultar el nombre completo del cliente, la denominación de la rutina y la fecha en que le fue prescrita, únicamente para entrenamientos clasificados como 'Avanzado'." 

**Expresión Formal en Álgebra Relacional: π\_(Nombre\_Pila, Apellido\_Paterno, Nombre\_Rutina, Fecha\_Asignacion) ( σ\_(Nivel\_Dificultad = 'Avanzado') (RUTINA) ⋈ ASIGNACION\_RUTINA ⋈\_(ID\_Cliente = ID\_Usuario) USUARIO )** 

**Desglose Algorítmico de Tablas Intermedias:** 

- **Paso 1 (Selección σ):** R1 ← σ\_(Nivel\_Dificultad = 'Avanzado') (RUTINA) Filtra el catálogo de rutinas para seleccionar solo las de alta exigencia física. 
- **Paso 2 (Reunión ⋈ con ASIGNACION\_RUTINA):** R2 ← R1 ⋈\_(R1.ID\_Rutina = ASIGNACION\_RUTINA.ID\_Rutina) ASIGNACION\_RUTINA 

Vincula la rutina con la tabla intermedia asociativa 2FN. Esquema: 

| R2(ID\_Rutina, Nombre\_Rutina, Nivel\_Dificultad,  | ID\_Cliente,  |
| --- | --- |
| Fecha\_Asignacion). |  |
| USUARIO.ID\_Usuario)  | USUARIO |
| identidad del socio. |  |
| Nombre\_Rutina, Fecha\_Asignacion)  | (R3) |

Esquema final: Resultado(Nombre\_Pila, Apellido\_Paterno, Nombre\_Rutina, Fecha\_Asignacion). 

**Validación Declarativa en Transact-SQL (SQL Server):** 

SELECT U.Nombre\_Pila, U.Apellido\_Paterno, R.Nombre\_Rutina, AR.Fecha\_Asignacion FROM RUTINA R 

JOIN ASIGNACION\_RUTINA AR ON R.ID\_Rutina = AR.ID\_Rutina JOIN USUARIO U ON AR.ID\_Cliente = U.ID\_Usuario 

WHERE R.Nivel\_Dificultad = 'Avanzado'; 

**Justificación Relacional:** Demuestra la navegación a través de una tabla puente que resuelve la relación muchos a muchos (N:M) entre clientes y programas de entrenamiento con su atributo descriptivo propio (Fecha\_Asignacion). 

#### Consulta 5: Auditoría Transaccional de Cobros con Doble Rol de Usuario y Membresía Tipo de Operación: Operador de Renombramiento ρ y Multi-Join sobre Misma Relación 

**Requerimiento en Lenguaje Natural:** "Auditar las transacciones de pago generando un informe que detalle: folio de cobro, fecha, monto abonado, nombre del cliente que pagó, nombre del empleado de caja que procesó la transacción y el plan adquirido." 

**Expresión Formal en Álgebra Relacional: EMP ← ρ\_(EMP(ID\_E, Nom\_E, Ape\_E)) ( π\_(ID\_Usuario, Nombre\_Pila, Apellido\_Paterno) (USUARIO) )** 

**CLI ← ρ\_(CLI(ID\_C, Nom\_C, Ape\_C)) ( π\_(ID\_Usuario, Nombre\_Pila, Apellido\_Paterno) (USUARIO) )** 

**Resultado ← π\_(ID\_Pago, Fecha\_Pago, Monto\_Pagado, Nom\_C, Ape\_C, Nom\_E, Ape\_E, Tipo\_Membresia) ( PAGO\_MEMBRESIA ⋈\_(ID\_Cliente = ID\_C) CLI ⋈\_(ID\_Empleado = ID\_E) EMP ⋈ MEMBRESIA )** 

**Desglose Algorítmico de Tablas Intermedias:** 

- **Paso 1 (Renombramiento ρ de Empleado):** EMP ← ρ\_(EMP(ID\_E, Nom\_E, Ape\_E)) ( π\_(ID\_Usuario, Nombre\_Pila, Apellido\_Paterno) (USUARIO) ) Aísla las columnas de USUARIO y renombra atributos para representar la figura del cajero. 
- **Paso 2 (Renombramiento ρ de Cliente):** CLI ← ρ\_(CLI(ID\_C, Nom\_C, Ape\_C)) ( π\_(ID\_Usuario, Nombre\_Pila, Apellido\_Paterno) (USUARIO) ) Aísla y renombra atributos para representar al socio que desembolsa el pago. 
- **Paso 3 (Cruce Transaccional):** R1 ← PAGO\_MEMBRESIA ⋈\_(ID\_Cliente = ID\_C) CLI R2 ← R1 ⋈\_(ID\_Empleado = ID\_E) EMP R3 ← R2 ⋈\_(PAGO\_MEMBRESIA.ID\_Membresia = MEMBRESIA.ID\_Membresia) MEMBRESIA 
- **Paso 4 (Proyección):** Resultado ← π\_(ID\_Pago, Fecha\_Pago, Monto\_Pagado, Nom\_C, Ape\_C, Nom\_E, Ape\_E, Tipo\_Membresia) (R3) 

**Validación Declarativa en Transact-SQL (SQL Server):** 

SELECT P.ID\_Pago, P.Fecha\_Pago, P.Monto\_Pagado, UC.Nombre\_Pila AS Nom\_C, UC.Apellido\_Paterno AS Ape\_C, 

 UE.Nombre\_Pila AS Nom\_E, UE.Apellido\_Paterno AS Ape\_E, M.Tipo\_Membresia 

FROM PAGO\_MEMBRESIA P JOIN USUARIO UC ON P.ID\_Cliente = UC.ID\_Usuario 

JOIN USUARIO UE ON P.ID\_Empleado = UE.ID\_Usuario JOIN MEMBRESIA M ON P.ID\_Membresia = M.ID\_Membresia; 

**Justificación Relacional:** Ilustra el uso crucial del operador formal de renombramiento ρ para resolver la autoreferencia funcional donde dos claves foráneas de una misma tabla apuntan a la misma entidad superclase USUARIO. 

#### Consulta 6: Detección de Infraestructura Desocupada: Casilleros Disponibles Tipo de Operación: Operación de Teoría de Conjuntos: Diferencia de Relaciones (−) 

**Requerimiento en Lenguaje Natural:** "Identificar el número y ubicación de todos los casilleros (lockers) que se encuentran totalmente libres para ser asignados a nuevos miembros." 

**Expresión Formal en Álgebra Relacional: π\_(Numero\_Locker, Ubicacion) ( LOCKER − ( LOCKER ⋈\_(LOCKER.ID\_Pago = PAGO\_MEMBRESIA.ID\_Pago) π\_(ID\_Pago) (PAGO\_MEMBRESIA) ) )** 

**Desglose Algorítmico de Tablas Intermedias:** 

- **Paso 1 (Proyección de pagos):** R1 ← π\_(ID\_Pago) (PAGO\_MEMBRESIA) Obtiene el universo de claves de pago existentes. 
- **Paso 2 (Reunión de Lockers Ocupados):** R\_Ocupados ← LOCKER ⋈\_(LOCKER.ID\_Pago = R1.ID\_Pago) R1 Extrae las tuplas de casilleros que actualmente tienen una clave de suscripción asignada. 
- **Paso 3 (Diferencia de Conjuntos −):** R\_Libres ← LOCKER − R\_Ocupados Aplica la diferencia formal, suprimiendo del inventario total los casilleros ocupados. 
- **Paso 4 (Proyección π):** Resultado ← π\_(Numero\_Locker, Ubicacion) (R\_Libres) 

(Equivalente también a evaluar la condición unaria σ\_(ID\_Pago IS NULL)(LOCKER)). 

**Validación Declarativa en Transact-SQL (SQL Server):** 

SELECT Numero\_Locker, Ubicacion FROM LOCKER 

WHERE ID\_Pago IS NULL; 

**Justificación Relacional:** Demuestra la aplicación de la diferencia de conjuntos sobre entidades donde se implementó la restricción UNIQUE en 3FN/FNBC para evitar dependencias parasitarias. 

#### Consulta 7: Auditoría de Socios Inactivos: Clientes Registrados sin Contrato de Pago Tipo de Operación: Diferencia de Conjuntos (−) y Reunión con Tabla Maestra Requerimiento en Lenguaje Natural: "Listar el identificador, nombre de pila y apellido de aquellos clientes que fueron dados de alta en el sistema pero que nunca han procesado ningún pago de membresía." 

**Expresión Formal en Álgebra Relacional: ( π\_(ID\_Cliente) (CLIENTE) − π\_(ID\_Cliente) (PAGO\_MEMBRESIA) ) ⋈\_(ID\_Cliente = ID\_Usuario) USUARIO** 

**Desglose Algorítmico de Tablas Intermedias:** 

- **Paso 1 (Proyección de Clientes Registrados):** R1 ← π\_(ID\_Cliente) (CLIENTE) 

Conjunto de todos los identificadores de socios dados de alta. 

- **Paso 2 (Proyección de Clientes Pagadores):** R2 ← π\_(ID\_Cliente) (PAGO\_MEMBRESIA) 

Conjunto de clientes con al menos una tupla transaccional registrada. 

- **Paso 3 (Diferencia de Conjuntos):** R\_Inactivos ← R1 − R2 Conjunto de identificadores de socios que jamás han pagado. 
- **Paso 4 (Reunión con Datos Personales):** Resultado ← π\_(ID\_Cliente, Nombre\_Pila, Apellido\_Paterno) ( R\_Inactivos ⋈\_(ID\_Cliente = ID\_Usuario) USUARIO ) 

**Validación Declarativa en Transact-SQL (SQL Server):** 

SELECT C.ID\_Cliente, U.Nombre\_Pila, U.Apellido\_Paterno FROM CLIENTE C 

JOIN USUARIO U ON C.ID\_Cliente = U.ID\_Usuario WHERE C.ID\_Cliente NOT IN ( 

 SELECT ID\_Cliente FROM PAGO\_MEMBRESIA WHERE ID\_Cliente IS NOT NULL ); 

**Justificación Relacional:** Permite al área administrativa identificar usuarios 'prospecto' o inactivos que requieren campañas de reactivación comercial. 

#### Consulta 8: Desglose Fiscal de Ingresos mediante Proyección Generalizada Tipo de Operación: Álgebra Relacional Extendida: Proyección Generalizada (π\*) Requerimiento en Lenguaje Natural: "Generar una relación fiscal que calcule para cada pago: folio de transacción, monto cobrado, subtotal antes de impuestos y el desglose de IVA (16%)." 

**Expresión Formal en Álgebra Relacional: π\_(ID\_Pago, Monto\_Pagado, (Monto\_Pagado / 1.16) AS Subtotal, (Monto\_Pagado − (Monto\_Pagado / 1.16)) AS IVA\_16) ( PAGO\_MEMBRESIA )** 

**Desglose Algorítmico de Tablas Intermedias:** 

- **Paso 1 (Evaluación Aritmética Extendida):** Se aplica el operador π extendido permitiendo fórmulas de cálculo dinámico sobre los atributos base de PAGO\_MEMBRESIA. 
- **Paso 2 (Asignación de Esquema Derivado):** Resultado(ID\_Pago, Monto\_Pagado, Subtotal, IVA\_16) Cada tupla contiene valores procesados al vuelo sin alterar el almacenamiento físico. 

**Validación Declarativa en Transact-SQL (SQL Server):** 

SELECT ID\_Pago, Monto\_Pagado, 

 CAST(ROUND(Monto\_Pagado / 1.16, 2) AS DECIMAL(10,2)) AS Subtotal, CAST(ROUND(Monto\_Pagado - (Monto\_Pagado / 1.16), 2) AS DECIMAL(10,2)) AS IVA\_16 

FROM PAGO\_MEMBRESIA; 

**Justificación Relacional:** Aplica formalmente la extensión de Silberschatz et al. que supera la limitación clásica del álgebra relacional de solo proyectar columnas estáticas. 

#### Consulta 9: Resumen Financiero de Ventas mediante Agregación y Agrupamiento Tipo de Operación: Álgebra Relacional Extendida: Operador de Agregación (𝒢) Requerimiento en Lenguaje Natural: "Obtener para cada tipo de membresía ofertada: el total de contratos vendidos, la recaudación acumulada total y el promedio de ingreso por venta." 

**Expresión Formal en Álgebra Relacional: \_(Tipo\_Membresia) 𝒢\_(COUNT(ID\_Pago) AS Total\_Ventas, SUM(Monto\_Pagado) AS Recaudacion\_Total, AVG(Monto\_Pagado) AS Promedio\_Venta) (** 

**PAGO\_MEMBRESIA ⋈ MEMBRESIA )** 

**Desglose Algorítmico de Tablas Intermedias:** 

- **Paso 1 (Reunión Natural):** R1 ← PAGO\_MEMBRESIA ⋈\_(PAGO\_MEMBRESIA.ID\_Membresia = MEMBRESIA.ID\_Membresia) MEMBRESIA 

Asocia cada venta con el nombre descriptivo de su plan. 

- **Paso 2 (Particionamiento y Agrupamiento 𝒢):** Resultado ← \_(Tipo\_Membresia) 𝒢\_(COUNT(ID\_Pago), SUM(Monto\_Pagado), AVG(Monto\_Pagado)) (R1) Particiona las tuplas por el valor de Tipo\_Membresia y aplica las funciones matemáticas agregadas. Esquema: Resultado(Tipo\_Membresia, Total\_Ventas, Recaudacion\_Total, Promedio\_Venta). 

**Validación Declarativa en Transact-SQL (SQL Server):** 

SELECT M.Tipo\_Membresia, COUNT(P.ID\_Pago) AS Total\_Ventas, 

 SUM(P.Monto\_Pagado) AS Recaudacion\_Total, CAST(AVG(P.Monto\_Pagado) AS DECIMAL(10,2)) AS Promedio\_Venta FROM PAGO\_MEMBRESIA P 

JOIN MEMBRESIA M ON P.ID\_Membresia = M.ID\_Membresia GROUP BY M.Tipo\_Membresia; 

**Justificación Relacional:** Implementa la métrica analítica gerencial indispensable para la toma de decisiones financieras en la empresa. 

#### Consulta 10: Auditoría de Cumplimiento Total de Rutinas mediante División Relacional 

**Tipo de Operación:** Operador Binario Avanzado: División Relacional (÷) 

**Requerimiento en Lenguaje Natural:** "Identificar aquellos clientes dedicados que han tenido asignadas absolutamente TODAS las rutinas existentes en el catálogo del gimnasio (consultas de tipo 'para todo')." 

**Expresión Formal en Álgebra Relacional: ( π\_(ID\_Cliente, ID\_Rutina) (ASIGNACION\_RUTINA) ÷ π\_(ID\_Rutina) (RUTINA) ) ⋈\_(ID\_Cliente = ID\_Usuario) USUARIO** 

**Desglose Algorítmico de Tablas Intermedias:** 

- **Paso 1 (Proyección de pares asignados):** R1 ← π\_(ID\_Cliente, ID\_Rutina) (ASIGNACION\_RUTINA) 

Matriz de relaciones socio-rutina activas. 

- **Paso 2 (Proyección del universo divisor):** R2 ← π\_(ID\_Rutina) (RUTINA) Catálogo universal de rutinas ofertadas. 
- **Paso 3 (División Relacional Formal ÷):** R\_Completos ← R1 ÷ R2 Por definición: R\_Completos = π\_(ID\_Cliente)(R1) − π\_(ID\_Cliente)( (π\_(ID\_Cliente)(R1) × R2) − R1 ) Devuelve únicamente aquellos ID\_Cliente cuyas tuplas abarcan la totalidad de tuplas de R2. 
- **Paso 4 (Reunión con Datos Personales):** Resultado ← π\_(ID\_Cliente, Nombre\_Pila, Apellido\_Paterno) ( R\_Completos ⋈\_(ID\_Cliente = ID\_Usuario) USUARIO ) 

**Validación Declarativa en Transact-SQL (SQL Server):** 

SELECT U.Nombre\_Pila, U.Apellido\_Paterno FROM USUARIO U 

WHERE U.ID\_Usuario IN ( SELECT AR.ID\_Cliente 

 FROM ASIGNACION\_RUTINA AR GROUP BY AR.ID\_Cliente 

 HAVING COUNT(DISTINCT AR.ID\_Rutina) = (SELECT COUNT(\*) FROM RUTINA) ); 

**Justificación Relacional:** La división relacional formaliza de forma matemática exacta las consultas de lógica de predicados con cuantificador universal (∀), siendo uno de los operadores más potentes del modelo relacional de Codd. 

### Matriz Comparativa y Beneficios de Optimización 

A continuación se presenta la matriz sinóptica que correlaciona cada una de las consultas formuladas con los operadores algebraicos implementados y las cláusulas SQL correspondientes: 

| **Consulta**  | **Requerimiento de Negocio**  | **Operadores Algebraicos**  | **Cláusulas SQL**  |
| --- | --- | --- | --- |
| **C1**  | Empleados con Salario \> $10,000  | Selección σ, Proyección π, Join ⋈  | WHERE, JOIN, SELECT  |
| **C2**  | Membresías ≤ 30 Días  | Selección σ, Proyección π  | WHERE, SELECT  |
| **C3**  | Directorio Telefónico  | Reunión ⋈, Proyección π  | JOIN, SELECT  |
| **C4**  | Rutinas Nivel Avanzado  | Multi-Join ⋈, Selección σ  | JOIN múltiple, WHERE  |
| **C5**  | Auditoría de Pagos  | Renombramiento ρ, Multi-Join ⋈  | JOIN con alias de tabla AS  |
| **C6**  | Casilleros Disponibles  | Diferencia − (o Selección nulos)  | WHERE ID\_Pago IS NULL  |
| **C7**  | Clientes Inactivos sin Pagos  | Diferencia de conjuntos −  | NOT IN (Subconsulta)  |
| **C8**  | Desglose Fiscal (IVA y Subtotal)  | Proyección Generalizada π\*  | Operadores aritméticos en SELECT  |
| **C9**  | Métricas de Recaudación  | Agregación y Agrupamiento 𝒢  | GROUP BY, COUNT, SUM, AVG  |
| **C10**  | Socios con Todas las Rutinas  | División Relacional ÷  | GROUP BY ... HAVING COUNT(\*)  |

### Conclusiones Metodológicas 

**Independencia de la Implementación Física:** El álgebra relacional provee un modelo formal y matemático riguroso que permite expresar requerimientos lógicos sin atarse a las sintaxis o limitaciones de un motor particular. 

**Base del Optimizador de Consultas:** Los RDBMS comerciales (como SQL Server) traducen internamente cada sentencia SQL declarativa a un árbol de álgebra relacional. Conocer operadores como la selección temprana o el renombramiento permite escribir consultas más eficientes. 

**Completitud del Modelo:** El uso coordinado de operadores clásicos (unarios y binarios) y extendidos (𝒢, π\*, outer joins) garantiza que cualquier necesidad operativa, gerencial o fiscal en el gimnasio pueda ser satisfecha formalmente sin ambigüedades. 
