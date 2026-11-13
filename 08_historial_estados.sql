-- Help Desk Ticket Manager | Historial de cambios de estado
-- SQLite | Ejercicio educativo con eventos ficticios
--
-- Requisitos: ejecutar 01_schema.sql y 02_datos_ejemplo.sql antes de este archivo.
-- Este archivo es aditivo: no elimina ni modifica las tablas existentes.
-- Los eventos insertados son ejemplos didácticos, no un historial real.

PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS historial_tickets (
    historial_id INTEGER PRIMARY KEY AUTOINCREMENT,
    ticket_id INTEGER NOT NULL,
    estado_anterior TEXT
        CHECK (estado_anterior IS NULL OR estado_anterior IN
            ('Abierto', 'En progreso', 'En espera', 'Cerrado')),
    estado_nuevo TEXT NOT NULL
        CHECK (estado_nuevo IN ('Abierto', 'En progreso', 'En espera', 'Cerrado')),
    fecha_cambio TEXT NOT NULL,
    realizado_por TEXT NOT NULL,
    rol_actor TEXT NOT NULL
        CHECK (rol_actor IN ('Técnico', 'Usuario', 'Administrador', 'Sistema')),
    tecnico_id INTEGER,
    comentario TEXT,
    FOREIGN KEY (ticket_id) REFERENCES tickets(ticket_id),
    FOREIGN KEY (tecnico_id) REFERENCES tecnicos(tecnico_id),
    UNIQUE (ticket_id, fecha_cambio),
    CHECK (estado_anterior IS NULL OR estado_anterior <> estado_nuevo)
);

CREATE INDEX IF NOT EXISTS idx_historial_ticket_fecha
    ON historial_tickets(ticket_id, fecha_cambio);

-- Eventos sintéticos de muestra.
-- Cada secuencia termina en el estado actual del ticket correspondiente.
-- INSERT OR IGNORE evita duplicar el mismo evento si se ejecuta el archivo otra vez.
INSERT OR IGNORE INTO historial_tickets
(ticket_id, estado_anterior, estado_nuevo, fecha_cambio, realizado_por, rol_actor, tecnico_id, comentario)
VALUES
(1, NULL, 'Abierto',     '2026-10-01 08:30:00', 'Sistema',       'Sistema',       NULL, 'Creación del ticket'),
(1, 'Abierto', 'En progreso', '2026-10-01 09:00:00', 'Carla Méndez', 'Técnico', 1, 'Inicio de diagnóstico'),

(2, NULL, 'Abierto',     '2026-10-01 09:15:00', 'Sistema',       'Sistema',       NULL, 'Creación del ticket'),

(3, NULL, 'Abierto',     '2026-10-01 10:00:00', 'Sistema',       'Sistema',       NULL, 'Creación del ticket'),
(3, 'Abierto', 'En progreso', '2026-10-01 10:10:00', 'Diego Fernández', 'Técnico', 2, 'Revisión de la cuenta'),
(3, 'En progreso', 'Cerrado', '2026-10-01 10:35:00', 'Diego Fernández', 'Técnico', 2, 'Contraseña restablecida'),

(4, NULL, 'Abierto',     '2026-10-02 11:20:00', 'Sistema',       'Sistema',       NULL, 'Creación del ticket'),
(4, 'Abierto', 'En progreso', '2026-10-02 11:45:00', 'Carla Méndez', 'Técnico', 1, 'Análisis del error'),
(4, 'En progreso', 'En espera', '2026-10-02 12:00:00', 'Carla Méndez', 'Técnico', 1, 'Pendiente de información'),

(5, NULL, 'Abierto',     '2026-10-02 12:00:00', 'Sistema',       'Sistema',       NULL, 'Creación del ticket'),
(5, 'Abierto', 'En progreso', '2026-10-02 12:20:00', 'Diego Fernández', 'Técnico', 2, 'Configuración inicial'),
(5, 'En progreso', 'Cerrado', '2026-10-02 13:10:00', 'Diego Fernández', 'Técnico', 2, 'Sincronización comprobada'),

(6, NULL, 'Abierto',     '2026-10-03 08:05:00', 'Sistema',       'Sistema',       NULL, 'Creación del ticket'),

(7, NULL, 'Abierto',     '2026-10-03 09:40:00', 'Sistema',       'Sistema',       NULL, 'Creación del ticket'),
(7, 'Abierto', 'En progreso', '2026-10-03 09:45:00', 'Paula Herrera', 'Técnico', 3, 'Validación de permisos'),
(7, 'En progreso', 'Cerrado', '2026-10-03 10:00:00', 'Paula Herrera', 'Técnico', 3, 'Permisos concedidos'),

(8, NULL, 'Abierto',     '2026-10-04 14:25:00', 'Sistema',       'Sistema',       NULL, 'Creación del ticket'),
(8, 'Abierto', 'En progreso', '2026-10-04 15:00:00', 'Paula Herrera', 'Técnico', 3, 'Revisión de conectividad'),

(9, NULL, 'Abierto',     '2026-10-05 08:45:00', 'Sistema',       'Sistema',       NULL, 'Creación del ticket'),
(9, 'Abierto', 'En progreso', '2026-10-05 09:00:00', 'Carla Méndez', 'Técnico', 1, 'Instalación iniciada'),
(9, 'En progreso', 'Cerrado', '2026-10-05 09:30:00', 'Carla Méndez', 'Técnico', 1, 'Instalación finalizada'),

(10, NULL, 'Abierto',    '2026-10-06 15:10:00', 'Sistema',       'Sistema',       NULL, 'Creación del ticket'),

(11, NULL, 'Abierto',    '2026-10-07 10:15:00', 'Sistema',       'Sistema',       NULL, 'Creación del ticket'),
(11, 'Abierto', 'En progreso', '2026-10-07 10:30:00', 'Diego Fernández', 'Técnico', 2, 'Diagnóstico de correo'),

(12, NULL, 'Abierto',    '2026-10-08 08:00:00', 'Sistema',       'Sistema',       NULL, 'Creación del ticket'),
(12, 'Abierto', 'En progreso', '2026-10-08 08:30:00', 'Paula Herrera', 'Técnico', 3, 'Revisión del equipo'),
(12, 'En progreso', 'Cerrado', '2026-10-08 11:00:00', 'Paula Herrera', 'Técnico', 3, 'Optimización completada');

-- =========================================================
-- CONSULTA 1: ver el historial cronológico de un ticket.
-- Cambiar el valor de ticket_id para consultar otro caso.
-- =========================================================
SELECT
    h.ticket_id,
    h.estado_anterior,
    h.estado_nuevo,
    h.fecha_cambio,
    h.realizado_por,
    h.rol_actor,
    h.comentario
FROM historial_tickets AS h
WHERE h.ticket_id = 3
ORDER BY h.fecha_cambio;

-- =========================================================
-- CONSULTA 2: contar cuántos cambios se registraron por ticket.
-- =========================================================
SELECT
    ticket_id,
    COUNT(*) AS eventos_registrados
FROM historial_tickets
GROUP BY ticket_id
ORDER BY eventos_registrados DESC, ticket_id;

-- =========================================================
-- CONSULTA 3: calcular duración aproximada de cada estado.
-- LEAD obtiene la fecha del siguiente evento del mismo ticket.
-- La última etapa de tickets aún abiertos no tiene fin y queda NULL.
-- =========================================================
WITH etapas AS (
    SELECT
        ticket_id,
        estado_nuevo AS estado,
        fecha_cambio AS inicio_estado,
        LEAD(fecha_cambio) OVER (
            PARTITION BY ticket_id
            ORDER BY fecha_cambio
        ) AS fin_estado
    FROM historial_tickets
)
SELECT
    ticket_id,
    estado,
    inicio_estado,
    fin_estado,
    CASE
        WHEN fin_estado IS NOT NULL THEN
            ROUND((julianday(fin_estado) - julianday(inicio_estado)) * 1440, 1)
        ELSE NULL
    END AS minutos_en_estado
FROM etapas
ORDER BY ticket_id, inicio_estado;

-- =========================================================
-- CONSULTA 4: comparar último estado registrado con tickets.estado.
-- Sirve para detectar diferencias entre el estado actual y el historial.
-- =========================================================
WITH ultimo_evento AS (
    SELECT
        ticket_id,
        estado_nuevo,
        ROW_NUMBER() OVER (
            PARTITION BY ticket_id
            ORDER BY fecha_cambio DESC, historial_id DESC
        ) AS posicion
    FROM historial_tickets
)
SELECT
    t.ticket_id,
    t.estado AS estado_en_ticket,
    u.estado_nuevo AS ultimo_estado_historial,
    CASE
        WHEN u.estado_nuevo = t.estado THEN 'Coincide'
        ELSE 'Revisar diferencia'
    END AS validacion
FROM tickets AS t
JOIN ultimo_evento AS u ON u.ticket_id = t.ticket_id
WHERE u.posicion = 1
ORDER BY t.ticket_id;

-- NOTA:
-- Los eventos son una muestra ficticia y solo cubren algunos cambios.
-- La duración de la última etapa abierta no puede calcularse sin una
-- fecha de finalización. Para pausas, SLA por horario hábil y auditoría
-- completa harían falta reglas y eventos adicionales.
