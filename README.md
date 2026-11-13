# Help Desk Ticket Manager — Proyecto SQL

**Nivel:** SQL básico con ejercicios de profundización (proyecto de práctica)  
**Motor:** SQLite  
**Área:** Help Desk / IT Support

## Objetivo

Crear una base de datos para registrar solicitudes de soporte IT, usuarios, técnicos, categorías e historial de cambios de estado. Permite practicar CREATE TABLE, claves primarias y foráneas, INSERT, SELECT, WHERE, ORDER BY, JOIN, GROUP BY, HAVING, subconsultas, EXISTS, CTE, CASE, funciones de fecha y funciones de ventana.

> Proyecto educativo con datos ficticios. No representa experiencia laboral ni utiliza datos de una empresa real.

## Archivos

- `01_schema.sql`: crea las tablas y relaciones principales.
- `02_datos_ejemplo.sql`: carga datos ficticios.
- `03_consultas.sql`: consultas para analizar tickets.
- `04_retos.sql`: ejercicios para continuar practicando.
- `05_diagrama_er.md`: diagrama entidad-relación y explicación de las relaciones.
- `06_consultas_intermedias.sql`: ejercicios con HAVING, subconsultas, EXISTS y análisis didáctico de tiempos de resolución.
- `07_resultados_consultas.md`: resultados de ejemplo, interpretación operativa y guía para reproducir consultas.
- `08_historial_estados.sql`: agrega la tabla de historial, eventos ficticios de muestra y consultas para analizar transiciones y duración de estados.

## Cómo ejecutar el proyecto desde cero

1. Instalar [DB Browser for SQLite](https://sqlitebrowser.org/).
2. Crear una base de datos llamada `helpdesk.db`.
3. Ejecutar, en este orden, `01_schema.sql`, `02_datos_ejemplo.sql` y `08_historial_estados.sql`.
4. Ejecutar `03_consultas.sql` y `06_consultas_intermedias.sql` para practicar consultas.

Desde la terminal, dentro de esta carpeta:

```bash
sqlite3 helpdesk.db < 01_schema.sql
sqlite3 helpdesk.db < 02_datos_ejemplo.sql
sqlite3 helpdesk.db < 03_consultas.sql
sqlite3 helpdesk.db < 06_consultas_intermedias.sql
sqlite3 helpdesk.db < 08_historial_estados.sql
```

Si ya tenés una base creada y cargada, ejecutá solamente `08_historial_estados.sql` para agregar la nueva tabla y sus ejemplos. El script usa `CREATE TABLE IF NOT EXISTS` e `INSERT OR IGNORE` para evitar duplicar los eventos de muestra al volver a ejecutarlo.

## Modelo de datos

- **usuarios:** personas que reportan incidentes.
- **tecnicos:** personal que atiende solicitudes.
- **categorias:** clasificación del problema.
- **tickets:** solicitudes con estado, prioridad, fechas y responsables.
- **historial_tickets:** eventos que registran el estado anterior, el nuevo estado, fecha, actor y comentario.

Consulta el [diagrama entidad-relación](05_diagrama_er.md) para visualizar las tablas, claves y relaciones.

## Consultas y habilidades practicadas

1. Listar y filtrar tickets por estado, prioridad y fecha.
2. Relacionar tickets con usuarios, técnicos y categorías (JOIN).
3. Agrupar y contar tickets (GROUP BY y HAVING).
4. Identificar tickets sin técnico asignado.
5. Calcular tiempos promedio de resolución con funciones de fecha.
6. Practicar subconsultas, EXISTS, CTE y CASE.
7. Comparar tiempos de resolución con objetivos SLA ilustrativos.
8. Consultar el historial cronológico de un ticket.
9. Contar eventos registrados por ticket.
10. Calcular duración aproximada de cada estado usando `LEAD()`.
11. Comparar el último estado del historial con el estado actual del ticket usando `ROW_NUMBER()`.

## Resultados y evidencias

El archivo [07_resultados_consultas.md](07_resultados_consultas.md) documenta resultados de consultas sobre los datos ficticios. Para el historial, ejecutá las consultas incluidas al final de `08_historial_estados.sql` desde **Execute SQL** en DB Browser for SQLite.

Para obtener capturas propias, ejecutá las consultas y capturá la grilla de resultados. No se presentan capturas simuladas como si fueran evidencia de una ejecución en tu equipo.

## Alcance del historial

Los eventos incluidos en `08_historial_estados.sql` son ejemplos didácticos y no reconstruyen un historial real. El archivo agrega la tabla sin modificar ni eliminar las cuatro tablas principales. Los ejemplos cubren tickets seleccionados y sus secuencias terminan en el estado actual que figura en `tickets`.

La duración de la última etapa de un ticket que sigue abierto no puede calcularse como un intervalo cerrado porque todavía no existe una fecha de finalización. El ejercicio devuelve NULL en ese caso. El historial tampoco modela pausas, horarios hábiles ni reglas de SLA.

## Alcance del análisis SLA

Los objetivos por prioridad del archivo `06_consultas_intermedias.sql` (4, 8, 24 y 48 horas) son valores ficticios definidos únicamente para practicar; no son compromisos ni políticas reales. El esquema no registra la fecha de primera respuesta ni almacena políticas SLA. Por eso no permite medir el tiempo de primera respuesta ni certificar cumplimiento SLA real.

## Cómo presentarlo en una entrevista

“Es un proyecto personal de práctica con SQLite orientado a soporte IT. Diseñé tablas relacionadas para usuarios, técnicos, categorías y tickets. Practiqué consultas para filtrar incidentes, relacionar información, agrupar resultados, analizar tiempos y registrar cambios de estado. Los datos y eventos son ficticios y el objetivo es demostrar aprendizaje práctico de SQL.”

## Próximas mejoras

- Agregar fecha de primera respuesta y políticas SLA configurables.
- Incorporar reglas para horarios hábiles y pausas de SLA.
- Crear un dashboard con métricas de tickets.
- Migrar el esquema a PostgreSQL.
