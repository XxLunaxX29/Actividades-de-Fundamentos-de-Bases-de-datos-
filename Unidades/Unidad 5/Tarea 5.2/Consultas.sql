
-- ============================================================================
-- SCRIPT DE VALIDACIÓN: CATÁLOGO DE 10 CONSULTAS FORMALES EN SQL SERVER
-- Proyecto: Sistema de Gestión de Gimnasios
-- Fuente: Actividad 5.2 - Resolución de consultas con álgebra formal
-- ============================================================================

USE gimnasio_normalizado;
GO

-- ============================================================================
-- CONSULTA 1: Filtrado de Personal Operativo con Salario &gt; $10,000
-- Tipo: Operadores Unarios (Selección σ y Proyección π) y Reunión Theta (⋈)
-- Expresión: π_(Nombre_Pila, Apellido_Paterno, Puesto) ( σ_(Salario &gt; 10000)(EMPLEADO) ⋈ USUARIO )
-- ============================================================================
PRINT '>>> CONSULTA 1: Empleados con Salario > $10,000';
SELECT 
    U.Nombre_Pila, 
    U.Apellido_Paterno, 
    E.Puesto
FROM EMPLEADO E
JOIN USUARIO U ON E.ID_Empleado = U.ID_Usuario
WHERE E.Salario > 10000.00;
GO

-- ============================================================================
-- CONSULTA 2: Catálogo Comercial de Membresías de Corta Duración (≤ 30 días)
-- Tipo: Operadores Unarios Puros (Selección σ y Proyección π)
-- Expresión: π_(Tipo_Membresia, Costo) ( σ_(Duracion_Dias ≤ 30)(MEMBRESIA) )
-- ============================================================================
PRINT '>>> CONSULTA 2: Membresías con duración menor o igual a 30 días';
SELECT 
    Tipo_Membresia, 
    Costo
FROM MEMBRESIA
WHERE Duracion_Dias <= 30;
GO

-- ============================================================================
-- CONSULTA 3: Directorio Integral de Contactos Telefónicos por Usuario
-- Tipo: Reunión Natural ⋈ y Manejo de Atributos Multivalorados (1FN)
-- Expresión: π_(Nombre_Pila, Apellido_Paterno, CURP, Numero_Telefono) ( USUARIO ⋈ TELEFONO )
-- ============================================================================
PRINT '>>> CONSULTA 3: Contactos telefónicos vinculados a usuarios (1FN)';
SELECT 
    U.Nombre_Pila, 
    U.Apellido_Paterno, 
    U.CURP, 
    T.Numero_Telefono
FROM USUARIO U
JOIN TELEFONO T ON U.ID_Usuario = T.ID_Usuario;
GO

-- ============================================================================
-- CONSULTA 4: Clientes Asignados a Rutinas de Nivel 'Avanzado'
-- Tipo: Composición de Múltiples Joins ⋈ y Selección por Criterio σ
-- Expresión: π_(Nombre_Pila, Apellido_Paterno, Nombre_Rutina, Fecha_Asignacion) 
--            ( σ_(Nivel_Dificultad = 'Avanzado')(RUTINA) ⋈ ASIGNACION_RUTINA ⋈ USUARIO )
-- ============================================================================
PRINT '>>> CONSULTA 4: Clientes con rutinas clasificadas como Avanzado';
SELECT 
    U.Nombre_Pila, 
    U.Apellido_Paterno, 
    R.Nombre_Rutina, 
    AR.Fecha_Asignacion
FROM RUTINA R
JOIN ASIGNACION_RUTINA AR ON R.ID_Rutina = AR.ID_Rutina
JOIN USUARIO U ON AR.ID_Cliente = U.ID_Usuario
WHERE R.Nivel_Dificultad = 'Avanzado';
GO

-- ============================================================================
-- CONSULTA 5: Auditoría Transaccional de Cobros con Doble Rol de Usuario
-- Tipo: Operador de Renombramiento ρ y Multi-Join sobre la Misma Relación
-- Expresión: π_(ID_Pago, Fecha_Pago, Monto_Pagado, Nom_C, Ape_C, Nom_E, Ape_E, Tipo_Membresia) 
--            ( PAGO_MEMBRESIA ⋈ CLI ⋈ EMP ⋈ MEMBRESIA )
-- ============================================================================
PRINT '>>> CONSULTA 5: Auditoría de pagos (Cliente, Empleado y Membresía)';
SELECT 
    P.ID_Pago, 
    P.Fecha_Pago, 
    P.Monto_Pagado,
    UC.Nombre_Pila AS Nom_C, 
    UC.Apellido_Paterno AS Ape_C,
    UE.Nombre_Pila AS Nom_E, 
    UE.Apellido_Paterno AS Ape_E,
    M.Tipo_Membresia
FROM PAGO_MEMBRESIA P
JOIN USUARIO UC ON P.ID_Cliente = UC.ID_Usuario
JOIN USUARIO UE ON P.ID_Empleado = UE.ID_Usuario
JOIN MEMBRESIA M ON P.ID_Membresia = M.ID_Membresia;
GO

-- ============================================================================
-- CONSULTA 6: Detección de Casilleros Disponibles / Desocupados
-- Tipo: Operación de Teoría de Conjuntos: Diferencia de Relaciones (−)
-- Expresión: π_(Numero_Locker, Ubicacion) ( LOCKER − (LOCKER ⋈ π_(ID_Pago)(PAGO_MEMBRESIA)) )
-- ============================================================================
PRINT '>>> CONSULTA 6: Casilleros totalmente libres para asignación';
SELECT 
    Numero_Locker, 
    Ubicacion
FROM LOCKER
WHERE ID_Pago IS NULL;
GO

-- ============================================================================
-- CONSULTA 7: Auditoría de Socios Inactivos: Clientes Registrados sin Pago
-- Tipo: Diferencia de Conjuntos (−) y Reunión con Tabla Maestra ⋈
-- Expresión: ( π_(ID_Cliente)(CLIENTE) − π_(ID_Cliente)(PAGO_MEMBRESIA) ) ⋈ USUARIO
-- ============================================================================
PRINT '>>> CONSULTA 7: Socios registrados que nunca han realizado un pago';
SELECT 
    C.ID_Cliente, 
    U.Nombre_Pila, 
    U.Apellido_Paterno
FROM CLIENTE C
JOIN USUARIO U ON C.ID_Cliente = U.ID_Usuario
WHERE C.ID_Cliente NOT IN (
    SELECT ID_Cliente 
    FROM PAGO_MEMBRESIA 
    WHERE ID_Cliente IS NOT NULL
);
GO

-- ============================================================================
-- CONSULTA 8: Desglose Fiscal de Ingresos (IVA y Subtotal)
-- Tipo: Álgebra Relacional Extendida: Proyección Generalizada (π*)
-- Expresión: π_(ID_Pago, Monto_Pagado, (Monto/1.16) AS Subtotal, (Monto - Monto/1.16) AS IVA_16)
-- ============================================================================
PRINT '>>> CONSULTA 8: Desglose fiscal de transacciones (Subtotal e IVA 16%)';
SELECT 
    ID_Pago,
    Monto_Pagado,
    CAST(ROUND(Monto_Pagado / 1.16, 2) AS DECIMAL(10,2)) AS Subtotal,
    CAST(ROUND(Monto_Pagado - (Monto_Pagado / 1.16), 2) AS DECIMAL(10,2)) AS IVA_16
FROM PAGO_MEMBRESIA;
GO

-- ============================================================================
-- CONSULTA 9: Resumen Financiero por Membresía
-- Tipo: Álgebra Relacional Extendida: Operador de Agregación y Agrupamiento (𝒢)
-- Expresión: _(Tipo_Membresia) 𝒢_(COUNT(ID_Pago), SUM(Monto_Pagado), AVG(Monto_Pagado))
-- ============================================================================
PRINT '>>> CONSULTA 9: Conteo, total recaudado y promedio por membresía';
SELECT 
    M.Tipo_Membresia,
    COUNT(P.ID_Pago) AS Total_Ventas,
    SUM(P.Monto_Pagado) AS Recaudacion_Total,
    CAST(AVG(P.Monto_Pagado) AS DECIMAL(10,2)) AS Promedio_Venta
FROM PAGO_MEMBRESIA P
JOIN MEMBRESIA M ON P.ID_Membresia = M.ID_Membresia
GROUP BY M.Tipo_Membresia;
GO

-- ============================================================================
-- CONSULTA 10: Auditoría Universal: Socios con TODAS las Rutinas
-- Tipo: Operador Binario Avanzado: División Relacional (÷)
-- Expresión: ( π_(ID_Cliente, ID_Rutina)(ASIGNACION_RUTINA) ÷ π_(ID_Rutina)(RUTINA) ) ⋈ USUARIO
-- ============================================================================
PRINT '>>> CONSULTA 10: Clientes que tienen asignadas todas las rutinas del catálogo';
SELECT 
    U.Nombre_Pila, 
    U.Apellido_Paterno
FROM USUARIO U
WHERE U.ID_Usuario IN (
    SELECT AR.ID_Cliente
    FROM ASIGNACION_RUTINA AR
    GROUP BY AR.ID_Cliente
    HAVING COUNT(DISTINCT AR.ID_Rutina) = (SELECT COUNT(*) FROM RUTINA)
);
GO
