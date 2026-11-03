[Uploading Actividad 1.1 U_1 Fundamento Base de datos.md…]()
Materia: Fundamentos Bases de Datos Actividades U.1 – Tareas 1.1 Maestro: Rubén Miguel Riojas Rodríguez Semestre: 5to Semestre Alumno: José Luis Luna García Matricula: I24050385 

### Contenido 

| Contenido  |  |
| --- | ---: |
| [**Tarea 1.1: Fundamentos, objetivos y modelos de bases de datos**](#tarea-11-fundamentos-objetivos-y-modelos-de-bases-de-datos) | [3](#tarea-11-fundamentos-objetivos-y-modelos-de-bases-de-datos) |
| [Mapa conceptual sobre los conceptos fundamentales, objetivos, usos y aplicaciones de las bases de datos](#mapa-conceptual-sobre-los-conceptos-fundamentales-objetivos-usos-y-aplicaciones-de-las-bases-de-datos) | [3](#mapa-conceptual-sobre-los-conceptos-fundamentales-objetivos-usos-y-aplicaciones-de-las-bases-de-datos) |
| [Distintos modelos de bases de datos](#distintos-modelos-de-bases-de-datos) | [4](#distintos-modelos-de-bases-de-datos) |
| [Referencias](#referencias) | [7](#referencias) |

# Tarea 1.1: Fundamentos, objetivos y modelos de bases de datos 

## Mapa conceptual sobre los conceptos fundamentales, objetivos, usos y aplicaciones de las bases de datos 

 (infranet, s.f.) (epitech, s.f.) (immune, s.f.) (studocudocument, s.f.) (godaddy, s.f.) 

## Distintos modelos de bases de datos 

| **Modelo de Base de Datos**  | **Definición**  | **Estructura representacional de Datos**  |
| --- | --- | --- |
| **Modelo de relación**  | Ordena la información en tablas de dos dimensiones vinculadas mediante relaciones. Garantiza la consistencia e integridad de los datos a través de reglas estandarizadas.  | **Tablas (Relaciones):** Compuestas por filas (tuplas) y columnas (campos/atributos). Se representan vínculos utilizando claves primarias (𝑃𝐾) y claves externas/foráneas (𝐹𝐾).  |
| **Modelo Jerárquico**  | Organiza la información en una estructura que asemeja un árbol invertido, donde cada registro tiene un nodo raíz del que se desprenden ramas. Cada nodo hijo tiene un único nodo padre.  | **Estructura de Árbol / Nodos Padre-Hijo:** Mantiene relaciones estrictas de uno a muchos (1: 𝑁). El recorrido de los datos se realiza ordenadamente desde la raíz hacia los nodos hojas.  |
| **Modelo en Red**  | Evolución del modelo jerárquico que permite relaciones más complejas de uno a muchos y de muchos a muchos entre registros vinculados, admitiendo nodos principales múltiples.  | **Conjuntos y Grafos:** Punteros directos que conectan registros propietarios (principales) con registros miembros (secundarios), permitiendo que un nodo hijo tenga múltiples padres.  |
| **Modelo Plano (Flat File)**  | Estructura bidimensional sencilla (precursora del modelo relacional) en la que todos los registros se almacenan en un único archivo sin relaciones externas ni enlaces interconectados.  | **Matriz o Archivo de Texto:** Una sola tabla/archivo donde los elementos de la misma columna comparten el mismo tipo de dato y las filas representan entradas de datos relacionadas por delimitadores (ej. CSV, TXT).  |
| **Modelo Orientado a Objetos**  | Colección de objetos utilizados en la programación orientada a objetos (C++, Java, etc.), almacenando información detallada integrando características y comportamiento.  | **Objetos y Clases:** Estructuras que encapsulan estado (atributos/campos) y operaciones (métodos/mensajes), soportando abstracción, herencia y polimorfismo.  |
| **Modelo Relacional de Objetos**  | Modelo híbrido que combina la estructura del modelo relacional con las capacidades del modelo  | **Tablas extendidas con Objetos:** Filas convencionales que pueden albergar tipos de datos definidos por el usuario, arreglos anidados, clases,  |

|  | orientado a objetos para admitir estructuras más complejas y escalables.  | relaciones de herencia y referencias a objetos.  |
| --- | --- | --- |
| **Modelo Entidad-Relación (E-R)**  | Diagrama conceptual y paso previo al modelo relacional. Se elabora para identificar los elementos clave del mundo real que se representarán en el sistema y cómo se vinculan.  | **Diagrama conceptual E-R:** • **Entidades:** Rectángulos. • **Atributos:** Óvalos (con clave distintiva). • **Relaciones:** Rombos. • **Cardinalidad:** Conexiones 1: 1, 1: N o N: M.  |
| **Modelo de Archivo Invertido**  | Diseñado como una tabla de consulta para búsquedas rápidas, donde los elementos almacenados sirven como claves de índice que apuntan a la ubicación exacta de los datos.  | **Índices y Punteros:** Listas indexadas donde cada término clave o palabra contiene referencias y punteros directos hacia la posición de los documentos o registros fuente.  |
| **Modelo Multidimensional**  | Diseñado para aplicaciones de procesamiento analítico en línea (OLAP), permitiendo extraer y consolidar métricas de negocios rápidamente desde múltiples perspectivas.  | **Cubos de Datos:** Celdas interconectadas donde los ejes representan dimensiones (ej. tiempo, región, producto) y el contenido interior equivale al valor numérico de la **métrica o hecho**.  |
| **Modelo Semiestructurado**  | Se aplica a datos que no se ajustan al formato rígido de tablas, filas y columnas. Organiza la información mediante etiquetas que crean jerarquías sin separar el dato de su esquema.  | **Árboles Jerárquicos con Marcadores:** Estructuras flexibles basadas en etiquetas y pares clave-valor donde el esquema está embebido junto a los propios datos (ej. JSON, XML, YAML).  |
| **Modelo de Contexto**  | Arquitectura flexible que incorpora elementos de varios modelos (orientado a objetos, semiestructurados y en red) para adaptar y recuperar datos según el estado o entorno del sistema.  | **Grafos y Redes de Metadatos:** Redes interconectadas de entidades y asociaciones enriquecidas con atributos contextuales (roles de usuario, ubicación, tiempos y estados).  |
| **Modelo Asociativo**  | Divide toda la información en dos grupos independientes: entidades y asociaciones, permitiendo registrar datos sin necesidad de diseñar  | **Elementos y Enlaces:** • **Elementos:** Poseen ID único, nombre y tipo. • **Enlaces:** Registran tripletas (Fuente - Verbo - Objeto) compuestas por los identificadores de los elementos.  |

|  | esquemas de tablas prefijadas.  |  |
| --- | --- | --- |
| **Modelos NoSQL**  | Conjunto diverso de modelos no relacionales diseñados para alta disponibilidad, escalabilidad horizontal y gestión de grandes volúmenes de datos no estructurados o Big Data.  | **Formatos Varios:** • **Documental:** Documentos JSON/BSON. • **Clave-Valor:** Diccionarios directos. • **Grafos:** Nodos, aristas y propiedades. • **Multivalor / Columnas:** Familias de columnas.  |

(godaddy, s.f.) (descubreradius, s.f.) (ayudaleypro, s.f.) (arsys, s.f.) 

# Referencias 

_arsys_. (s.f.). Obtenido de https://www.arsys.es/blog/tipos-de-bases-de-datos-que-existen 

_ayudaleypro_. (s.f.). Obtenido de https://ayudaleyprotecciondatos.es/bases-de-datos/modelos/ 

_descubreradius_. (s.f.). Obtenido de https://descubreradius.com/blog/modelos-de-base-de-datos 

_epitech_. (s.f.). Obtenido de https://www.epitech-it.es/base-de-datos/ 

_godaddy_. (s.f.). Obtenido de https://www.godaddy.com/resources/latam/stories/que-es-una-base-de-datos 

_immune_. (s.f.). Obtenido de https://immune.institute/blog/base-de-datos-que-es-usos/ 

_infranet_. (s.f.). Obtenido de https://blog.infranetworking.com/objetivos-base-de-datos/ 

_studocudocument_. (s.f.). Obtenido de https://www.studocu.com/es-mx/document/universidad-tecnologica-de-tabasco/base-de-datos/introduccion-a-las-bases-de-datos/32573382?sid=%24device%3A19345b4ab241471-0c14e610f2a36c-46524258-144000-19345b4ab2414711787798340 
