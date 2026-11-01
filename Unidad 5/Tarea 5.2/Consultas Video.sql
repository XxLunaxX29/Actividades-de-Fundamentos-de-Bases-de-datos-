USE gimnasio_normalizado;
GO
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
