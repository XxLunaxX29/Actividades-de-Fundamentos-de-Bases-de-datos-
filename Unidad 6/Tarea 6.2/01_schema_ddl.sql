-- ============================================================================
-- ARCHIVO: 01_schema_ddl.sql
-- PROYECTO: Sistema de Gestión de Gimnasios (gimnasio_normalizado)
-- FASE: LDD (Lenguaje de Definición de Datos / DDL)
-- SGBD: Microsoft SQL Server / SQL Server Express (Transact-SQL)
-- ============================================================================

-- 1. Creación de la Base de Datos
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'gimnasio_normalizado')
BEGIN
    CREATE DATABASE gimnasio_normalizado;
END;
GO

USE gimnasio_normalizado;
GO

-- 2. Limpieza preventiva en orden inverso a la jerarquía de dependencias referenciales
IF OBJECT_ID('dbo.ASIGNACION_RUTINA', 'U') IS NOT NULL DROP TABLE dbo.ASIGNACION_RUTINA;
IF OBJECT_ID('dbo.RUTINA', 'U')            IS NOT NULL DROP TABLE dbo.RUTINA;
IF OBJECT_ID('dbo.LOCKER', 'U')            IS NOT NULL DROP TABLE dbo.LOCKER;
IF OBJECT_ID('dbo.PAGO_MEMBRESIA', 'U')    IS NOT NULL DROP TABLE dbo.PAGO_MEMBRESIA;
IF OBJECT_ID('dbo.MEMBRESIA', 'U')         IS NOT NULL DROP TABLE dbo.MEMBRESIA;
IF OBJECT_ID('dbo.EMPLEADO', 'U')          IS NOT NULL DROP TABLE dbo.EMPLEADO;
IF OBJECT_ID('dbo.CLIENTE', 'U')           IS NOT NULL DROP TABLE dbo.CLIENTE;
IF OBJECT_ID('dbo.TELEFONO', 'U')          IS NOT NULL DROP TABLE dbo.TELEFONO;
IF OBJECT_ID('dbo.USUARIO', 'U')           IS NOT NULL DROP TABLE dbo.USUARIO;
IF OBJECT_ID('dbo.TIPO_USUARIO', 'U')      IS NOT NULL DROP TABLE dbo.TIPO_USUARIO;
GO

-- 3. Creación de Tablas con Integridad de Entidad, Dominio y Referencial

-- Tabla 1: Catálogo de Tipos de Usuario
CREATE TABLE dbo.TIPO_USUARIO (
    ID_TipoUsuario INT IDENTITY(1,1) NOT NULL,
    Nombre_Tipo    VARCHAR(50) NOT NULL,
    CONSTRAINT PK_TipoUsuario PRIMARY KEY (ID_TipoUsuario),
    CONSTRAINT UQ_TipoUsuario_Nombre UNIQUE (Nombre_Tipo)
);
GO

-- Tabla 2: Superclase Usuario (1FN: Atributos atómicos)
CREATE TABLE dbo.USUARIO (
    ID_Usuario       INT IDENTITY(1,1) NOT NULL,
    ID_TipoUsuario   INT NOT NULL,
    Nombre_Pila      VARCHAR(50) NOT NULL,
    Apellido_Paterno VARCHAR(50) NOT NULL,
    Apellido_Materno VARCHAR(50) NULL,
    CURP             CHAR(18) NOT NULL,
    Fecha_Nacimiento DATE NOT NULL,
    CONSTRAINT PK_Usuario PRIMARY KEY (ID_Usuario),
    CONSTRAINT UQ_Usuario_CURP UNIQUE (CURP),
    CONSTRAINT FK_Usuario_Tipo FOREIGN KEY (ID_TipoUsuario)
        REFERENCES dbo.TIPO_USUARIO(ID_TipoUsuario)
);
GO

-- Tabla 3: Teléfono (1FN: Aislamiento de atributo multivalorado)
CREATE TABLE dbo.TELEFONO (
    ID_Usuario      INT NOT NULL,
    Numero_Telefono VARCHAR(15) NOT NULL,
    CONSTRAINT PK_Telefono PRIMARY KEY (ID_Usuario, Numero_Telefono),
    CONSTRAINT FK_Telefono_Usuario FOREIGN KEY (ID_Usuario)
        REFERENCES dbo.USUARIO(ID_Usuario) ON DELETE CASCADE
);
GO

-- Tabla 4: Subclase Cliente (Herencia Disjunta)
CREATE TABLE dbo.CLIENTE (
    ID_Cliente     INT NOT NULL,
    Fecha_Registro DATE NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_Cliente PRIMARY KEY (ID_Cliente),
    CONSTRAINT FK_Cliente_Usuario FOREIGN KEY (ID_Cliente)
        REFERENCES dbo.USUARIO(ID_Usuario) ON DELETE CASCADE
);
GO

-- Tabla 5: Subclase Empleado (Herencia Disjunta con Restricción CHECK de Dominio)
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

-- Tabla 6: Catálogo de Membresías
CREATE TABLE dbo.MEMBRESIA (
    ID_Membresia   INT IDENTITY(1,1) NOT NULL,
    Tipo_Membresia VARCHAR(50) NOT NULL,
    Costo          DECIMAL(10,2) NOT NULL,
    Duracion_Dias  INT NOT NULL,
    CONSTRAINT PK_Membresia PRIMARY KEY (ID_Membresia),
    CONSTRAINT CK_Membresia_Costo CHECK (Costo >= 0),
    CONSTRAINT CK_Membresia_Dias CHECK (Duracion_Dias > 0)
);
GO

-- Tabla 7: Transacciones de Pago de Membresía
CREATE TABLE dbo.PAGO_MEMBRESIA (
    ID_Pago      INT IDENTITY(1,1) NOT NULL,
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

-- Tabla 8: Lockers (Casilleros)
CREATE TABLE dbo.LOCKER (
    ID_Locker     INT IDENTITY(1,1) NOT NULL,
    Numero_Locker INT NOT NULL,
    Ubicacion     VARCHAR(50) NOT NULL,
    ID_Pago       INT NULL, -- NULL representa casillero desocupado
    CONSTRAINT PK_Locker PRIMARY KEY (ID_Locker),
    CONSTRAINT UQ_Locker_Numero UNIQUE (Numero_Locker),
    CONSTRAINT FK_Locker_Pago FOREIGN KEY (ID_Pago)
        REFERENCES dbo.PAGO_MEMBRESIA(ID_Pago) ON DELETE SET NULL
);
GO

-- Índice único filtrado para SQL Server (permite múltiples NULLs pero unicidad si está ocupado)
CREATE UNIQUE NONCLUSTERED INDEX UQ_Locker_Pago_Filtrado
ON dbo.LOCKER(ID_Pago)
WHERE ID_Pago IS NOT NULL;
GO

-- Tabla 9: Catálogo de Rutinas
CREATE TABLE dbo.RUTINA (
    ID_Rutina        INT IDENTITY(1,1) NOT NULL,
    Nombre_Rutina    VARCHAR(100) NOT NULL,
    Nivel_Dificultad VARCHAR(20) NOT NULL,
    CONSTRAINT PK_Rutina PRIMARY KEY (ID_Rutina),
    CONSTRAINT CK_Rutina_Dificultad CHECK (Nivel_Dificultad IN ('Principiante', 'Intermedio', 'Avanzado'))
);
GO

-- Tabla 10: Asignación de Rutinas a Clientes (Resolución de relación N:M)
CREATE TABLE dbo.ASIGNACION_RUTINA (
    ID_Cliente       INT NOT NULL,
    ID_Rutina        INT NOT NULL,
    Fecha_Asignacion DATE NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_AsignacionRutina PRIMARY KEY (ID_Cliente, ID_Rutina),
    CONSTRAINT FK_Asig_Cliente FOREIGN KEY (ID_Cliente)
        REFERENCES dbo.CLIENTE(ID_Cliente) ON DELETE CASCADE,
    CONSTRAINT FK_Asig_Rutina FOREIGN KEY (ID_Rutina)
        REFERENCES dbo.RUTINA(ID_Rutina) ON DELETE CASCADE
);
GO
