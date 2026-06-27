-- 5. Gestión de usuarios y roles

-- 1. Existen los administradores, como Elena, que deben poder consultar, registrar 
-- y actualizar la información de las naves, los componentes, los proveedores, los materiales
-- y las órbitas, pero no tienen permitido eliminar ningún registro.

CREATE ROLE administradores;
GRANT SELECT, INSERT, UPDATE ON orbitas TO administradores;
GRANT SELECT, INSERT, UPDATE ON materiales TO administradores;
GRANT SELECT, INSERT, UPDATE ON fabricantes TO administradores;
GRANT SELECT, INSERT, UPDATE ON naves TO administradores;
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