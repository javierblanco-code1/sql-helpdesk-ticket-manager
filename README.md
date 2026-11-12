# Help Desk Ticket Manager — Proyecto SQL

**Nivel:** SQL básico (proyecto de práctica)  
**Motor:** SQLite  
**Área:** Help Desk / IT Support

## Objetivo
Crear una base de datos para registrar solicitudes de soporte IT, usuarios, técnicos y categorías. Permite practicar CREATE TABLE, claves primarias y foráneas, INSERT, SELECT, WHERE, ORDER BY, JOIN, GROUP BY, COUNT y AVG.

> Proyecto educativo con datos ficticios. No representa experiencia laboral ni utiliza datos de una empresa real.

## Archivos
- `01_schema.sql`: crea las tablas y relaciones.
- `02_datos_ejemplo.sql`: carga datos ficticios.
- `03_consultas.sql`: consultas para analizar tickets.
- `04_retos.sql`: ejercicios para continuar practicando.
- `05_diagrama_er.md`: diagrama entidad-relación y explicación de las relaciones.

## Cómo ejecutarlo
1. Instalar [DB Browser for SQLite](https://sqlitebrowser.org/) o SQLite.
2. Crear una base de datos llamada `helpdesk.db`.
3. Ejecutar `01_schema.sql`.
4. Ejecutar `02_datos_ejemplo.sql`.
5. Ejecutar las consultas de `03_consultas.sql`.

Desde la terminal, dentro de esta carpeta:

```bash
sqlite3 helpdesk.db < 01_schema.sql
sqlite3 helpdesk.db < 02_datos_ejemplo.sql
sqlite3 helpdesk.db < 03_consultas.sql
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
9. Ver carga de trabajo por técnico y departamento.

## Cómo presentarlo en una entrevista
“Es un proyecto personal de práctica con SQLite orientado a soporte IT. Diseñé tablas relacionadas para usuarios, técnicos, categorías y tickets. Practiqué consultas para filtrar incidentes, priorizar casos, relacionar información y obtener métricas básicas de soporte.”

## Próximas mejoras
- Agregar historial de cambios de estado.
- Incorporar consultas para SLA.
- Crear un dashboard.
- Migrar el esquema a PostgreSQL.
