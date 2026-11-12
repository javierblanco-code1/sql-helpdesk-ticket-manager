-- Help Desk Ticket Manager | SQLite
-- Proyecto educativo con datos ficticios

PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS categorias;
DROP TABLE IF EXISTS tecnicos;
DROP TABLE IF EXISTS usuarios;

CREATE TABLE usuarios (
    usuario_id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    departamento TEXT NOT NULL
);

CREATE TABLE tecnicos (
    tecnico_id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    nivel TEXT NOT NULL CHECK (nivel IN ('L1', 'L2', 'L3')),
    email TEXT NOT NULL UNIQUE
);

CREATE TABLE categorias (
    categoria_id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL UNIQUE,
    descripcion TEXT
);

CREATE TABLE tickets (
    ticket_id INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo TEXT NOT NULL,
    descripcion TEXT,
    estado TEXT NOT NULL CHECK (estado IN ('Abierto', 'En progreso', 'En espera', 'Cerrado')),
    prioridad TEXT NOT NULL CHECK (prioridad IN ('Baja', 'Media', 'Alta', 'Crítica')),
    fecha_creacion TEXT NOT NULL,
    fecha_cierre TEXT,
    usuario_id INTEGER NOT NULL,
    tecnico_id INTEGER,
    categoria_id INTEGER NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(usuario_id),
    FOREIGN KEY (tecnico_id) REFERENCES tecnicos(tecnico_id),
    FOREIGN KEY (categoria_id) REFERENCES categorias(categoria_id),
    CHECK (fecha_cierre IS NULL OR fecha_cierre >= fecha_creacion)
);

CREATE INDEX idx_tickets_estado ON tickets(estado);
CREATE INDEX idx_tickets_prioridad ON tickets(prioridad);
CREATE INDEX idx_tickets_fecha ON tickets(fecha_creacion);
