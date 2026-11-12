-- 1. Listar todos los tickets
SELECT ticket_id, titulo, estado, prioridad, fecha_creacion
FROM tickets
ORDER BY fecha_creacion DESC;

-- 2. Tickets que requieren seguimiento
SELECT ticket_id, titulo, estado, prioridad
FROM tickets
WHERE estado IN ('Abierto', 'En progreso', 'En espera')
ORDER BY CASE prioridad
    WHEN 'Crítica' THEN 1 WHEN 'Alta' THEN 2
    WHEN 'Media' THEN 3 ELSE 4 END;

-- 3. Tickets de prioridad alta o crítica
SELECT ticket_id, titulo, prioridad, estado
FROM tickets
WHERE prioridad IN ('Alta', 'Crítica');

-- 4. Tickets con usuario, técnico y categoría
SELECT t.ticket_id, t.titulo, u.nombre AS usuario,
       COALESCE(te.nombre, 'Sin asignar') AS tecnico,
       c.nombre AS categoria, t.estado, t.prioridad
FROM tickets AS t
JOIN usuarios AS u ON t.usuario_id = u.usuario_id
LEFT JOIN tecnicos AS te ON t.tecnico_id = te.tecnico_id
JOIN categorias AS c ON t.categoria_id = c.categoria_id
ORDER BY t.ticket_id;

-- 5. Cantidad de tickets por estado
SELECT estado, COUNT(*) AS cantidad
FROM tickets GROUP BY estado ORDER BY cantidad DESC;

-- 6. Cantidad de tickets por prioridad
SELECT prioridad, COUNT(*) AS cantidad
FROM tickets GROUP BY prioridad ORDER BY cantidad DESC;

-- 7. Tickets sin técnico asignado
SELECT ticket_id, titulo, estado, prioridad
FROM tickets WHERE tecnico_id IS NULL;

-- 8. Tiempo promedio de resolución en minutos
SELECT ROUND(AVG((julianday(fecha_cierre) - julianday(fecha_creacion)) * 1440), 1)
       AS promedio_minutos_resolucion
FROM tickets
WHERE estado = 'Cerrado' AND fecha_cierre IS NOT NULL;

-- 9. Tickets creados durante octubre de 2026
SELECT ticket_id, titulo, fecha_creacion
FROM tickets
WHERE fecha_creacion >= '2026-10-01'
  AND fecha_creacion < '2026-11-01'
ORDER BY fecha_creacion;

-- 10. Carga de trabajo por técnico
SELECT te.nombre AS tecnico, te.nivel, COUNT(t.ticket_id) AS tickets_asignados
FROM tecnicos AS te
LEFT JOIN tickets AS t ON te.tecnico_id = t.tecnico_id
GROUP BY te.tecnico_id, te.nombre, te.nivel
ORDER BY tickets_asignados DESC;

-- 11. Tickets por departamento
SELECT u.departamento, COUNT(t.ticket_id) AS total_tickets
FROM usuarios AS u
JOIN tickets AS t ON u.usuario_id = t.usuario_id
GROUP BY u.departamento ORDER BY total_tickets DESC;

-- 12. Casos abiertos de prioridad crítica
SELECT ticket_id, titulo, fecha_creacion
FROM tickets
WHERE estado <> 'Cerrado' AND prioridad = 'Crítica';
