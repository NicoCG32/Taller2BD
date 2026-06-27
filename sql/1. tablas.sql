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