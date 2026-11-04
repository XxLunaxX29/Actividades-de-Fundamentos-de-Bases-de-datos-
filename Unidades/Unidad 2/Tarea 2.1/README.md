# Actividad 2.1: Diseño de Base de Datos con Modelo Entidad-Relación Extendido (EER) - Caso Centro Deportivo

Este directorio contiene los entregables y recursos de la **Actividad 2.1 de la Unidad 2** para la materia **Fundamentos de Bases de Datos** (5to Semestre) en el **Tecnológico Nacional de México (Campus Monclova)**, impartida por el docente Rubén Miguel Riojas Rodríguez y desarrollada por el alumno José Luis Luna García (Matrícula: I24050385).

---

##Descripción del Caso de Estudio

El proyecto aborda la problemática operativa y administrativa de un centro deportivo (**Gimnasio**) que presenta deficiencias por la ausencia de un sistema centralizado (control manual de socios, cuotas, asignación de casilleros y rutinas). 

Para resolverlo, se diseñó una arquitectura conceptual bajo el **Modelo Entidad-Relación Extendido (EER)** que unifica registros, automatiza el control de suscripciones y garantiza la integridad de los datos mediante:
* **Especialización / Generalización Disjunta (`d`):** Herencia exclusiva de la entidad padre `USUARIO` hacia `CLIENTE` y `EMPLEADO`.
* **Concepto Avanzado de Agregación (`CONTRATACIÓN_VIGENTE`):** Abstracción de la transacción `PAGO_MEMBRESIA` (que vincula a cliente, empleado y membresía) para condicionar la asignación física de casilleros (`LOCKER`) únicamente a socios con cuota activa.
* **Tipificación de Atributos:** Manejo formal de clave primaria (PK), atributo compuesto (nombre completo), atributo multivalorado (`TELEFONO`) y atributo derivado (`Vigencia de Suscripción`).

---

## Contenido de la Carpeta

A continuación se detalla la función de cada archivo que integra esta entrega:

### 1. `Actividad 2.1 U_2 Fundamentos Base de datos.pdf`
Documento formal completo en formato PDF listo para entrega académica. Incluye:
* **Portada institucional** y datos de identificación académica.
* **Descripción del entorno y problemática operativa del gimnasio.**
* **Reglas de Negocio normativas (RN1 a RN6)** que rigen la lógica del sistema.
* **Identificación y clasificación de entidades y tipos de atributos.**
* **Matriz de relaciones, cardinalidades y restricciones de participación** (parcial/total).
* **Fundamentación técnica de conceptos EER** (Herencia disjunta y Agregación).
* **Diagrama conceptual E-R** modelado con herramienta CASE.
* **Conclusiones y recomendaciones técnicas de diseño.**

---

### 2. `Actividad 2.1.md`
Reporte técnico completo en formato Markdown. Contiene toda la redacción teórica, el desglose de reglas de negocio, la matriz de cardinalidades, el bloque de código Mermaid del diagrama y las recomendaciones de implementación en un motor relacional.

---

### 3. `DIAGRAMA GIMNASIO NUEVO.drawio.png`
Exportación en alta resolución del **Diagrama Entidad-Relación Extendido** diseñado con la herramienta CASE **draw.io**. Representa gráficamente todas las entidades, relaciones (rombos), cardinalidades, jerarquía de herencia disjunta, el recuadro estructural de agregación (`CONTRATACIÓN VIGENTE`) y la tipología de atributos (óvalos simples, dobles y derivados).

---

### 4. `Digrama ENTIDAD RELACION.mmd`
*(Provisto como `.txt` para lectura directa en el entorno)*  
Archivo con el código fuente en sintaxis **Mermaid (`flowchart TD`)** que reproduce la topología completa del modelo EER:
* Entidades principales y atributos (PK, FK, compuestos, multivalorados y derivados).
* Jerarquía de herencia disjunta (`d`) desde `USUARIO` hacia `CLIENTE` y `EMPLEADO`.
* Estructura de `subgraph` que formaliza la agregación de `CONTRATACIÓN VIGENTE`.
* Relaciones de asignación de casilleros y diseño/asignación de rutinas de entrenamiento.

---

### 5. `Link Video YouTube.md`
Archivo de texto con el acceso directo a la sustentación y explicación en video de la actividad:
* **Enlace:** [Video Actividad 2.1 Fundamentos Base de datos](https://www.youtube.com/watch?v=30Me7NuIWpM&amp;t=24s)

---
