# Resultados de consultas — Help Desk Ticket Manager

Este documento muestra resultados reproducibles obtenidos con las consultas del proyecto y los 12 tickets ficticios cargados en `02_datos_ejemplo.sql`.

> **Importante:** los resultados son de práctica. Los registros no pertenecen a una empresa real ni representan experiencia laboral.

## Cómo reproducir los resultados

1. Abrir DB Browser for SQLite y crear o abrir `helpdesk.db`.
2. Ejecutar, en este orden, `01_schema.sql` y `02_datos_ejemplo.sql`.
3. Abrir la pestaña **Execute SQL**.
4. Cargar `03_consultas.sql` o `06_consultas_intermedias.sql` y ejecutar la consulta que se desea revisar.
5. Comparar la grilla de resultados con los ejemplos de este documento.

DB Browser for SQLite permite ejecutar consultas y revisar sus resultados en una grilla. También permite exportar datos a CSV desde su interfaz.

## 1. Distribución de tickets por categoría

**Conceptos:** `JOIN`, `GROUP BY`, `HAVING`, `COUNT`.

| Categoría | Tickets |
|---|---:|
| Hardware | 3 |
| Software | 3 |
| Correo | 2 |
| Cuentas y accesos | 2 |
| Redes | 2 |

**Interpretación:** Hardware y Software concentran la mayor cantidad de solicitudes en estos datos. Esto podría ayudar a priorizar documentación o guías de resolución, aunque la muestra es pequeña y ficticia.

## 2. Tickets cerrados por técnico

**Conceptos:** `JOIN`, `WHERE`, `GROUP BY`, `HAVING`.

| Técnico | Tickets cerrados |
|---|---:|
| Diego Fernández | 2 |
| Paula Herrera | 2 |

**Interpretación:** ambos técnicos tienen dos tickets cerrados en el conjunto de práctica. Carla Méndez tiene uno, por eso no aparece en la consulta que exige dos o más.

## 3. Tickets por departamento

**Conceptos:** `JOIN`, `GROUP BY`, `HAVING`.

| Departamento | Tickets |
|---|---:|
| Administración | 4 |
| Logística | 2 |
| Marketing | 2 |
| Recursos Humanos | 2 |
| Ventas | 2 |

**Interpretación:** Administración registra más solicitudes. En un entorno real convendría analizar el volumen durante un período mayor y considerar la cantidad de usuarios por departamento.

## 4. Tiempo promedio de resolución

**Concepto:** `julianday()` y `AVG()`.

| Indicador | Resultado |
|---|---:|
| Tickets cerrados evaluados | 5 |
| Tiempo promedio | 70 minutos |

**Interpretación:** el promedio se calcula desde `fecha_creacion` hasta `fecha_cierre`, únicamente para tickets cerrados con fecha de cierre registrada. No representa el tiempo de primera respuesta.

## 5. Comparación didáctica de objetivos de resolución

Los objetivos usados en `06_consultas_intermedias.sql` son valores de ejemplo definidos para practicar: Crítica 4 h, Alta 8 h, Media 24 h y Baja 48 h.

| Ticket | Prioridad | Resolución | Objetivo de práctica | Resultado |
|---|---|---:|---:|---|
| Restablecer contraseña | Media | 35 min | 1.440 min | Dentro |
| Configurar correo | Baja | 70 min | 2.880 min | Dentro |
| Acceso a carpeta compartida | Baja | 20 min | 2.880 min | Dentro |
| Instalar herramienta | Media | 45 min | 1.440 min | Dentro |
| Equipo muy lento | Media | 180 min | 1.440 min | Dentro |

**Resumen:** 5 de 5 tickets cerrados quedan dentro de los umbrales ficticios definidos para el ejercicio. El 100% es un resultado de esta muestra, no una medición de cumplimiento SLA real.

## 6. Porcentaje dentro del objetivo por prioridad

| Prioridad | Tickets evaluados | Dentro del objetivo | Porcentaje |
|---|---:|---:|---:|
| Media | 3 | 3 | 100% |
| Baja | 2 | 2 | 100% |

No aparecen prioridades Alta o Crítica porque no hay tickets cerrados de esas prioridades en los datos actuales.

## 7. Qué muestran estos ejercicios

- `HAVING` permite filtrar grupos después de aplicar agregaciones.
- Las subconsultas permiten comparar cada ticket o técnico con un promedio calculado.
- `EXISTS` permite detectar usuarios que tienen tickets sin cerrar.
- `julianday()` permite calcular diferencias entre fechas en SQLite.
- `CASE` permite clasificar resultados según una condición.

## 8. Limitaciones y mejoras futuras

El esquema actual no almacena `fecha_primera_respuesta`, por lo que no permite calcular el tiempo de primera respuesta. Tampoco contiene una tabla de políticas SLA reales ni registra pausas, horarios hábiles o cambios de prioridad.

Una mejora mínima sería agregar `fecha_primera_respuesta` a `tickets`. Para administrar objetivos configurables, se podría incorporar más adelante una tabla `politicas_sla`. No se agregan esos campos en esta etapa para mantener la coherencia con el esquema SQLite actual.

---

**Alcance:** proyecto personal educativo de SQL básico e intermedio con SQLite y datos ficticios.
