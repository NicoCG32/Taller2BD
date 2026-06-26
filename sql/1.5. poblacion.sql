-- Taller 2 - Base de Datos
-- Poblacion de tablas con datos genericos.

INSERT INTO orbitas (peso_maximo, altitud) VALUES
    (35000, 100),
    (50000, 400),
    (75000, 1000),
    (90000, 2000);

INSERT INTO operaciones (id_orbita, nombre_operacion) VALUES
    (1, 'Operacion Exploracion Alpha'),
    (1, 'Operacion Soporte Beta'),
    (2, 'Operacion Cartografia Gamma'),
    (3, 'Operacion Carga Delta'),
    (3, 'Operacion Habitabilidad Epsilon'),
    (4, 'Operacion Descenso Zeta');

INSERT INTO naves (id_operacion, fecha_ensamblaje) VALUES
    (1, '2026-01-10'),
    (1, '2026-01-18'),
    (2, '2026-02-03'),
    (3, '2026-02-21'),
    (4, '2026-03-05'),
    (5, '2026-03-19'),
    (5, '2026-04-02'),
    (6, '2026-04-16');

INSERT INTO modulos_tripulados (id_nave, autonomia, capacidad_pasajeros) VALUES
    (1, 120, 4),
    (3, 96, 3),
    (5, 144, 5),
    (7, 168, 6);

INSERT INTO modulos_aterrizaje (id_nave, tipo_propulsor, capacidad_carga_util) VALUES
    (2, 'Quimico', 8500),
    (4, 'Hibrido', 12000),
    (6, 'Electrico', 7000),
    (8, 'Quimico reforzado', 15000);

INSERT INTO materiales (nombre_material) VALUES
    ('Titanio'),
    ('Aluminio'),
    ('Fibra de carbono'),
    ('Acero aeroespacial'),
    ('Aleacion de niquel'),
    ('Ceramica termica'),
    ('Cobre conductor');

INSERT INTO fabricantes (rut_empresa, nombre_empresa, ciudad_matriz, nombre_director) VALUES
    ('76000001-1', 'AeroAndes SpA', 'Santiago', 'Elena Rojas'),
    ('76000002-2', 'Orbital Sur Ltda', 'Valparaiso', 'Martin Lagos'),
    ('76000003-3', 'Lunar Systems SA', 'Concepcion', 'Camila Fuentes'),
    ('76000004-4', 'AstroMecanica Chile', 'Antofagasta', 'Rafael Pinto'),
    ('76000005-5', 'Propulsion Austral', 'La Serena', 'Daniela Vera');

INSERT INTO instalaciones (nombre_instalacion, lugar) VALUES
    ('Hangar Central', 'Santiago'),
    ('Laboratorio Termico', 'Antofagasta'),
    ('Planta de Ensamblaje Norte', 'Calama'),
    ('Centro de Pruebas Orbitales', 'Valparaiso'),
    ('Deposito de Componentes', 'Concepcion');

INSERT INTO protocolos (codigo_protocolo, nivel_riesgo, denominacion) VALUES
    ('SEG-001', 3, 'Prueba de presurizacion'),
    ('SEG-002', 4, 'Prueba termica'),
    ('SEG-003', 5, 'Prueba de radiacion'),
    ('SEG-004', 2, 'Prueba de comunicacion'),
    ('SEG-005', 4, 'Prueba de propulsion'),
    ('SEG-006', 3, 'Prueba de integridad estructural');

INSERT INTO componentes (id_nave, rut_empresa, id_instalacion, peso, descripcion) VALUES
    (1, '76000001-1', 1, 3200, 'Modulo de soporte vital'),
    (1, '76000002-2', 4, 900, 'Panel de control principal'),
    (2, '76000003-3', 3, 5400, 'Tren de aterrizaje'),
    (2, '76000005-5', 2, 6200, 'Tanque de combustible'),
    (3, '76000001-1', 1, 4000, 'Cabina presurizada'),
    (3, '76000002-2', 4, 700, 'Antena de comunicacion'),
    (4, '76000004-4', 5, 7800, 'Modulo de carga'),
    (4, '76000005-5', 2, 8400, 'Motor de descenso'),
    (5, '76000002-2', 4, 1100, 'Sistema de navegacion'),
    (5, '76000003-3', 2, 2500, 'Escudo termico'),
    (6, '76000004-4', 5, 2300, 'Brazo robotico'),
    (6, '76000001-1', 3, 3600, 'Deposito de carga util'),
    (7, '76000001-1', 1, 1700, 'Sistema de oxigeno'),
    (8, '76000005-5', 3, 4200, 'Plataforma de aterrizaje'),
    (NULL, '76000003-3', 5, 350, 'Sensor experimental'),
    (NULL, '76000004-4', 5, 500, 'Panel experimental');

INSERT INTO componentes_material (id_material, id_componente) VALUES
    (1, 1),
    (3, 1),
    (2, 2),
    (7, 2),
    (1, 3),
    (4, 3),
    (1, 4),
    (5, 4),
    (6, 4),
    (1, 5),
    (3, 5),
    (2, 6),
    (7, 6),
    (1, 7),
    (3, 7),
    (1, 8),
    (4, 8),
    (5, 8),
    (2, 9),
    (7, 9),
    (1, 10),
    (5, 10),
    (6, 10),
    (2, 11),
    (3, 11),
    (1, 12),
    (5, 12),
    (2, 13),
    (7, 13),
    (1, 14),
    (4, 14),
    (6, 14),
    (2, 15),
    (7, 15),
    (2, 16),
    (3, 16);

INSERT INTO evaluaciones (id_nave, codigo_protocolo, fecha_evaluacion, responsable, resultado) VALUES
    (1, 'SEG-001', '2026-05-01', 'Inspector Mateo', 'APROBADO'),
    (1, 'SEG-002', '2026-05-02', 'Inspectora Laura', 'APROBADO'),
    (1, 'SEG-003', '2026-05-03', 'Inspector Javier', 'REPROBADO'),
    (2, 'SEG-001', '2026-05-04', 'Inspector Mateo', 'REPROBADO'),
    (2, 'SEG-004', '2026-05-05', 'Inspectora Laura', 'REPROBADO'),
    (2, 'SEG-005', '2026-05-06', 'Inspector Javier', 'PENDIENTE'),
    (3, 'SEG-001', '2026-05-07', 'Inspector Mateo', 'APROBADO'),
    (3, 'SEG-002', '2026-05-08', 'Inspectora Laura', 'REPROBADO'),
    (3, 'SEG-006', '2026-05-09', 'Inspector Javier', 'EN REVISION'),
    (4, 'SEG-002', '2026-05-10', 'Inspector Mateo', 'APROBADO'),
    (4, 'SEG-004', '2026-05-11', 'Inspectora Laura', 'APROBADO'),
    (4, 'SEG-005', '2026-05-12', 'Inspector Javier', 'REPROBADO'),
    (5, 'SEG-001', '2026-05-13', 'Inspector Mateo', 'APROBADO'),
    (5, 'SEG-003', '2026-05-14', 'Inspectora Laura', 'APROBADO'),
    (5, 'SEG-006', '2026-05-15', 'Inspector Javier', 'PENDIENTE'),
    (6, 'SEG-002', '2026-05-16', 'Inspector Mateo', 'REPROBADO'),
    (6, 'SEG-004', '2026-05-17', 'Inspectora Laura', 'APROBADO'),
    (6, 'SEG-005', '2026-05-18', 'Inspector Javier', 'EN REVISION'),
    (7, 'SEG-001', '2026-05-19', 'Inspector Mateo', 'REPROBADO'),
    (7, 'SEG-003', '2026-05-20', 'Inspectora Laura', 'APROBADO'),
    (7, 'SEG-006', '2026-05-21', 'Inspector Javier', 'APROBADO'),
    (8, 'SEG-002', '2026-05-22', 'Inspector Mateo', 'APROBADO'),
    (8, 'SEG-004', '2026-05-23', 'Inspectora Laura', 'REPROBADO'),
    (8, 'SEG-006', '2026-05-24', 'Inspector Javier', 'REPROBADO');