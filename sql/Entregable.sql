-- 1. Tablas

DROP TABLE IF EXISTS
    componentes_material,
    evaluaciones,
    modulos_tripulados,
    modulos_aterrizaje,
    componentes,
    naves,
    operaciones,
    orbitas,
    materiales,
    fabricantes,
    instalaciones,
    protocolos
CASCADE;

CREATE TABLE orbitas (
    id_orbita SERIAL PRIMARY KEY,
    peso_maximo INT NOT NULL,
    altitud INT NOT NULL
);

CREATE TABLE operaciones (
    id_operacion SERIAL PRIMARY KEY,
    id_orbita INT NOT NULL REFERENCES orbitas(id_orbita),
    nombre_operacion TEXT NOT NULL UNIQUE
);

CREATE TABLE naves (
    id_nave SERIAL PRIMARY KEY,
    id_operacion INT NOT NULL REFERENCES operaciones(id_operacion),
    fecha_ensamblaje DATE NOT NULL
);

CREATE TABLE modulos_tripulados (
    id_nave INT PRIMARY KEY REFERENCES naves(id_nave),
    autonomia INT NOT NULL,
    capacidad_pasajeros INT NOT NULL
);

CREATE TABLE modulos_aterrizaje (
    id_nave INT PRIMARY KEY REFERENCES naves(id_nave),
    tipo_propulsor TEXT NOT NULL,
    capacidad_carga_util INT NOT NULL
);

CREATE TABLE materiales (
    id_material SERIAL PRIMARY KEY,
    nombre_material TEXT NOT NULL UNIQUE
);

CREATE TABLE fabricantes (
    rut_empresa TEXT PRIMARY KEY,
    nombre_empresa TEXT NOT NULL,
    ciudad_matriz TEXT NOT NULL,
    nombre_director TEXT NOT NULL
);

CREATE TABLE instalaciones (
    id_instalacion SERIAL PRIMARY KEY,
    nombre_instalacion TEXT NOT NULL,
    lugar TEXT
);

CREATE TABLE protocolos (
    codigo_protocolo TEXT PRIMARY KEY,
    nivel_riesgo INT NOT NULL,
    denominacion TEXT NOT NULL
);

CREATE TABLE componentes (
    id_componente SERIAL PRIMARY KEY,
    id_nave INT REFERENCES naves(id_nave),
    rut_empresa TEXT NOT NULL REFERENCES fabricantes(rut_empresa),
    id_instalacion INT NOT NULL REFERENCES instalaciones(id_instalacion),
    peso INT NOT NULL,
    descripcion TEXT NOT NULL
);

CREATE TABLE componentes_material (
    id_material INT REFERENCES materiales(id_material),
    id_componente INT REFERENCES componentes(id_componente),
    PRIMARY KEY (id_material, id_componente)
);

CREATE TABLE evaluaciones (
    id_evaluacion SERIAL PRIMARY KEY,
    id_nave INT NOT NULL REFERENCES naves(id_nave),
    codigo_protocolo TEXT NOT NULL REFERENCES protocolos(codigo_protocolo),
    fecha_evaluacion DATE NOT NULL,
    responsable TEXT NOT NULL,
    -- En el MR original este atributo era BOOL; en Taller 2 se modela como TEXT
    -- porque se requieren estados como Aprobado, Reprobado, En Revision y Pendiente.
    resultado TEXT NOT NULL,
    CHECK (resultado IN ('APROBADO', 'REPROBADO', 'EN REVISION', 'PENDIENTE')),
    UNIQUE (id_nave, codigo_protocolo, fecha_evaluacion)
);

-- 1.5 Poblacion de tablas con datos genericos.

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

-- Test de cumplimiento de elementos mínimos

SELECT 'orbitas' AS tabla , COUNT (*) AS total FROM orbitas
UNION ALL SELECT 'operaciones', COUNT (*) FROM operaciones
UNION ALL SELECT 'naves', COUNT (*) FROM naves
UNION ALL SELECT 'modulos_tripulados', COUNT (*) FROM modulos_tripulados
UNION ALL SELECT 'modulos_aterrizaje', COUNT (*) FROM modulos_aterrizaje
UNION ALL SELECT 'materiales', COUNT (*) FROM materiales
UNION ALL SELECT 'fabricantes', COUNT (*) FROM fabricantes
UNION ALL SELECT 'instalaciones', COUNT (*) FROM instalaciones
UNION ALL SELECT 'protocolos', COUNT (*) FROM protocolos
UNION ALL SELECT 'componentes', COUNT (*) FROM componentes
UNION ALL SELECT 'componentes_material', COUNT (*) FROM componentes_material
UNION ALL SELECT 'evaluaciones', COUNT (*) FROM evaluaciones
ORDER BY tabla ;



-- 2. Consultas y subconsultas solicitadas.

-- 1. Listar cada órbita mostrando su id, altitud y la cantidad total de evaluaciones con
-- resultado "Reprobado" (o el estado de fallo que hayan definido) correspondientes a
-- las naves asignadas a dicha órbita.
SELECT
    o.id_orbita,
    o.altitud,
    COALESCE(SUM(
        CASE
            WHEN e.resultado = 'REPROBADO' THEN 1
            ELSE 0
        END
    ), 0) AS total_evaluaciones_reprobadas
FROM orbitas o
LEFT JOIN operaciones op ON op.id_orbita = o.id_orbita
LEFT JOIN naves n ON n.id_operacion = op.id_operacion
LEFT JOIN evaluaciones e ON e.id_nave = n.id_nave
GROUP BY o.id_orbita, o.altitud
ORDER BY o.id_orbita;

-- 2. Generar un reporte que muestre todas las naves con su id, fecha de ensamblaje,
-- altitud de su órbita y una nueva columna llamada "Información Extra". Si la nave es
-- tripulada, esta columna debe mostrar su capacidad de pasajeros; si es de aterrizaje,
-- debe mostrar su carga útil.
SELECT
    n.id_nave,
    n.fecha_ensamblaje,
    o.altitud,
    CASE
        WHEN mt.id_nave IS NOT NULL THEN
            'Capacidad pasajeros: ' || mt.capacidad_pasajeros
        WHEN ma.id_nave IS NOT NULL THEN
            'Carga util: ' || ma.capacidad_carga_util
        ELSE
            'Sin tipo definido'
    END AS "Informacion Extra"
FROM naves n
JOIN operaciones op ON op.id_operacion = n.id_operacion
JOIN orbitas o ON o.id_orbita = op.id_orbita
LEFT JOIN modulos_tripulados mt ON mt.id_nave = n.id_nave
LEFT JOIN modulos_aterrizaje ma ON ma.id_nave = n.id_nave
ORDER BY n.id_nave;

-- 3. Mostrar el id y el nombre del material que se encuentra presente en la mayor
-- cantidad de componentes distintos.
SELECT
    conteo_materiales.id_material,
    conteo_materiales.nombre_material
FROM (
    SELECT
        m.id_material,
        m.nombre_material,
        COUNT(DISTINCT cm.id_componente) AS cantidad_componentes
    FROM materiales m
    JOIN componentes_material cm ON cm.id_material = m.id_material
    GROUP BY m.id_material, m.nombre_material
) AS conteo_materiales
WHERE conteo_materiales.cantidad_componentes = (
    SELECT MAX(subconsulta.cantidad_componentes)
    FROM (
        SELECT COUNT(DISTINCT cm2.id_componente) AS cantidad_componentes
        FROM materiales m2
        JOIN componentes_material cm2 ON cm2.id_material = m2.id_material
        GROUP BY m2.id_material, m2.nombre_material 
    ) AS subconsulta
)
ORDER BY conteo_materiales.id_material;



-- 3. Procedimientos Almacenados
-- Nota: Se implementaron como FUNCTIONS en lugar de PROCEDURES, 
-- para simplificar el resultado esperado pues las funciones pueden 
-- retornar un conjunto de resultados sin necesidad de una consulta.

-- 1. Un procedimiento que reciba el id de una nave y actualice el resultado de todas sus evaluaciones 
-- "Reprobadas" a estado "Pendiente" para iniciar una nueva ronda de testeos.

CREATE OR REPLACE FUNCTION actualizar_evaluacion_nave(
    e_id_nave INT
)
RETURNS TABLE (
    id_evaluacion INT,
    id_nave_modificada INT,
    codigo_protocolo TEXT,
    fecha_evaluacion DATE,
    responsable TEXT,
    resultado_nuevo TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF e_id_nave IS NULL THEN
        RAISE EXCEPTION 'El id de la nave no puede ser NULL';
    END IF;

    RETURN QUERY
    UPDATE evaluaciones
    SET resultado = 'PENDIENTE'
    WHERE id_nave = e_id_nave
      AND resultado = 'REPROBADO'
    RETURNING
        evaluaciones.id_evaluacion,
        evaluaciones.id_nave,
        evaluaciones.codigo_protocolo,
        evaluaciones.fecha_evaluacion,
        evaluaciones.responsable,
        evaluaciones.resultado;
END;
$$;

-- 2. Un procedimiento que reciba el RUT de un proveedor origen y el RUT de un proveedor destino, 
-- y actualice todos los componentes del primero para traspasarlos al segundo.

CREATE OR REPLACE FUNCTION traspasar_componentes(
    rut_original TEXT,
    rut_destino TEXT
)
RETURNS TABLE(
    id_componente INT,
    id_nave INT,
    rut_Nuevaempresa TEXT,
    id_instalacion INT,
    peso INT ,
    descripcion TEXT
  )
LANGUAGE plpgsql
AS $$
BEGIN
    IF rut_original IS NULL THEN
        RAISE EXCEPTION 'El RUT del proveedor origen no puede ser NULL';
    END IF;

    IF rut_destino IS NULL THEN
        RAISE EXCEPTION 'El RUT del proveedor destino no puede ser NULL';
    END IF;

    RETURN QUERY
    UPDATE componentes
    SET rut_empresa = rut_destino
    WHERE rut_empresa = rut_original
    RETURNING
        componentes.id_componente ,
        componentes.id_nave ,
        componentes.rut_empresa ,
        componentes.id_instalacion ,
        componentes.peso  ,
        componentes.descripcion;
END;
$$;

-- 3. Un procedimiento que reciba el código de un protocolo y una fecha,
-- y elimine los registros de aquellas evaluaciones realizadas antes de esa fecha usando dicho protocolo.

CREATE OR REPLACE FUNCTION eliminar_evaluaciones_fecha(
    e_codigo_protocolo TEXT,
    e_fecha_limite DATE
)
RETURNS TABLE (
    id_evaluacion INT,
    id_nave INT,
    codigo_protocolo TEXT,
    fecha_evaluacion DATE,
    responsable TEXT,
    resultado TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF e_codigo_protocolo IS NULL THEN
        RAISE EXCEPTION 'El codigo del protocolo no puede ser NULL';
    END IF;

    IF e_fecha_limite IS NULL THEN
        RAISE EXCEPTION 'La fecha limite no puede ser NULL';
    END IF;

    RETURN QUERY
    DELETE FROM evaluaciones
    WHERE evaluaciones.codigo_protocolo = e_codigo_protocolo
      AND evaluaciones.fecha_evaluacion < e_fecha_limite
    RETURNING
        evaluaciones.id_evaluacion,
        evaluaciones.id_nave,
        evaluaciones.codigo_protocolo,
        evaluaciones.fecha_evaluacion,
        evaluaciones.responsable,
        evaluaciones.resultado;
END;
$$;



-- 4. Triggers 

-- Se crea la tabla para guardar cambios de evaluaciones
DROP TABLE IF EXISTS historial_evaluaciones;
CREATE TABLE historial_evaluaciones (
    id_historial SERIAL PRIMARY KEY,
    id_nave INT NOT NULL,
    codigo_protocolo TEXT NOT NULL,
    resultado_anterior TEXT NOT NULL,
    resultado_nuevo TEXT NOT NULL,
    fecha_modificacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Trigger 1: Validar peso máximo de la nave
DROP TRIGGER IF EXISTS trg_validar_peso_componente ON componentes;
DROP FUNCTION IF EXISTS validar_peso_componente();

CREATE OR REPLACE FUNCTION validar_peso_componente()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    peso_actual INT;
    peso_maximo INT;
BEGIN
    IF NEW.id_nave IS NULL THEN
        RETURN NEW;
    END IF;

    SELECT o.peso_maximo
    INTO peso_maximo
    FROM naves n
    JOIN operaciones op ON n.id_operacion = op.id_operacion
    JOIN orbitas o ON op.id_orbita = o.id_orbita
    WHERE n.id_nave = NEW.id_nave;

    IF TG_OP = 'UPDATE' THEN
        SELECT COALESCE(SUM(peso), 0)
        INTO peso_actual
        FROM componentes
        WHERE id_nave = NEW.id_nave
          AND id_componente <> OLD.id_componente;
    ELSE
        SELECT COALESCE(SUM(peso), 0)
        INTO peso_actual
        FROM componentes
        WHERE id_nave = NEW.id_nave;
    END IF;

    IF peso_actual + NEW.peso > peso_maximo THEN
        RAISE EXCEPTION 'El peso de la nave supera el máximo permitido por su órbita';
    END IF;

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_validar_peso_componente
BEFORE INSERT OR UPDATE OF id_nave, peso
ON componentes
FOR EACH ROW
EXECUTE FUNCTION validar_peso_componente();

-- Trigger 2: Guardar historial al cambiar resultado
DROP TRIGGER IF EXISTS trg_historial_evaluaciones ON evaluaciones;
DROP FUNCTION IF EXISTS registrar_historial_evaluaciones();

CREATE OR REPLACE FUNCTION registrar_historial_evaluaciones()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO historial_evaluaciones (
        id_nave,
        codigo_protocolo,
        resultado_anterior,
        resultado_nuevo
    )
    VALUES (
        OLD.id_nave,
        OLD.codigo_protocolo,
        OLD.resultado,
        NEW.resultado
    );
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_historial_evaluaciones
AFTER UPDATE OF resultado
ON evaluaciones
FOR EACH ROW
EXECUTE FUNCTION registrar_historial_evaluaciones();



-- 5. Gestión de usuarios y roles

-- 1. Existen los administradores, como Elena, que deben poder consultar, registrar 
-- y actualizar la información de las naves, los componentes, los proveedores, los materiales
-- y las órbitas, pero no tienen permitido eliminar ningún registro.

CREATE ROLE administradores;
GRANT SELECT, INSERT, UPDATE ON orbitas TO administradores;
GRANT SELECT, INSERT, UPDATE ON materiales TO administradores;
GRANT SELECT, INSERT, UPDATE ON fabricantes TO administradores;
GRANT SELECT, INSERT, UPDATE ON naves TO administradores;
GRANT SELECT, INSERT, UPDATE ON modulos_tripulados TO administradores;
GRANT SELECT, INSERT, UPDATE ON modulos_aterrizaje TO administradores;
GRANT SELECT, INSERT, UPDATE ON componentes TO administradores;

CREATE USER elena WITH PASSWORD 'claveseguraElena';
GRANT administradores TO elena;

-- 2. Están los auditores externos, como Javier, que necesitan consultar la 
-- información de los protocolos y las evaluaciones de las naves.

CREATE ROLE auditores_externos;
GRANT SELECT ON protocolos TO auditores_externos;
GRANT SELECT ON evaluaciones TO auditores_externos;

CREATE USER javier WITH PASSWORD 'claveseguraJavier';
GRANT auditores_externos TO javier;

-- 3. Finalmente están los inspectores de terreno, como Mateo, que solo
-- pueden ver los ids de las naves y los resultados de sus evaluaciones.

CREATE ROLE inspectores_terreno;
GRANT SELECT (id_nave, resultado) ON evaluaciones TO inspectores_terreno;

CREATE USER mateo WITH PASSWORD 'claveseguraMateo';
GRANT inspectores_terreno TO mateo;
