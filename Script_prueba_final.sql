
----- Reto 1 (Contar etiquetas)
-- Unifica los valores de las tres claves de etiquetas en una sola columna virtual
WITH all_tags AS (
    SELECT data ->> 'tag' AS tag FROM stores
    UNION ALL
    SELECT data ->> 'tags' AS tag FROM stores
    UNION ALL
    SELECT data ->> 'tag2' AS tag FROM stores
)
-- Ahora cuenta y agrupa desde esa columna virtual
SELECT
    tag,
    COUNT(*) AS store_count
FROM
    all_tags
WHERE
    tag IS NOT NULL -- Ignora las filas donde la etiqueta pueda ser nula
GROUP BY
    tag
ORDER BY
    store_count DESC;




----Reto 2 (Actualizar tienda)
UPDATE
    stores
SET
    data = jsonb_set(
        jsonb_set(data::jsonb, '{name}', '"Old-Wolf"'), -- Cambia el 'name'
        '{tags}', '"educación"' -- Cambia la etiqueta principal 'tags'
    )
WHERE
    id = '0d4f7a40-651d-44fb-8744-04d9b31ef844';


-- Opcional: verifica que el cambio se aplicó correctamente
SELECT id, data FROM stores WHERE id = '0d4f7a40-651d-44fb-8744-04d9b31ef844';



