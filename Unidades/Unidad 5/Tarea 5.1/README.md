# Unidad 5 - Tarea 5.1: Operadores Fundamentales y Extendidos del Álgebra Relacional

Este directorio contiene los entregables y recursos de la **Actividad 5.1 de la Unidad 5** de la materia **Fundamentos de Bases de Datos** (5to Semestre), impartida en el **Tecnológico Nacional de México (Campus Monclova)** por el docente Rubén Miguel Riojas Rodríguez y desarrollada por el alumno José Luis Luna García (Matrícula: I24050385).

---

## Alcance Teórico: Álgebra Relacional

El **álgebra relacional** es un lenguaje formal y procedimental de consulta basado en la teoría de conjuntos y la lógica de predicados. Constituye el fundamento matemático de los motores relacionales y del lenguaje SQL estándar. Cumple de manera inherente con la **propiedad de clausura**, donde cualquier operador toma una o más relaciones como entrada y produce invariablemente una nueva relación como resultado.

### Taxonomía de Operadores Modelados:

1. **Operadores Unarios (operan sobre una sola relación $R$):**
   * **Selección ($\sigma$ - Sigma):** Filtra y extrae tuplas que satisfacen una condición booleana (equivalente a la cláusula `WHERE` en SQL).
   * **Proyección ($\pi$ - Pi):** Selecciona columnas específicas y descarta duplicados del resultado (equivalente a `SELECT DISTINCT`).
   * **Renombramiento ($\rho$ - Rho):** Asigna identificadores o alias temporales a relaciones o atributos (equivalente a `AS`).

2. **Operadores Binarios Básicos (operan sobre pares de relaciones $R$ y $S$):**
   * **Operaciones de Conjuntos** *(exigen compatibilidad de unión: mismo grado y dominios afines)*:
     * **Unión ($\cup$):** Agrupa tuplas de ambas relaciones eliminando duplicidades.
     * **Intersección ($\cap$):** Extrae exclusivamente las tuplas que existen simultáneamente en $R$ y $S$.
     * **Diferencia ($- / \setminus$):** Obtiene tuplas presentes en la primera relación que no figuran en la segunda.
   * **Operaciones de Cruce y Combinación:**
     * **Producto Cartesiano ($\times$):** Combina cada fila de $R$ con todas las filas de $S$, multiplicando la cardinalidad total.
     * **Reunión o Join ($\bowtie$):** Combina tuplas de dos tablas según una condición de enlace (clave foránea). Incluye la variante de **Reunión Natural**, que enlaza columnas homónimas eliminando atributos redundantes.
     * **División ($\div$):** Extrae registros asociados con todos los elementos de otra tabla (consultas tipo *"para todo"*).

3. **Álgebra Relacional Extendida (operaciones avanzadas y analíticas):**
   * **Proyección Generalizada ($\pi^*$):** Permite incorporar cálculos aritméticos, fórmulas y constantes en las columnas proyectadas.
   * **Agregación y Agrupamiento ($\mathcal{G} / G$):** Agrupa tuplas y aplica funciones estadísticas (`SUM`, `AVG`, `COUNT`, `MIN`, `MAX`; equivalente a `GROUP BY`).
   * **Reuniones Externas (Outer Joins):** Preservan filas sin correspondencia rellenando con valores nulos (`NULL`):
     * *Left Outer Join* ($\leftouterjoin$): Mantiene todas las tuplas de la relación izquierda.
     * *Right Outer Join* ($\rightouterjoin$): Mantiene todas las tuplas de la relación derecha.
     * *Full Outer Join* ($\fullouterjoin$): Mantiene todas las tuplas de ambas relaciones.

---

## Contenido de la Carpeta

A continuación se detalla el contenido de los archivos que integran esta entrega:

### 1. `Actividad 5.1 U_5 Fundamentos Base de datos.pdf`
Documento formal completo en formato PDF listo para evaluación académica. Incluye:
* **Portada institucional** con datos académicos oficiales del TecNM Campus Monclova, docente y alumno.
* **Mapa conceptual gráfico:** Representación visual estructurada que clasifica los operadores unarios, binarios básicos (conjuntos y cruces) y extendidos con sus símbolos matemáticos, definiciones, ejemplos cotidianos y equivalencias en sintaxis SQL.
* **Referencias bibliográficas consultadas.**

---

### 2. `Actividad 5.1.md`
Reporte técnico en formato Markdown. Contiene la estructura documental, el desglose conceptual completo, las referencias y el bloque de código Mermaid del mapa conceptual con estilos jerárquicos visuales.

---

### 3. `Mapa Conceptual Tarea 5.1.mmd`
*(O disponible dentro de `Actividad 5.1.md`)*  
Código fuente del mapa conceptual en sintaxis **Mermaid (`flowchart TD`)**. Diseñado con una estructura en columnas y estilos visuales diferenciados:
* Encabezado principal y definición formal con la propiedad de clausura.
* Desglose jerárquico en tres ramas: Operadores Unarios, Binarios Básicos y Extendidos.
* Fichas descriptivas por operador con notación formal, propósito, ejemplos cotidianos y correlación directa con sentencias SQL.

---

### 4. `Link Video YouTube.md`
Archivo de texto con el enlace directo a la sustentación y explicación en video de la actividad:
* **Enlace:** [Video Actividad 5.1 Fundamentos Base de datos](https://www.youtube.com/watch?v=HPB34pa_A78)

---

---

###
