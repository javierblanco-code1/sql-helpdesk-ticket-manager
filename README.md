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
- `05_diagrama_er.md`: diagrama entidad-relación y explicación de las relaciones.\n- `06_consultas_intermedias.sql`: ejercicios resueltos con HAVING, subconsultas, EXISTS y análisis didáctico de tiempos de resolución.

## Cómo ejecutarlo
1. Instalar [DB Browser for SQLite](https://sqlitebrowser.org/) o SQLite.
2. Crear una base de datos llamada `helpdesk.db`.
3. Ejecutar `01_schema.sql`.
4. Ejecutar `02_datos_ejemplo.sql`.
5. Ejecutar las consultas de `03_consultas.sql`.\n6. Ejecutar `06_consultas_intermedias.sql` para practicar consultas de profundización.

Desde la terminal, dentro de esta carpeta:

```bash
sqlite3 helpdesk.db < 01_schema.sql
sqlite3 helpdesk.db < 02_datos_ejemplo.sql
sqlite3 helpdesk.db < 03_consultas.sql\nsqlite3 helpdesk.db < 06_consultas_intermedias.sql
```

## Modelo de datos
- **usuarios:** personas que reportan incidentes.
- **tecnicos:** personal que atiende solicitudes.
- **categorias:** clasificación del problema.
- **tickets:** solicitudes con estado, prioridad, fechas y responsables.

## Diagrama de la base de datos

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
9. Ver carga de trabajo por técnico y departamento.\n10. Profundizar con HAVING, subconsultas y EXISTS.\n11. Comparar tiempos de resolución con objetivos SLA ilustrativos.

## Alcance del análisis SLA\n\nEl archivo `06_consultas_intermedias.sql` incluye un ejercicio de comparación del tiempo entre creación y cierre de tickets cerrados. Los objetivos por prioridad (4, 8, 24 y 48 horas) son valores ficticios definidos únicamente para practicar; no son compromisos ni políticas reales.\n\nEl esquema actual no registra la fecha de primera respuesta ni almacena políticas SLA. Por eso no permite medir el tiempo de primera respuesta ni certificar el cumplimiento de un SLA real. Como mejora futura, se puede agregar `fecha_primera_respuesta` a `tickets` y crear una tabla `politicas_sla` con objetivos de respuesta y resolución por prioridad.\n\n## Cómo presentarlo en una entrevista
“Es un proyecto personal de práctica con SQLite orientado a soporte IT. Diseñé tablas relacionadas para usuarios, técnicos, categorías y tickets. Practiqué consultas para filtrar incidentes, priorizar casos, relacionar información y obtener métricas básicas de soporte.”

## Próximas mejoras
- Agregar historial de cambios de estado.
- Agregar `fecha_primera_respuesta` y una tabla `politicas_sla` para modelar objetivos de SLA configurables.
- Crear un dashboard.
- Migrar el esquema a PostgreSQL.
