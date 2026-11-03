-- ============================================================================
-- ARCHIVO: 03_queries_dml.sql
-- PROYECTO: Sistema de Gestión de Gimnasios (gimnasio_normalizado)
-- FASE: Consultas Analíticas (SELECT) y Operaciones de Mantenimiento
-- SGBD: Microsoft SQL Server / SQL Server Express (Transact-SQL)
-- ============================================================================
USE gimnasio_normalizado;
GO
-- Consulta 1: Filtro Condicional (WHERE) y Ordenamiento (ORDER BY)
-- Objetivo: Listar empleados cuyo salario supera $10,000 pesos ordenados descendentemente.
SELECT 
    U.Nombre_Pila, 
    U.Apellido_Paterno, 
    E.Puesto, 
    E.Salario
FROM dbo.EMPLEADO E
INNER JOIN dbo.USUARIO U ON E.ID_Empleado = U.ID_Usuario
WHERE E.Salario > 10000.00
ORDER BY E.Salario DESC;

-- Consulta 2: Reunión Interna Múltiple (INNER JOIN)
-- Objetivo: Listar clientes asignados a rutinas con dificultad 'Avanzado'.
SELECT 
    U.Nombre_Pila + ' ' + U.Apellido_Paterno AS Cliente,
    R.Nombre_Rutina,
    R.Nivel_Dificultad,
    AR.Fecha_Asignacion
FROM dbo.RUTINA R
INNER JOIN dbo.ASIGNACION_RUTINA AR ON R.ID_Rutina = AR.ID_Rutina
INNER JOIN dbo.USUARIO U ON AR.ID_Cliente = U.ID_Usuario
WHERE R.Nivel_Dificultad = 'Avanzado'
ORDER BY AR.Fecha_Asignacion ASC;

-- Consulta 3: Reunión Externa (LEFT JOIN) para Detección de Casos Nulos
-- Objetivo: Identificar el estado de todos los casilleros (lockers), indicando 'DISPONIBLE' si no están asignados.
SELECT 
    L.Numero_Locker,
    L.Ubicacion,
    ISNULL(CONVERT(VARCHAR, L.ID_Pago), 'SIN ASIGNAR') AS Folio_Pago,
    ISNULL(U.Nombre_Pila + ' ' + U.Apellido_Paterno, 'DISPONIBLE') AS Socio_Ocupante
FROM dbo.LOCKER L
LEFT JOIN dbo.PAGO_MEMBRESIA P ON L.ID_Pago = P.ID_Pago
LEFT JOIN dbo.USUARIO U ON P.ID_Cliente = U.ID_Usuario
ORDER BY L.Numero_Locker ASC;

-- Consulta 4: Agrupación (GROUP BY), Agregación (COUNT, SUM, AVG, MIN, MAX) y Filtro (HAVING)
-- Objetivo: Balance financiero por tipo de membresía con recaudación igual o superior a $1,000 pesos.
SELECT 
    M.Tipo_Membresia,
    COUNT(P.ID_Pago)                            AS Total_Ventas,
    SUM(P.Monto_Pagado)                         AS Recaudacion_Total,
    CAST(AVG(P.Monto_Pagado) AS DECIMAL(10,2))  AS Ticket_Promedio,
    MIN(P.Monto_Pagado)                         AS Monto_Minimo,
    MAX(P.Monto_Pagado)                         AS Monto_Maximo
FROM dbo.PAGO_MEMBRESIA P
INNER JOIN dbo.MEMBRESIA M ON P.ID_Membresia = M.ID_Membresia
GROUP BY M.Tipo_Membresia
HAVING SUM(P.Monto_Pagado) >= 1000.00
ORDER BY Recaudacion_Total DESC;

-- Mantenimiento 1: Actualización Exitosa (UPDATE)
PRINT '--- Prueba 1: UPDATE válido en MEMBRESIA ---';
UPDATE dbo.MEMBRESIA
SET Costo = Costo * 1.05
WHERE Tipo_Membresia = 'Mensual Básico';

SELECT ID_Membresia, Tipo_Membresia, Costo, Duracion_Dias 
FROM dbo.MEMBRESIA 
WHERE Tipo_Membresia = 'Mensual Básico';

-- Mantenimiento 2: Violación de Restricción CHECK en UPDATE
PRINT '--- Prueba 2: UPDATE rechazado por violación de CHECK (Salario &lt;= 0) ---';
BEGIN TRY
    UPDATE dbo.EMPLEADO
    SET Salario = -500.00
    WHERE ID_Empleado = 1;
END TRY
BEGIN CATCH
    PRINT 'ERROR CONTROLADO: El motor impidió la modificación por violación de CK_Empleado_Salario.';
    PRINT 'Mensaje Técnico: ' + ERROR_MESSAGE();
END CATCH;

-- Mantenimiento 3: Violación de Integridad Referencial en DELETE
PRINT '--- Prueba 3: DELETE rechazado por Llave Foránea Activa (FK_Pago_Membresia) ---';
BEGIN TRY
    DELETE FROM dbo.MEMBRESIA
    WHERE ID_Membresia = 3; -- Mensual Básico, referenciada en PAGO_MEMBRESIA
END TRY
BEGIN CATCH
    PRINT 'ERROR CONTROLADO: El motor bloqueó el DELETE para preservar la integridad de PAGO_MEMBRESIA.';
    PRINT 'Mensaje Técnico: ' + ERROR_MESSAGE();
END CATCH;

-- Mantenimiento 4: Eliminación con Propagación en Cascada (ON DELETE CASCADE)
PRINT '--- Prueba 4: Eliminación en cascada en TELEFONO ---';
INSERT INTO dbo.USUARIO (ID_TipoUsuario, Nombre_Pila, Apellido_Paterno, Apellido_Materno, CURP, Fecha_Nacimiento)
VALUES (2, 'Usuario', 'Temporal', 'Prueba', 'TEST000101HDFRRN99', '2000-01-01');

DECLARE @ID_Temp INT = SCOPE_IDENTITY();

INSERT INTO dbo.TELEFONO (ID_Usuario, Numero_Telefono) 
VALUES (@ID_Temp, '664-999-0000');

-- Eliminamos en la superclase USUARIO
DELETE FROM dbo.USUARIO WHERE ID_Usuario = @ID_Temp;

-- Verificamos que se eliminó automáticamente de TELEFONO
SELECT * FROM dbo.TELEFONO WHERE ID_Usuario = @ID_Temp;
IF @@ROWCOUNT = 0
    PRINT 'CONFIRMADO: La tupla en TELEFONO fue eliminada automáticamente por ON DELETE CASCADE.';
GO
