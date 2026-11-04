# Actividad 2.2: Transición del Modelo Entidad-Relación Extendido (EER) a Diagrama de Clases UML

Este directorio contiene los entregables y recursos correspondientes a la **Actividad 2.2 de la Unidad 2** de la materia **Fundamentos de Bases de Datos** (5to Semestre), impartida en el **Tecnológico Nacional de México (Campus Monclova)** por el docente Rubén Miguel Riojas Rodríguez, desarrollada por el alumno José Luis Luna García (Matrícula: I24050385).

---

## Objetivo y Enfoque de la Actividad

El propósito fundamental de esta práctica es realizar la **conversión y mapeo formal** del Modelo Entidad-Relación Extendido (EER) del caso de estudio del **Centro Deportivo (Gimnasio)** hacia un **Diagrama de Clases en notación UML (Unified Modeling Language)**. 

Esta transición permite traducir abstracciones conceptuales de datos en especificaciones estructurales aptas para el desarrollo orientado a objetos (OOP) y la futura normalización en esquemas SQL relacionales.

### Principales Transformaciones de Paradigma (EER vs. UML):
* **Entidades a Clases:** Conversión de entidades regulares en clases formales con tipado de datos en sus atributos (`int`, `string`, `float`, `date`).
* **Especialización Disjunta (`d`) a Generalización (`&lt;|--`):** La entidad padre `Usuario` hereda atributos a `Cliente` y `Empleado` mediante generalización con triángulo hueco, evitando la redundancia de identificadores primarios (`idUsuario`).
* **Atributo Compuesto a Propiedades Atómicas:** El nombre completo conceptual se descompone en los atributos directos `nombre`, `apellidoPaterno` y `apellidoMaterno`.
* **Atributo Multivalorado a Composición (`*--`):** La entidad de contacto `Telefono` se asocia por composición fuerte con `Usuario` (`1` a `1..*`).
* **Agregación Conceptual a Agregación UML (`o--`):** La asignación de casilleros (`Locker`) se vincula a la clase transaccional `PagoMembresia` con multiplicidad `0..1` a `0..1`, garantizando que si una membresía vence, el casillero físico no se destruya del inventario.
* **Atributo Derivado a Operación:** El cálculo de vigencia se traduce en la propiedad `vigenciaSuscripcion` respaldada por el método de negocio `calcularVigencia()`.

---

## Contenido de la Carpeta

A continuación se describe cada uno de los archivos incluidos en este entregable:

### 1. `Actividad 2.2 U_2 Fundamentos Base de datos.pdf`
Documento formal completo en formato PDF para revisión académica. Contiene:
* **Portada institucional** con datos académicos oficiales.
* **Presentación del Modelo EER Conceptual:** Punto de partida visual y reglas de negocio del centro deportivo.
* **Fundamentos y Mecanismos Avanzados:** Explicación teórica de la herencia disjunta, el mecanismo de agregación y los tipos de atributos.
* **Diagrama de Clases UML:** Representación gráfica completa con visibilidad, tipos de datos, cardinalidades y métodos.
* **Matriz de Correspondencia Directa (EER vs. UML):** Tabla comparativa que justifica cada una de las reglas de transformación aplicadas.
* **Especificación Estructural de Clases:** Desglose analítico de las clases `Usuario`, `Cliente`, `Empleado`, `PagoMembresia`, `Locker`, `Rutina` y `Membresia`.
* **Conclusiones y validación del diseño.**

---

### 2. `Actividad 2.2.md`
Reporte íntegro en formato Markdown con el desarrollo textual de la actividad, la tabla comparativa de equivalencias de conceptos y los bloques de código en sintaxis Mermaid tanto del modelo EER como del diagrama de clases UML.

---

### 3. `Digrama ENTIDAD RELACION.mmd`
Archivo complementario en **Mermaid (`flowchart TD`)** que contiene el diagrama conceptual EER base del gimnasio, sirviendo como marco de referencia para contrastar el diseño previo frente al nuevo diagrama de clases.

---

### 4. `Conversión Diagrama E-R a UML.mmd`
Archivo con el código fuente en lenguaje **Mermaid (`classDiagram`)** que modela la arquitectura orientada a objetos:
* Definición de clases con atributos tipados y operaciones (`calcularVigencia()`).
* Relaciones de generalización/herencia (`&lt;|--`).
* Relación de composición (`*--`) para teléfonos de contacto.
* Relación de agregación (`o--`) entre `PagoMembresia` y `Locker`.
* Asociaciones dirigidas con multiplicidades de negocio para el cobro de membresías y la asignación de rutinas.
---

### 5. `Link Video YouTube.md`
Archivo de referencia rápida con el enlace directo al video de sustentación de la práctica:
* **Enlace:** [Video Actividad 2.2 Fundamentos Base de datos](https://www.youtube.com/watch?v=JR3sR9KfLDU&amp;t=41s)

---
