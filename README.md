# Help Desk Ticket Manager — Proyecto SQL

**Nivel:** SQL básico con ejercicios de profundización (proyecto de práctica)  
**Motor:** SQLite  
**Área:** Help Desk / IT Support

## Objetivo

Crear una base de datos para registrar solicitudes de soporte IT, usuarios, técnicos y categorías. Permite practicar CREATE TABLE, claves primarias y foráneas, INSERT, SELECT, WHERE, ORDER BY, JOIN, GROUP BY, HAVING, subconsultas, EXISTS, CTE, CASE y funciones de fecha.

> Proyecto educativo con datos ficticios. No representa experiencia laboral ni utiliza datos de una empresa real.

## Archivos

- `01_schema.sql`: crea las tablas y relaciones.
- `02_datos_ejemplo.sql`: carga datos ficticios.
- `03_consultas.sql`: consultas para analizar tickets.
- `04_retos.sql`: ejercicios para continuar practicando.
- `05_diagrama_er.md`: diagrama entidad-relación y explicación de las relaciones.
- `06_consultas_intermedias.sql`: ejercicios resueltos con HAVING, subconsultas, EXISTS y análisis didáctico de tiempos de resolución.
- `07_resultados_consultas.md`: resultados de ejemplo, interpretación operativa y guía para reproducir las consultas.

## Cómo ejecutarlo

1. Instalar [DB Browser for SQLite](https://sqlitebrowser.org/).
2. Crear una base de datos llamada `helpdesk.db`.
3. Ejecutar `01_schema.sql`.
4. Ejecutar `02_datos_ejemplo.sql`.
5. Ejecutar las consultas de `03_consultas.sql`.
6. Ejecutar `06_consultas_intermedias.sql` para practicar consultas de profundización.
7. Consultar [07_resultados_consultas.md](07_resultados_consultas.md) para comparar resultados y revisar su interpretación.

Desde la terminal, dentro de esta carpeta:

```bash
sqlite3 helpdesk.db < 01_schema.sql
sqlite3 helpdesk.db < 02_datos_ejemplo.sql
sqlite3 helpdesk.db < 03_consultas.sql
sqlite3 helpdesk.db < 06_consultas_intermedias.sql
```

## Modelo de datos

- **usuarios:** personas que reportan incidentes.
- **tecnicos:** personal que atiende solicitudes.
- **categorias:** clasificación del problema.
- **tickets:** solicitudes con estado, prioridad, fechas y responsables.

Consulta el [diagrama entidad-relación](05_diagrama_er.md) para visualizar las tablas, claves y relaciones.

## Consultas incluidas

1. Listar tickets.
2. Ver tickets abiertos o en progreso.
3. Filtrar prioridades altas o críticas.
4. Relacionar tickets con usuarios, técnicos y categorías (JOIN).
5. Contar tickets por estado y prioridad.
6. Identificar tickets sin técnico asignado.
7. Calcular tiempo promedio de resolución.
8. Consultar tickets por rango de fechas.
9. Ver carga de trabajo por técnico y departamento.
10. Profundizar con HAVING, subconsultas y EXISTS.
11. Comparar tiempos de resolución con objetivos SLA ilustrativos.

## Resultados y evidencias

El archivo [07_resultados_consultas.md](07_resultados_consultas.md) documenta los resultados obtenidos con los datos ficticios y explica qué puede interpretarse desde la operación de un Help Desk. Incluye distribución por categoría y departamento, tickets cerrados por técnico y tiempos de resolución.

Para obtener capturas propias, abrí DB Browser for SQLite, ejecutá las consultas en **Execute SQL** y capturá la grilla de resultados. No se presentan capturas simuladas como si fueran evidencia de una ejecución en tu equipo.

## Alcance del análisis SLA

El archivo `06_consultas_intermedias.sql` incluye un ejercicio de comparación del tiempo entre creación y cierre de tickets cerrados. Los objetivos por prioridad (4, 8, 24 y 48 horas) son valores ficticios definidos únicamente para practicar; no son compromisos ni políticas reales.

El esquema actual no registra la fecha de primera respuesta ni almacena políticas SLA. Por eso no permite medir el tiempo de primera respuesta ni certificar el cumplimiento de un SLA real. Como mejora futura, se puede agregar `fecha_primera_respuesta` a `tickets` y crear una tabla `politicas_sla` con objetivos de respuesta y resolución por prioridad.

## Cómo presentarlo en una entrevista

“Es un proyecto personal de práctica con SQLite orientado a soporte IT. Diseñé tablas relacionadas para usuarios, técnicos, categorías y tickets. Practiqué consultas para filtrar incidentes, priorizar casos, relacionar información y obtener métricas básicas de soporte. También documenté resultados y limitaciones de un análisis didáctico de tiempos de resolución.”

## Próximas mejoras

- Agregar historial de cambios de estado.
- Agregar `fecha_primera_respuesta` y una tabla `politicas_sla` para modelar objetivos de SLA configurables.
- Crear un dashboard.
- Migrar el esquema a PostgreSQL.
