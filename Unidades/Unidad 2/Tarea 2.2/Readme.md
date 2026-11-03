[Actividad 2.2 U_2 Fundamentos Base de datos.md](https://github.com/user-attachments/files/34228379/Actividad.2.2.U_2.Fundamentos.Base.de.datos.md)

Materia: Fundamentos Bases de Datos Actividad U.2 – Tarea 2.2 Maestro: Rubén Miguel Riojas Rodríguez Semestre: 5to Semestre Alumno: José Luis Luna García Matricula: I24050385 

### Contenido 

| Contenido  |  |
| --- | ---: |
| [Unidad 2 – Tarea 2.2](#unidad-2--tarea-22) | [3](#unidad-2--tarea-22) |
| [Transición de diagrama E-R a notación UML](#transición-de-diagrama-e-r-a-notación-uml) | [3](#transición-de-diagrama-e-r-a-notación-uml) |
| [El Modelo Entidad-Relación Extendido (EER) Conceptual](#el-modelo-entidad-relación-extendido-eer-conceptual) | [3](#el-modelo-entidad-relación-extendido-eer-conceptual) |
| [Fundamentos y Mecanismos Avanzados del Modelo EER](#fundamentos-y-mecanismos-avanzados-del-modelo-eer) | [4](#fundamentos-y-mecanismos-avanzados-del-modelo-eer) |
| [Conversión a Diagrama de Clases en Notación UML](#conversión-a-diagrama-de-clases-en-notación-uml) | [5](#conversión-a-diagrama-de-clases-en-notación-uml) |
| [Matriz de Correspondencia Directa: EER vs. UML](#matriz-de-correspondencia-directa-eer-vs-uml) | [6](#matriz-de-correspondencia-directa-eer-vs-uml) |
| [Especificación Estructural del Diagrama de Clases](#especificación-estructural-del-diagrama-de-clases) | [7](#especificación-estructural-del-diagrama-de-clases) |
| [Conclusión y Validación del Diseño](#conclusión-y-validación-del-diseño) | [7](#conclusión-y-validación-del-diseño) |

# Unidad 2 – Tarea 2.2 

## Transición de diagrama E-R a notación UML 

### El Modelo Entidad-Relación Extendido (EER) Conceptual 

El punto de partida de la arquitectura de datos es el **Modelo Entidad-Relación Extendido (EER)**, diseñado para resolver la desarticulación operativa del centro deportivo. Este modelo integra la gestión de socios, cobranzas, casilleros y planes de entrenamiento bajo un esquema riguroso que previene la duplicidad y las inconsistencias en la vigencia de los servicios. 
```mermaid
flowchart TD 
%% ========================================== 
%% 1\. ENTIDADES PRINCIPALES (RECTÁNGULOS) 
%% ========================================== 
TIPO\_USUARIO[TIPO\_USUARIO] 
USUARIO[USUARIO] 
TELEFONO[TELEFONO] 
CLIENTE[CLIENTE] 
EMPLEADO[EMPLEADO] 
LOCKER[LOCKER] 
RUTINA[RUTINA] 
%% ========================================== 
%% 2\. ATRIBUTOS CONCEPTUALES (ÓVALOS) 
%% ========================================== 
%% USUARIO (Atributo Compuesto: Nombre) 
A\_ID\_U([ID\_Usuario - PK]) --- USUARIO 
A\_IDTP\_U([ID_Tipo_Usuario - FK]) ---USUARIO
A\_Nom\_U([Nombre]) --- USUARIO 
A\_AP\_U([Apellido Paterno]) ---USUARIO
A\_AM\_U([Apellido Materno]) ---USUARIO
%% TELEFONO (Multivalorado) 
A\_ID\_TEL([ID\_Telefono - PK]) --- TELEFONO 
A\_IDU\_TEL([ID_Usuario-FK]) ---TELEFONO
A\_NUM([Numero]) --- TELEFONO 
A\_DES([Descripcion]) --- TELEFONO
%% TIPO\_USUARIO 
A\_ID\_TU([ID\_TipoUsuario - PK]) --- TIPO\_USUARIO 
A\_DESC\_TU([Descripcion]) --- TIPO\_USUARIO 
%% CLIENTE 
A\_EST([Estado]) --- CLIENTE 
%% EMPLEADO 
A\_PUESTO([Puesto]) --- EMPLEADO 
A\_SAL([Salario]) --- EMPLEADO 
%% LOCKER 
A\_ID\_L([ID\_Locker - PK]) --- LOCKER 
A\_NUM\_L([Numero Locker]) --- LOCKER 
%% RUTINA 
A\_ID\_R([ID\_Rutina - PK]) --- RUTINA 
A\_IDE\_([IDEmpleado]) ---RUTINA
A\_DIF([Dificultad]) --- RUTINA 
A\_OBJ([Objetivo]) --- RUTINA 
A\_DESC\_R([Descripcion]) --- RUTINA 
%% ========================================== 
%% 3\. ESPECIALIZACIÓN DISJUNTA (HERENCIA EER) 
%% ========================================== 
USUARIO --- DISJUNTO(( d )) 
DISJUNTO --- CLIENTE 
DISJUNTO --- EMPLEADO 
%% ========================================== 
%% 4\. RELACIONES GENERALES 
%% ========================================== 
TIPO\_USUARIO ---|1| R\_CLAS{CLASIFICA} 
R\_CLAS ---|N| USUARIO 
USUARIO ---|1| R\_TIENE{TIENE} 
R\_TIENE ---|N| TELEFONO 
%% ========================================== 
%% 5\. AGREGACIÓN: CONTRATACIÓN VIGENTE 
%% ==========================================

subgraph AGREGACION [AGREGACION CONTRATACION VIGENTE]
MEMBRESIA[MEMBRESIA] 
R\_PAGO[PAGO\_MEMBRESIA]

%% Atributos Membresía 
A\_ID\_M([ID\_Membresia - PK]) --- MEMBRESIA 
A\_TIPO\_M([Tipo]) --- MEMBRESIA 
A\_COSTO\_M([Costo]) --- MEMBRESIA 
A\_DUR\_M([Duracion]) --- MEMBRESIA 
%% Atributos Pago de Membresía 
A\_ID\_P([ID\_Pago - PK]) --- R\_PAGO 
A\_FECHA\_P([Fecha Pago]) --- R\_PAGO 
A\_VIG\_P([Vigencia Suscripcion - Derivado]) --- R\_PAGO 
CLIENTE --- R\_PAGO 
EMPLEADO --- R\_PAGO 
MEMBRESIA --- R\_PAGO 
end 
%% ========================================== 
%% 6\. ASIGNACIÓN DE LOCKER DESDE LA AGREGACIÓN 
%% ========================================== 
AGREGACION ---|1| R\_ASIG\_L{ASIGNADO\_A} 
R\_ASIG\_L ---|1| LOCKER 
%% ========================================== 
%% 7\. DISEÑO Y ASIGNACIÓN DE RUTINAS 
%% ========================================== 
EMPLEADO ---|1| R\_DIS{DISEÑA} 
R\_DIS ---|N| RUTINA 

CLIENTE ---|1| R\_ASIG\_R{ASIGNADA} 
R\_ASIG\_R ---|N| RUTINA
```
### Fundamentos y Mecanismos Avanzados del Modelo EER 

El diagrama EER incorpora tres abstracciones estructurales fundamentales: 

- **Jerarquía de Herencia y Especialización Disjunta (d):** La entidad superclase USUARIO centraliza los atributos personales comunes (Nombre completo con desglose compuesto). A través del círculo de disyunción (d), se especializa de forma mutuamente excluyente en las subclases CLIENTE y EMPLEADO. De este modo, un usuario no puede pertenecer a ambos roles simultáneamente en la misma instancia y se elimina toda redundancia de almacenamiento. 
- **Mecanismo de Agregación (CONTRATACIÓN VIGENTE):** La transacción PAGO\_MEMBRESIA vincula ternariamente a CLIENTE, EMPLEADO y MEMBRESIA. Para modelar conceptualmente que la asignación de un casillero físico (LOCKER) depende de una cuota activa y no del socio aislado, se aplica una agregación que encapsula dicha relación. Así, LOCKER se asocia directamente a la contratación en estado vigente (1 a 1). 
- **Clasificación Normativa de Atributos:** El modelo implementa atributos compuestos (NOMBRE desglosado en Nombre de Pila, Apellido Paterno y Apellido Materno), atributos multivalorados (la entidad TELEFONO con cardinalidad 1 a N respecto a USUARIO) y atributos derivados (la Vigencia de Suscripción calculada dinámicamente mediante Fecha de Pago + Duración de Membresía). 

### Conversión a Diagrama de Clases en Notación UML 

La transición del paradigma conceptual Entidad-Relación al modelado orientado a objetos en **UML (Unified Modeling Language)** permite traducir entidades, atributos y asociaciones en clases con propiedades tipadas, métodos de comportamiento y relaciones estructurales formales (generalización, composición y agregación). 
```mermaid
classDiagram 
%% ========================================== 
%% 1\. DEFINICIÓN DE CLASES Y ATRIBUTOS 
%% ========================================== 

class TipoUsuario { int idTipoUsuario string descripcion }

class Usuario { int idUsuario string nombre string apellidoPaterno string apellidoMaterno }
class Telefono { int idTelefono string numero string descripcion }
class Cliente { string estado }
class Empleado { string puesto float salario }
class Membresia { int idMembresia string tipo float costo int duracion }
class PagoMembresia { int idPago date fechaPago date vigenciaSuscripcion calcularVigencia() }
class Locker { int idLocker string numeroLocker }
class Rutina { int idRutina string dificultad string objetivo string descripcion }

%% ========================================== 
%% 2\. RELACIONES UML (HERENCIA, COMPOSICIÓN, AGREGACIÓN) 
%% ==========================================
Usuario <|-- Cliente : hereda 
Usuario <|-- Empleado : hereda

%% Composición (Atributo multivalorado dependiente) 
Usuario "1" *-- "1..*" Telefono : posee
%% Asociación simple con Tipo de Usuario 
TipoUsuario "1" <-- "0..*" Usuario : clasifica
%% Asociaciones de la Transacción de Cobro 
Cliente "1" --> "0..*" PagoMembresia : realiza 
Empleado "1" --> "0..*" PagoMembresia : atiende 
Membresia "1" --> "0..*" PagoMembresia : contratada
%% Agregación (Asignación de casillero a la contratación activa) 
PagoMembresia "0..1" o-- "0..1" Locker : asigna 
%% Asociaciones de Rutinas 
Empleado "1" --> "0..*" Rutina : disena 
Cliente "0..*" --> "0..\*" Rutina : asignada
```

### Matriz de Correspondencia Directa: EER vs. UML 

La siguiente tabla detalla cómo cada componente formal del diagrama EER se proyecta y traduce de manera unívoca al diagrama de clases UML: 

| **Concepto EER**  | **Notación en UML**  | **Regla de Transformación y Justificación**  |
| --- | --- | --- |
| Entidad  | Clase  | Cada entidad regular del EER (USUARIO, CLIENTE, EMPLEADO, LOCKER, etc.) se transforma en una Clase con atributos privados tipados.  |
| Especialización Disjunta (d)  | Herencia / Generalización (\<\|--)  | La superclase Usuario hereda atributos a Cliente y Empleado mediante el triángulo hueco. Las subclases no duplican el identificador, heredando idUsuario.  |
| Atributo Compuesto (Nombre)  | Atributos Atómicos / Composición  | El desglose conceptual de 'Nombre' se representa directamente en la clase Usuario como propiedades atómicas: nombre, apellidoPaterno y apellidoMaterno.  |
| Atributo Multivalorado (TELEFONO)  | Composición (\*--)  | La entidad débil/multivalorada TELEFONO se vincula a Usuario con multiplicidad 1..\* y rombo relleno. Si se elimina el Usuario, desaparecen sus teléfonos asociados.  |
| Agregación EER (Contratación)  | Agregación UML (o--)  | La asignación del casillero físico LOCKER se enlaza a PagoMembresia con rombo hueco (0..1 a 0..1). Si la suscripción expira, el casillero físico no se destruye.  |
| Atributo Derivado (Vigencia)  | Propiedad Derivada y Método  | La vigencia se modela como propiedad calculada (vigenciaSuscripcion) y se implementa una operación en la clase: calcularVigencia().  |

### Especificación Estructural del Diagrama de Clases 

El diagrama UML resultante modela la lógica del gimnasio a través de las siguientes definiciones operativas: 

- **Clase Usuario y Subclases (Cliente / Empleado):** La clase base Usuario define el identificador idUsuario y la partición del nombre completo. Cliente añade únicamente el atributo específico 'estado' (activo, suspendido o inactivo), mientras que Empleado incorpora 'puesto' y 'salario'. Ambas subclases heredan limpiamente la identidad sin redundar llaves primarias. 
- **Clase de Transacción PagoMembresia:** Representa el evento de cobro vinculando Cliente (1 a 0..\*), Empleado cobrador (1 a 0..\*) y Membresia (1 a 0..\*). Encapsula el cálculo de negocio mediante el método calcularVigencia(), el cual determina la fecha límite de acceso al centro. 
- **Clase Locker y su Asociación por Agregación:** Almacena idLocker y numeroLocker. Se relaciona mediante agregación compartida con PagoMembresia ('0..1' a '0..1'). Esta decisión arquitectónica asegura que un casillero permanezca disponible en el inventario general del gimnasio aun cuando un cliente cause baja o venza su cuota. 
- **Clase Rutina y Mapeo Operativo:** Define las características del entrenamiento: idRutina, dificultad, objetivo y descripción. La asociación desde Empleado es 1 a 0..\* (el entrenador diseña las rutinas), mientras que la asociación con Cliente es 0..\* a 0..\* (asignación masiva o personalizada según el perfil físico del socio). 

### Conclusión y Validación del Diseño 

La conversión formal del modelo Entidad-Relación Extendido a Diagrama de Clases UML garantiza que el diseño no solo sea consistente para la futura normalización y creación de esquemas SQL relacionales, sino también apto para la implementación orientada a objetos en sistemas empresariales (Java, C#, Python). Se preservan con rigor todas las reglas de negocio establecidas, asegurando una arquitectura robusta, escalable y sin redundancia de datos. 
