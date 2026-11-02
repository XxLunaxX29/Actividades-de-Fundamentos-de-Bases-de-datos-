-- ============================================================================
-- ARCHIVO: 02_data_inserts.sql
-- PROYECTO: Sistema de Gestión de Gimnasios (gimnasio_normalizado)
-- FASE: LMD (Poblado de Datos de Prueba / INSERTS)
-- SGBD: Microsoft SQL Server / SQL Server Express (Transact-SQL)
-- ============================================================================

USE gimnasio_normalizado;
GO

-- 1. Poblado de Tipos de Usuario
INSERT INTO dbo.TIPO_USUARIO (Nombre_Tipo) VALUES 
('Personal Staff / Administrativo'), -- ID: 1
('Socio / Cliente Activo');          -- ID: 2
GO

-- 2. Poblado de Usuarios (Superclase: 5 Empleados y 10 Clientes)
INSERT INTO dbo.USUARIO (ID_TipoUsuario, Nombre_Pila, Apellido_Paterno, Apellido_Materno, CURP, Fecha_Nacimiento)
VALUES 
-- Empleados (IDs 1 al 5)
(1, 'Carlos',   'Gomez',     'Ruiz',      'GORC850101HDFRRN01', '1985-01-01'), -- ID 1
(1, 'Ana',      'Martinez',  'Lopez',     'MALA900315MDFNPR02', '1990-03-15'), -- ID 2
(1, 'Daniel',   'Vega',      'Solis',     'VESD880722HDFGLN03', '1988-07-22'), -- ID 3
(1, 'Brenda',   'Rios',      'Navarro',   'RINB931105MDFVZZ04', '1993-11-05'), -- ID 4
(1, 'Eduardo',  'Mendoza',   'Castillo',  'MECE910214HDFXNN05', '1991-02-14'), -- ID 5
-- Clientes (IDs 6 al 15)
(2, 'Mario',    'Hernandez', 'Silva',     'HESM950512HDFRLR06', '1995-05-12'), -- ID 6
(2, 'Laura',    'Torres',    'Perez',     'TOPL980920MDFRRN07', '1998-09-20'), -- ID 7
(2, 'Roberto',  'Navarro',   'Castro',    'NACR921130HDFBNS08', '1992-11-30'), -- ID 8
(2, 'Sofia',    'Ramos',     'Mendez',    'RAMS010410MDFZXX09', '2001-04-10'), -- ID 9
(2, 'Alejandro','Pacheco',   'Vargas',    'PAVA960818HDFCCC10', '1996-08-18'), -- ID 10
(2, 'Fernanda', 'Morales',   'Duarte',    'MODF990625MDFKRR11', '1999-06-25'), -- ID 11
(2, 'Ricardo',  'Campos',    'Estrada',   'CAER941012HDFTYY12', '1994-10-12'), -- ID 12
(2, 'Valeria',  'Ibarra',    'Cordero',   'IBCV020303MDFLPP13', '2002-03-03'), -- ID 13
(2, 'Gabriel',  'Montes',    'Acosta',    'MOAG970119HDFQWW14', '1997-01-19'), -- ID 14
(2, 'Patricia', 'Delgado',   'Salas',     'DESP001208MDFMSS15', '2000-12-08'); -- ID 15
GO

-- 3. Poblado de Empleados (Subclase)
INSERT INTO dbo.EMPLEADO (ID_Empleado, Puesto, Salario) VALUES 
(1, 'Entrenador Personal Senior', 14500.00),
(2, 'Recepcionista Turno Matutino', 8500.00),
(3, 'Coordinador de Acondicionamiento', 13000.00),
(4, 'Nutrióloga y Asesora', 11500.00),
(5, 'Instructor de Pesas Turno Tarde', 9200.00);
GO

-- 4. Poblado de Clientes (Subclase: Incluye activos con pago e inactivos sin pago)
INSERT INTO dbo.CLIENTE (ID_Cliente, Fecha_Registro) VALUES 
(6,  '2026-01-10'),
(7,  '2026-02-15'), -- Sin pagos (Inactivo)
(8,  '2026-03-01'),
(9,  '2026-04-05'), -- Sin pagos (Inactivo)
(10, '2026-04-20'),
(11, '2026-05-12'),
(12, '2026-06-01'),
(13, '2026-07-15'), -- Sin pagos (Inactivo)
(14, '2026-08-22'),
(15, '2026-09-10');
GO

-- 5. Poblado de Teléfonos (Atributos multivalorados)
INSERT INTO dbo.TELEFONO (ID_Usuario, Numero_Telefono) VALUES 
(1,  '664-111-2233'),
(2,  '664-222-3344'),
(3,  '664-333-4455'),
(4,  '664-444-5566'),
(5,  '664-555-6677'),
(6,  '664-666-7788'),
(6,  '664-666-9900'), -- Mario con 2 teléfonos
(7,  '664-777-8899'),
(8,  '664-888-9900'),
(10, '664-101-2020'),
(11, '664-111-3030'),
(12, '664-121-4040'),
(12, '664-121-5050'), -- Ricardo con 2 teléfonos
(14, '664-141-6060'),
(15, '664-151-7070');
GO

-- 6. Poblado de Membresías
INSERT INTO dbo.MEMBRESIA (Tipo_Membresia, Costo, Duracion_Dias) VALUES 
('Pase por Día',               80.00,    1),
('Pase Quincenal Estudiantil', 250.00,  15),
('Mensual Básico',            450.00,   30),
('Trimestral Pro',           1200.00,   90),
('Anual VIP Premium',        4200.00,  365);
GO

-- 7. Poblado de Pagos de Membresía
INSERT INTO dbo.PAGO_MEMBRESIA (ID_Cliente, ID_Empleado, ID_Membresia, Fecha_Pago, Monto_Pagado)
VALUES 
(6,  2, 3, '2026-10-01 08:30:00', 450.00),  -- Pago 1
(8,  2, 4, '2026-10-02 09:15:00', 1200.00), -- Pago 2
(10, 2, 5, '2026-10-03 10:00:00', 4200.00), -- Pago 3
(11, 2, 3, '2026-10-04 11:20:00', 450.00),  -- Pago 4
(12, 2, 2, '2026-10-05 12:45:00', 250.00),  -- Pago 5
(14, 2, 1, '2026-10-06 14:00:00', 80.00),   -- Pago 6
(15, 2, 3, '2026-10-07 15:30:00', 450.00),  -- Pago 7
(6,  2, 5, '2026-10-08 16:10:00', 4200.00), -- Pago 8
(8,  2, 3, '2026-10-09 17:00:00', 450.00),  -- Pago 9
(10, 2, 3, '2026-10-10 18:25:00', 450.00),  -- Pago 10
(11, 2, 4, '2026-10-11 19:00:00', 1200.00), -- Pago 11
(12, 2, 3, '2026-10-12 09:40:00', 450.00),  -- Pago 12
(14, 2, 3, '2026-10-13 10:50:00', 450.00),  -- Pago 13
(15, 2, 4, '2026-10-14 11:15:00', 1200.00), -- Pago 14
(6,  2, 4, '2026-10-15 13:00:00', 1200.00); -- Pago 15
GO

-- 8. Poblado de Lockers (10 asignados y 5 disponibles con NULL para pruebas de LEFT JOIN)
INSERT INTO dbo.LOCKER (Numero_Locker, Ubicacion, ID_Pago) VALUES 
(101, 'Pasillo A - Vestidor Hombres', 1),
(102, 'Pasillo A - Vestidor Hombres', 2),
(103, 'Pasillo A - Vestidor Hombres', 3),
(104, 'Pasillo A - Vestidor Hombres', 4),
(105, 'Pasillo A - Vestidor Hombres', 5),
(106, 'Pasillo A - Vestidor Hombres', 6),
(107, 'Pasillo A - Vestidor Hombres', 7),
(108, 'Pasillo A - Vestidor Hombres', 8),
(109, 'Pasillo A - Vestidor Hombres', 9),
(110, 'Pasillo A - Vestidor Hombres', 10),
(111, 'Pasillo B - Vestidor Mujeres', NULL),
(112, 'Pasillo B - Vestidor Mujeres', NULL),
(113, 'Pasillo B - Vestidor Mujeres', NULL),
(114, 'Pasillo B - Vestidor Mujeres', NULL),
(115, 'Pasillo B - Vestidor Mujeres', NULL);
GO

-- 9. Poblado de Catálogo de Rutinas
SET IDENTITY_INSERT dbo.RUTINA ON;
GO

INSERT INTO dbo.RUTINA (ID_Rutina, Nombre_Rutina, Nivel_Dificultad) VALUES 
(1,  'Acondicionamiento Físico General',    'Principiante'),
(2,  'Hipertrofia Empuje / Tirón / Pierna',  'Avanzado'),
(3,  'Resistencia y Circuito Funcional',     'Intermedio'),
(4,  'Fuerza Máxima Powerlifting',          'Avanzado'),
(5,  'Cardio HIIT y Quema de Grasa',        'Principiante'),
(6,  'Cross-Training de Alto Rendimiento',  'Avanzado'),
(7,  'Movilidad y Flexibilidad Articular',  'Principiante'),
(8,  'Tonificación y Definición Muscular',  'Intermedio'),
(9,  'Glúteo y Pierna con Sobrecarga',      'Intermedio'),
(10, 'Calistenia y Control Corporal',       'Avanzado'),
(11, 'Recuperación y Descarga Muscular',    'Principiante'),
(12, 'Preparación para Carrera 10K',        'Intermedio'),
(13, 'Espalda y Hombro en Máquinas',        'Intermedio'),
(14, 'Brazo y Core Intensivo',              'Intermedio'),
(15, 'Entrenamiento Funcional Adulto Mayor','Principiante');
GO

SET IDENTITY_INSERT dbo.RUTINA OFF;
GO

-- 10. Poblado de Asignación de Rutinas (Mario asignado a todas para pruebas de división)
INSERT INTO dbo.ASIGNACION_RUTINA (ID_Cliente, ID_Rutina, Fecha_Asignacion) VALUES 
(6, 1,  '2026-10-01'),
(6, 2,  '2026-10-02'),
(6, 3,  '2026-10-03'),
(6, 4,  '2026-10-04'),
(6, 5,  '2026-10-05'),
(6, 6,  '2026-10-06'),
(6, 7,  '2026-10-07'),
(6, 8,  '2026-10-08'),
(6, 9,  '2026-10-09'),
(6, 10, '2026-10-10'),
(6, 11, '2026-10-11'),
(6, 12, '2026-10-12'),
(6, 13, '2026-10-13'),
(6, 14, '2026-10-14'),
(6, 15, '2026-10-15'),
(8,  2,  '2026-10-03'),
(10, 4,  '2026-10-05'),
(11, 1,  '2026-10-07'),
(12, 3,  '2026-10-09'),
(14, 5,  '2026-10-11');
GO
