-- ============================================================================
-- SCRIPT DDL DEFINITIVO PARA SQL SERVER EXPRESS (3FN / FNBC)
-- Fuente: Actividad 4.2 - Proceso paso a paso de normalización del proyecto
-- Proyecto: Sistema de Gestión de Gimnasios
-- ============================================================================
CREATE DATABASE gimnasio_normalizado;
GO

USE gimnasio_normalizado;
GO
-- ============================================================================
-- 1. TABLA CATÁLOGO: TIPO_USUARIO
-- ============================================================================
CREATE TABLE dbo.TIPO_USUARIO (
    ID_TipoUsuario INT IDENTITY(1,1),
    Nombre_Tipo    VARCHAR(50) NOT NULL,
    CONSTRAINT PK_TipoUsuario PRIMARY KEY (ID_TipoUsuario),
    CONSTRAINT UQ_TipoUsuario_Nombre UNIQUE (Nombre_Tipo)
);
GO

-- ============================================================================
-- 2. TABLA SUPERCLASE: USUARIO (1FN: Atributos estrictamente atómicos)
-- ============================================================================
CREATE TABLE dbo.USUARIO (
    ID_Usuario       INT IDENTITY(1,1),
    ID_TipoUsuario   INT NOT NULL,
    Nombre_Pila      VARCHAR(50) NOT NULL,
    Apellido_Paterno VARCHAR(50) NOT NULL,
    Apellido_Materno VARCHAR(50) NULL,
    CURP             CHAR(18) NOT NULL,
    Fecha_Nacimiento DATE NOT NULL,
    CONSTRAINT PK_Usuario PRIMARY KEY (ID_Usuario),
    CONSTRAINT UQ_Usuario_CURP UNIQUE (CURP),
    CONSTRAINT FK_Usuario_TipoUsuario FOREIGN KEY (ID_TipoUsuario)
        REFERENCES dbo.TIPO_USUARIO(ID_TipoUsuario)
);
GO

-- ============================================================================
-- 3. TABLA SUBORDINADA: TELEFONO (1FN: Aislamiento de atributos multivalorados)
-- ============================================================================
CREATE TABLE dbo.TELEFONO (
    ID_Usuario      INT NOT NULL,
    Numero_Telefono VARCHAR(15) NOT NULL,
    CONSTRAINT PK_Telefono PRIMARY KEY (ID_Usuario, Numero_Telefono),
    CONSTRAINT FK_Telefono_Usuario FOREIGN KEY (ID_Usuario)
        REFERENCES dbo.USUARIO(ID_Usuario) ON DELETE CASCADE
);
GO

-- ============================================================================
-- 4. TABLA SUBCLASE: CLIENTE (Herencia de clave primaria/foránea)
-- ============================================================================
CREATE TABLE dbo.CLIENTE (
    ID_Cliente     INT NOT NULL,
    Fecha_Registro DATE NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_Cliente PRIMARY KEY (ID_Cliente),
    CONSTRAINT FK_Cliente_Usuario FOREIGN KEY (ID_Cliente)
        REFERENCES dbo.USUARIO(ID_Usuario) ON DELETE CASCADE
);
GO

-- ============================================================================
-- 5. TABLA SUBCLASE: EMPLEADO (Herencia y restricción CHECK de dominio)
-- ============================================================================
CREATE TABLE dbo.EMPLEADO (
    ID_Empleado INT NOT NULL,
    Puesto      VARCHAR(50) NOT NULL,
    Salario     DECIMAL(10,2) NOT NULL,
    CONSTRAINT PK_Empleado PRIMARY KEY (ID_Empleado),
    CONSTRAINT CK_Empleado_Salario CHECK (Salario > 0),
    CONSTRAINT FK_Empleado_Usuario FOREIGN KEY (ID_Empleado)
        REFERENCES dbo.USUARIO(ID_Usuario) ON DELETE CASCADE
);
GO

-- ============================================================================
-- 6. TABLA MAESTRA: MEMBRESIA (Catálogo de planes independientes)
-- ============================================================================
CREATE TABLE dbo.MEMBRESIA (
    ID_Membresia   INT IDENTITY(1,1),
    Tipo_Membresia VARCHAR(50) NOT NULL,
    Costo          DECIMAL(10,2) NOT NULL,
    Duracion_Dias  INT NOT NULL,
    CONSTRAINT PK_Membresia PRIMARY KEY (ID_Membresia),
    CONSTRAINT CK_Membresia_Costo CHECK (Costo >= 0),
    CONSTRAINT CK_Membresia_Dias CHECK (Duracion_Dias > 0)
);
GO

-- ============================================================================
-- 7. TABLA TRANSACCIONAL: PAGO_MEMBRESIA (3FN: Sin vigencia física calculada)
-- ============================================================================
CREATE TABLE dbo.PAGO_MEMBRESIA (
    ID_Pago      INT IDENTITY(1,1),
    ID_Cliente   INT NOT NULL,
    ID_Empleado  INT NOT NULL,
    ID_Membresia INT NOT NULL,
    Fecha_Pago   DATETIME NOT NULL DEFAULT GETDATE(),
    Monto_Pagado DECIMAL(10,2) NOT NULL,
    CONSTRAINT PK_PagoMembresia PRIMARY KEY (ID_Pago),
    CONSTRAINT CK_Pago_Monto CHECK (Monto_Pagado >= 0),
    CONSTRAINT FK_Pago_Cliente FOREIGN KEY (ID_Cliente)
        REFERENCES dbo.CLIENTE(ID_Cliente),
    CONSTRAINT FK_Pago_Empleado FOREIGN KEY (ID_Empleado)
        REFERENCES dbo.EMPLEADO(ID_Empleado),
    CONSTRAINT FK_Pago_Membresia FOREIGN KEY (ID_Membresia)
        REFERENCES dbo.MEMBRESIA(ID_Membresia)
);
GO

-- ============================================================================
-- 8. TABLA MAESTRA: LOCKER (3FN/FNBC: Asignación 1 a 0..1 con FK UNIQUE)
-- ============================================================================
CREATE TABLE dbo.LOCKER (
    ID_Locker     INT IDENTITY(1,1),
    Numero_Locker INT NOT NULL,
    Ubicacion     VARCHAR(50) NOT NULL,
    ID_Pago       INT NULL, -- NULL representa casillero desocupado
    CONSTRAINT PK_Locker PRIMARY KEY (ID_Locker),
    CONSTRAINT UQ_Locker_Numero UNIQUE (Numero_Locker),
    CONSTRAINT UQ_Locker_Pago UNIQUE (ID_Pago), -- Garantiza FNBC (un casillero por pago)
    CONSTRAINT FK_Locker_Pago FOREIGN KEY (ID_Pago)
        REFERENCES dbo.PAGO_MEMBRESIA(ID_Pago) ON DELETE SET NULL
);
GO

-- ============================================================================
-- 9. TABLA MAESTRA: RUTINA (Catálogo independiente)
-- ============================================================================
CREATE TABLE dbo.RUTINA (
    ID_Rutina        INT IDENTITY(1,1),
    Nombre_Rutina    VARCHAR(100) NOT NULL,
    Nivel_Dificultad VARCHAR(20) NOT NULL,
    CONSTRAINT PK_Rutina PRIMARY KEY (ID_Rutina)
);
GO

-- ============================================================================
-- 10. TABLA ASOCIATIVA: ASIGNACION_RUTINA (2FN: Dependencia funcional completa)
-- ============================================================================
CREATE TABLE dbo.ASIGNACION_RUTINA (
    ID_Cliente       INT NOT NULL,
    ID_Rutina        INT NOT NULL,
    Fecha_Asignacion DATE NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_AsignacionRutina PRIMARY KEY (ID_Cliente, ID_Rutina),
    CONSTRAINT FK_Asignacion_Cliente FOREIGN KEY (ID_Cliente)
        REFERENCES dbo.CLIENTE(ID_Cliente) ON DELETE CASCADE,
    CONSTRAINT FK_Asignacion_Rutina FOREIGN KEY (ID_Rutina)
        REFERENCES dbo.RUTINA(ID_Rutina) ON DELETE CASCADE
);
GO
