-- Help Desk Ticket Manager | Consultas de profundización
-- Motor: SQLite
-- Nivel: práctica básica-intermedia
-- Todos los datos son ficticios.
--
-- Antes de ejecutar:
-- 1. Ejecutar 01_schema.sql.
-- 2. Ejecutar 02_datos_ejemplo.sql.
-- 3. Ejecutar este archivo.
--
-- Los objetivos de SLA de los ejercicios 7 y 8 son umbrales DIDÁCTICOS
-- definidos aquí para practicar SQL. No son políticas reales de una empresa.

-- =========================================================
-- 1. HAVING: categorías con más de un ticket
-- GROUP BY agrupa los tickets por categoría.
-- HAVING filtra los grupos después de calcular COUNT.
-- =========================================================
SELECT
    c.nombre AS categoria,
    COUNT(t.ticket_id) AS total_tickets
FROM categorias AS c
JOIN tickets AS t ON t.categoria_id = c.categoria_id
GROUP BY c.categoria_id, c.nombre
HAVING COUNT(t.ticket_id) > 1
ORDER BY total_tickets DESC, categoria;

-- =========================================================
-- 2. HAVING: técnicos con dos o más tickets cerrados
-- Se cuentan solamente los tickets cuyo estado es Cerrado.
-- =========================================================
SELECT
    te.nombre AS tecnico,
    COUNT(t.ticket_id) AS tickets_cerrados
FROM tecnicos AS te
JOIN tickets AS t ON t.tecnico_id = te.tecnico_id
WHERE t.estado = 'Cerrado'
GROUP BY te.tecnico_id, te.nombre
HAVING COUNT(t.ticket_id) >= 2
ORDER BY tickets_cerrados DESC;

-- =========================================================
-- 3. HAVING: departamentos con al menos dos tickets
-- Permite detectar qué departamentos generan más solicitudes.
-- =========================================================
SELECT
    u.departamento,
    COUNT(t.ticket_id) AS total_tickets
FROM usuarios AS u
JOIN tickets AS t ON t.usuario_id = u.usuario_id
GROUP BY u.departamento
HAVING COUNT(t.ticket_id) >= 2
ORDER BY total_tickets DESC, u.departamento;

-- =========================================================
-- 4. SUBCONSULTA: tickets cerrados cuya resolución superó
-- el promedio general de resolución de los tickets cerrados.
-- La subconsulta calcula el promedio y la consulta externa compara.
-- =========================================================
SELECT
    t.ticket_id,
    t.titulo,
    ROUND(
        (julianday(t.fecha_cierre) - julianday(t.fecha_creacion)) * 1440,
        1
    ) AS minutos_resolucion
FROM tickets AS t
WHERE t.estado = 'Cerrado'
  AND t.fecha_cierre IS NOT NULL
  AND (julianday(t.fecha_cierre) - julianday(t.fecha_creacion)) * 1440 >
      (
          SELECT AVG(
              (julianday(fecha_cierre) - julianday(fecha_creacion)) * 1440
          )
          FROM tickets
          WHERE estado = 'Cerrado'
            AND fecha_cierre IS NOT NULL
      )
ORDER BY minutos_resolucion DESC;

-- =========================================================
-- 5. EXISTS: usuarios que tienen al menos un ticket no cerrado.
-- EXISTS comprueba si la subconsulta devuelve alguna fila.
-- No duplica usuarios aunque tengan varios tickets pendientes.
-- =========================================================
SELECT
    u.usuario_id,
    u.nombre,
    u.departamento
FROM usuarios AS u
WHERE EXISTS (
    SELECT 1
    FROM tickets AS t
    WHERE t.usuario_id = u.usuario_id
      AND t.estado <> 'Cerrado'
)
ORDER BY u.nombre;

-- =========================================================
-- 6. SUBCONSULTA + HAVING: técnicos con más tickets cerrados
-- que el promedio de tickets cerrados por técnico.
-- Se incluyen técnicos sin tickets cerrados en el cálculo del promedio
-- mediante LEFT JOIN.
-- =========================================================
SELECT
    te.nombre AS tecnico,
    COUNT(t.ticket_id) AS tickets_cerrados
FROM tecnicos AS te
LEFT JOIN tickets AS t
    ON t.tecnico_id = te.tecnico_id
   AND t.estado = 'Cerrado'
GROUP BY te.tecnico_id, te.nombre
HAVING COUNT(t.ticket_id) > (
    SELECT AVG(cantidad)
    FROM (
        SELECT COUNT(t2.ticket_id) AS cantidad
        FROM tecnicos AS te2
        LEFT JOIN tickets AS t2
            ON t2.tecnico_id = te2.tecnico_id
           AND t2.estado = 'Cerrado'
        GROUP BY te2.tecnico_id
    )
)
ORDER BY tickets_cerrados DESC;

-- =========================================================
-- 7. ANÁLISIS DIDÁCTICO DE SLA: detalle por ticket cerrado.
-- Los objetivos de resolución son ejemplos inventados para practicar:
-- Crítica: 4 h | Alta: 8 h | Media: 24 h | Baja: 48 h.
-- Solo se mide creación -> cierre; no se mide primera respuesta.
-- =========================================================
WITH objetivos_sla (prioridad, objetivo_minutos) AS (
    VALUES
        ('Crítica', 240),
        ('Alta', 480),
        ('Media', 1440),
        ('Baja', 2880)
),
tiempos_resolucion AS (
    SELECT
        t.ticket_id,
        t.titulo,
        t.prioridad,
        ROUND(
            (julianday(t.fecha_cierre) - julianday(t.fecha_creacion)) * 1440,
            1
        ) AS minutos_resolucion,
        o.objetivo_minutos
    FROM tickets AS t
    JOIN objetivos_sla AS o ON o.prioridad = t.prioridad
    WHERE t.estado = 'Cerrado'
      AND t.fecha_cierre IS NOT NULL
)
SELECT
    ticket_id,
    titulo,
    prioridad,
    minutos_resolucion,
    objetivo_minutos,
    CASE
        WHEN minutos_resolucion <= objetivo_minutos
            THEN 'Dentro del objetivo de práctica'
        ELSE 'Fuera del objetivo de práctica'
    END AS resultado
FROM tiempos_resolucion
ORDER BY ticket_id;

-- =========================================================
-- 8. ANÁLISIS DIDÁCTICO DE SLA: porcentaje dentro del objetivo
-- agrupado por prioridad. El porcentaje usa solo tickets cerrados
-- que tienen fecha de cierre.
-- =========================================================
WITH objetivos_sla (prioridad, objetivo_minutos) AS (
    VALUES
        ('Crítica', 240),
        ('Alta', 480),
        ('Media', 1440),
        ('Baja', 2880)
),
tiempos_resolucion AS (
    SELECT
        t.prioridad,
        (julianday(t.fecha_cierre) - julianday(t.fecha_creacion)) * 1440
            AS minutos_resolucion,
        o.objetivo_minutos
    FROM tickets AS t
    JOIN objetivos_sla AS o ON o.prioridad = t.prioridad
    WHERE t.estado = 'Cerrado'
      AND t.fecha_cierre IS NOT NULL
)
SELECT
    prioridad,
    COUNT(*) AS tickets_evaluados,
    SUM(
        CASE WHEN minutos_resolucion <= objetivo_minutos THEN 1 ELSE 0 END
    ) AS dentro_objetivo,
    ROUND(
        100.0 * SUM(
            CASE WHEN minutos_resolucion <= objetivo_minutos THEN 1 ELSE 0 END
        ) / COUNT(*),
        1
    ) AS porcentaje_dentro_objetivo
FROM tiempos_resolucion
GROUP BY prioridad
ORDER BY CASE prioridad
    WHEN 'Crítica' THEN 1
    WHEN 'Alta' THEN 2
    WHEN 'Media' THEN 3
    ELSE 4
END;

-- NOTA SOBRE SLA:
-- El esquema actual no guarda la fecha de primera respuesta ni una tabla
-- de políticas SLA. Por eso estos ejercicios solo comparan el tiempo de
-- resolución de tickets cerrados contra umbrales de ejemplo definidos
-- en este archivo. No representan cumplimiento SLA real.
