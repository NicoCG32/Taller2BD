-- 3. Procedimientos
 
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
    fecha DATE
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
    RETURN QUERY
    DELETE FROM evaluaciones
    WHERE evaluaciones.codigo_protocolo = e_codigo_protocolo
      AND evaluaciones.fecha_evaluacion < fecha
    RETURNING
        evaluaciones.id_evaluacion,
        evaluaciones.id_nave,
        evaluaciones.codigo_protocolo,
        evaluaciones.fecha_evaluacion,
        evaluaciones.responsable,
        evaluaciones.resultado;
END;
$$;