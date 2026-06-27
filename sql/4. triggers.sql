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