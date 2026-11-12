-- Datos completamente ficticios para practicar SQL

INSERT INTO usuarios (nombre, email, departamento) VALUES
('Lucía Gómez', 'lucia.gomez@example.com', 'Administración'),
('Mateo Pérez', 'mateo.perez@example.com', 'Ventas'),
('Sofía Díaz', 'sofia.diaz@example.com', 'Recursos Humanos'),
('Tomás Ruiz', 'tomas.ruiz@example.com', 'Logística'),
('Valentina Torres', 'valentina.torres@example.com', 'Marketing'),
('Nicolás Castro', 'nicolas.castro@example.com', 'Administración');

INSERT INTO tecnicos (nombre, nivel, email) VALUES
('Carla Méndez', 'L1', 'carla.mendez@example.com'),
('Diego Fernández', 'L1', 'diego.fernandez@example.com'),
('Paula Herrera', 'L2', 'paula.herrera@example.com');

INSERT INTO categorias (nombre, descripcion) VALUES
('Hardware', 'Problemas con equipos y periféricos'),
('Software', 'Aplicaciones y sistema operativo'),
('Redes', 'Conectividad, Wi-Fi y acceso a red'),
('Cuentas y accesos', 'Contraseñas, permisos y autenticación'),
('Correo', 'Correo electrónico y calendarios');

INSERT INTO tickets
(titulo, descripcion, estado, prioridad, fecha_creacion, fecha_cierre, usuario_id, tecnico_id, categoria_id)
VALUES
('No enciende la notebook', 'El equipo no inicia al presionar el botón', 'En progreso', 'Alta', '2026-10-01 08:30', NULL, 1, 1, 1),
('Sin conexión Wi-Fi', 'No puede conectarse a la red inalámbrica', 'Abierto', 'Alta', '2026-10-01 09:15', NULL, 2, NULL, 3),
('Restablecer contraseña', 'No puede ingresar a su cuenta', 'Cerrado', 'Media', '2026-10-01 10:00', '2026-10-01 10:35', 3, 2, 4),
('Error en aplicación', 'La aplicación se cierra al generar un reporte', 'En espera', 'Media', '2026-10-02 11:20', NULL, 4, 1, 2),
('Configurar correo', 'No sincroniza el correo en el equipo nuevo', 'Cerrado', 'Baja', '2026-10-02 12:00', '2026-10-02 13:10', 5, 2, 5),
('Monitor sin imagen', 'El monitor no muestra señal', 'Abierto', 'Crítica', '2026-10-03 08:05', NULL, 6, NULL, 1),
('Acceso a carpeta compartida', 'Solicita permisos para una carpeta', 'Cerrado', 'Baja', '2026-10-03 09:40', '2026-10-03 10:00', 1, 3, 4),
('Internet intermitente', 'La conexión se corta varias veces al día', 'En progreso', 'Alta', '2026-10-04 14:25', NULL, 2, 3, 3),
('Instalar herramienta', 'Solicita instalación de una aplicación autorizada', 'Cerrado', 'Media', '2026-10-05 08:45', '2026-10-05 09:30', 3, 1, 2),
('Teclado defectuoso', 'Varias teclas no responden', 'Abierto', 'Baja', '2026-10-06 15:10', NULL, 4, NULL, 1),
('Correo no recibe mensajes', 'No llegan mensajes externos', 'En progreso', 'Alta', '2026-10-07 10:15', NULL, 5, 2, 5),
('Equipo muy lento', 'El inicio y las aplicaciones tardan demasiado', 'Cerrado', 'Media', '2026-10-08 08:00', '2026-10-08 11:00', 6, 3, 2);
