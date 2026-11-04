# Unidad 4 - Tarea 4.1: Fundamentos de Dependencias Funcionales, Formas Normales y Mapa Conceptual de Normalización

Este directorio contiene los entregables y recursos de la **Actividad 4.1 de la Unidad 4** de la materia **Fundamentos de Bases de Datos** (5to Semestre), impartida en el **Tecnológico Nacional de México (Campus Monclova)** por el docente Rubén Miguel Riojas Rodríguez y desarrollada por el alumno José Luis Luna García (Matrícula: I24050385).

---

## Alcance Teórico y Metodológico de la Actividad

Esta actividad aborda en profundidad la técnica y metodología formal de **Normalización de Bases de Datos Relacionales**, formulada originalmente por Edgar F. Codd [1, 2], cuyo objetivo fundamental es organizar tablas, columnas y relaciones para **minimizar la redundancia de datos**, **garantizar la consistencia lógica** y **erradicar anomalías operativas** en sistemas transaccionales (OLTP) [1-4].

### Ejes Temáticos Desarrollados:
1. **Teoría de Dependencias Funcionales y Notación Matemática ($X \rightarrow Y$):**
   * **Dependencia Funcional Completa (Fundamento de 2FN):** Un atributo no primo depende de la totalidad de una clave primaria compuesta y no de ningún subconjunto propio [5, 6].
   * **Dependencia Funcional Parcial (Anomalía en Claves Compuestas):** Un atributo no clave depende únicamente de una fracción de la clave compuesta [7, 8].
   * **Dependencia Funcional Transitiva (Fundamento de 3FN):** Determinación indirecta donde un atributo no primo depende de otro atributo no clave ($X \rightarrow Y$ y $Y \rightarrow Z$, implicando $X \rightarrow Z$) [9, 10].

2. **Anomalías Clásicas de Modificación:**
   * **Anomalía de Inserción:** Imposibilidad de registrar hechos válidos independientes por falta de datos asociados exigidos por la tabla [11-14].
   * **Anomalía de Modificación (Actualización):** Incoherencia y discrepancia de datos al actualizar información repetida en múltiples registros [12, 14-16].
   * **Anomalía de Borrado (Eliminación):** Pérdida involuntaria y destructiva de datos críticos al dar de baja una tupla asociada [12, 14, 17, 18].

3. **Jerarquía Acumulativa de Formas Normales:**
   * **Nivel Básico:** **1FN** (atomicidad de atributos, sin grupos repetitivos) [12, 14, 18, 19], **2FN** (eliminación de dependencias parciales sobre claves compuestas) [12, 14, 18, 19] y **3FN** (eliminación de dependencias transitivas entre columnas no clave) [12, 14, 18, 19].
   * **Nivel Intermedio y Avanzado:** **FNBC** (todo determinante debe ser superclave/clave candidata) [12, 14, 18, 19], **4FN** (supresión de dependencias multivaluadas) [12, 14, 18, 19], **5FN** (dependencias de unión o *join dependencies*) [12, 14, 18, 19] y **6FN** (estructuras irreducibles para datos temporales e históricos) [12, 14].

4. **Desnormalización Estratégica y Controlada:** Criterios de balance entre el aislamiento transaccional estricto (OLTP) y el rendimiento en consultas masivas en almacenes de datos y analítica (OLAP / Data Warehousing) [20, 21].

---

## Contenido de la Carpeta

A continuación se detalla la función de cada uno de los archivos que integran esta entrega:

### 1. `Actividad 4.1 U_4 Fundamentos Base de datos.pdf`
Documento formal completo en formato PDF listo para entrega y evaluación académica [22]. Contiene:
* **Portada institucional** con los datos de identificación académica del TecNM Campus Monclova, docente y alumno [22].
* **Desarrollo teórico riguroso:** Concepto formal, objetivos, teoría matemática de dependencias funcionales y análisis de las anomalías de modificación [1, 11, 22, 23].
* **Matriz comparativa de Formas Normales (1FN a 5FN):** Tabla detallada con condiciones previas, reglas formales y ejemplos ilustrativos clásicos [19, 22].
* **Mapa conceptual visual integrado:** Diagrama de síntesis que correlaciona conceptos, formas normales y anomalías resueltas [3, 22].
* **Conclusiones sobre OLTP vs. OLAP y referencias bibliográficas** [3, 20, 22, 24].

---

### 2. `Actividad 4.1.md`
Reporte completo en formato Markdown [25]. Incluye la totalidad del texto técnico, las tablas de dependencias y anomalías, la sintaxis Mermaid del mapa conceptual y la bibliografía en formato digital [14, 18, 21, 25].

---

### 3. `Mapa Conceptual Tarea 4.1.mmd`
*(Provisto como `.txt` para lectura directa en el entorno)*  
Archivo de código fuente en sintaxis **Mermaid (`flowchart TD`)** [12, 14]. Modela el mapa conceptual completo con estilos visuales diferenciados por jerarquía:
* **Nodo raíz:** Normalización de Bases de Datos [12, 14].
* **Ramas principales:** Concepto/Objetivos, Formas Normales (Básicas y Avanzadas) y Anomalías que previene [12, 14].
* **Desglose de reglas:** Reglas estructurales y anomalías eliminadas desde 1FN hasta 6FN [12, 14].

---

### 4. `Link Video YouTube.md`
Archivo de texto con el acceso directo a la sustentación y explicación en video de la actividad:
* **Enlace:** [Video Actividad 4.1 Fundamentos Base de datos](https://www.youtube.com/watch?v=oyA8Zh5o2TQ&amp;t=95s) [26]

---
