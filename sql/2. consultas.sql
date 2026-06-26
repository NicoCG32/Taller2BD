-- Taller 2 - Base de Datos
-- Consultas y subconsultas solicitadas.

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