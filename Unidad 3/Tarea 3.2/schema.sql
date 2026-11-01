
-- ============================================================================
-- SCRIPT DE CREACIÓN DE BASE DE DATOS Y ESQUEMA FÍSICO (SQL SERVER EXPRESS)
-- Proyecto: Sistema de Gestión de Gimnasios
-- Basado en: Actividad 3.2 - Generación del Esquema Físico y Script LDD
-- ============================================================================
CREATE DATABASE GIMNASIO;
GO
USE GIMNASIO;
GO


-- ============================================================================
-- 1. Catálogo de Tipos de Usuario
-- ============================================================================
CREATE TABLE dbo.TIPO_USUARIO (
    ID_TipoUsuario INT NOT NULL,
    Descripcion    VARCHAR(50) NOT NULL,
    CONSTRAINT PK_TipoUsuario PRIMARY KEY (ID_TipoUsuario)
);
GO

-- ============================================================================
-- 2. Superclase Usuario (Atributo Compuesto Aplanado a 1FN)
-- ============================================================================
CREATE TABLE dbo.USUARIO (
    ID_Usuario       INT NOT NULL,
    Nombre_Pila      VARCHAR(50) NOT NULL,
    Apellido_Paterno VARCHAR(50) NOT NULL,
    Apellido_Materno VARCHAR(50) NULL,
    ID_TipoUsuario   INT NOT NULL,
    CONSTRAINT PK_Usuario PRIMARY KEY (ID_Usuario),
    CONSTRAINT FK_Usuario_Tipo FOREIGN KEY (ID_TipoUsuario)
        REFERENCES dbo.TIPO_USUARIO(ID_TipoUsuario)
);
GO

-- ============================================================================
-- 3. Atributo Multivalorado Teléfono (1:N con Usuario)
-- ============================================================================
CREATE TABLE dbo.TELEFONO (
    ID_Telefono INT NOT NULL,
    Numero      VARCHAR(20) NOT NULL,
    Descripcion VARCHAR(30) NULL,
    ID_Usuario  INT NOT NULL,
    CONSTRAINT PK_Telefono PRIMARY KEY (ID_Telefono),
    CONSTRAINT FK_Telefono_Usuario FOREIGN KEY (ID_Usuario)
        REFERENCES dbo.USUARIO(ID_Usuario) ON DELETE CASCADE
);
GO

-- ============================================================================
-- 4. Subclase Cliente (Herencia Disjunta: PK y FK simultánea)
-- ============================================================================
CREATE TABLE dbo.CLIENTE (
    ID_Usuario INT NOT NULL,
    Estado     VARCHAR(20) NOT NULL DEFAULT 'Activo',
    CONSTRAINT PK_Cliente PRIMARY KEY (ID_Usuario),
    CONSTRAINT FK_Cliente_Usuario FOREIGN KEY (ID_Usuario)
        REFERENCES dbo.USUARIO(ID_Usuario) ON DELETE CASCADE
);
GO

-- ============================================================================
-- 5. Subclase Empleado (Herencia Disjunta con Validación CHECK)
-- ============================================================================
CREATE TABLE dbo.EMPLEADO (
    ID_Usuario INT NOT NULL,
    Puesto     VARCHAR(50) NOT NULL,
    Salario    DECIMAL(10, 2) NOT NULL,
    CONSTRAINT PK_Empleado PRIMARY KEY (ID_Usuario),
    CONSTRAINT CK_Empleado_Salario CHECK (Salario > 0),
    CONSTRAINT FK_Empleado_Usuario FOREIGN KEY (ID_Usuario)
        REFERENCES dbo.USUARIO(ID_Usuario) ON DELETE CASCADE
);
GO

-- ============================================================================
-- 6. Entidad Membresía (Catálogo de Planes Comerciales)
-- ============================================================================
CREATE TABLE dbo.MEMBRESIA (
    ID_Membresia  INT NOT NULL,
    Tipo          VARCHAR(50) NOT NULL,
    Costo         DECIMAL(10, 2) NOT NULL,
    Duracion_Dias INT NOT NULL,
    CONSTRAINT PK_Membresia PRIMARY KEY (ID_Membresia),
    CONSTRAINT CK_Membresia_Costo CHECK (Costo >= 0),
    CONSTRAINT CK_Membresia_Duracion CHECK (Duracion_Dias > 0)
);
GO

-- ============================================================================
-- 7. Transacción Ternaria de Cobro / Contratación Vigente
-- ============================================================================
CREATE TABLE dbo.PAGO_MEMBRESIA (
    ID_Pago      INT NOT NULL,
    Fecha_Pago   DATE NOT NULL DEFAULT CAST(GETDATE() AS DATE),
    ID_Cliente   INT NOT NULL,
    ID_Empleado  INT NOT NULL,
    ID_Membresia INT NOT NULL,
    CONSTRAINT PK_PagoMembresia PRIMARY KEY (ID_Pago),
    CONSTRAINT FK_Pago_Cliente FOREIGN KEY (ID_Cliente)
        REFERENCES dbo.CLIENTE(ID_Usuario),
    CONSTRAINT FK_Pago_Empleado FOREIGN KEY (ID_Empleado)
        REFERENCES dbo.EMPLEADO(ID_Usuario),
    CONSTRAINT FK_Pago_Membresia FOREIGN KEY (ID_Membresia)
        REFERENCES dbo.MEMBRESIA(ID_Membresia)
);
GO

-- ============================================================================
-- 8. Asignación de Casillero (1:1 Opcional a la Transacción con UNIQUE)
-- ============================================================================
CREATE TABLE dbo.LOCKER (
    ID_Locker     INT NOT NULL,
    Numero_Locker VARCHAR(10) NOT NULL,
    ID_Pago       INT NULL,
    CONSTRAINT PK_Locker PRIMARY KEY (ID_Locker),
    CONSTRAINT UQ_Locker_Numero UNIQUE (Numero_Locker),
    CONSTRAINT UQ_Locker_Pago UNIQUE (ID_Pago),
    CONSTRAINT FK_Locker_Pago FOREIGN KEY (ID_Pago)
        REFERENCES dbo.PAGO_MEMBRESIA(ID_Pago) ON DELETE SET NULL
);
GO

-- ============================================================================
-- 9. Diseño de Rutinas (1:N desde Empleado)
-- ============================================================================
CREATE TABLE dbo.RUTINA (
    ID_Rutina   INT NOT NULL,
    Dificultad  VARCHAR(20) NOT NULL,
    Objetivo    VARCHAR(100) NOT NULL,
    Descripcion VARCHAR(MAX) NULL,
    ID_Empleado INT NOT NULL,
    CONSTRAINT PK_Rutina PRIMARY KEY (ID_Rutina),
    CONSTRAINT FK_Rutina_Empleado FOREIGN KEY (ID_Empleado)
        REFERENCES dbo.EMPLEADO(ID_Usuario)
);
GO

-- ============================================================================
-- 10. Asignación de Rutinas a Clientes (Resolución N:M con PK Compuesta)
-- ============================================================================
CREATE TABLE dbo.ASIGNACION_RUTINA (
    ID_Cliente       INT NOT NULL,
    ID_Rutina        INT NOT NULL,
    Fecha_Asignacion DATE NOT NULL DEFAULT CAST(GETDATE() AS DATE),
    CONSTRAINT PK_AsignacionRutina PRIMARY KEY (ID_Cliente, ID_Rutina),
    CONSTRAINT FK_Asig_Cliente FOREIGN KEY (ID_Cliente)
        REFERENCES dbo.CLIENTE(ID_Usuario) ON DELETE CASCADE,
    CONSTRAINT FK_Asig_Rutina FOREIGN KEY (ID_Rutina)
        REFERENCES dbo.RUTINA(ID_Rutina) ON DELETE CASCADE
);
GO
