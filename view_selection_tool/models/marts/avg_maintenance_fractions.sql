WITH

all_maintenance_fractions AS (

    SELECT * FROM {{ ref('int_maintenance_fractions') }}

),

average_maintenance_fractions AS (

    SELECT
        model_id,
        avg(rows_affected) AS avg_rows_affected,
        avg(row_count) AS avg_row_count,
        avg(maintenance_fraction) AS avg_maintenance_fraction

    FROM all_maintenance_fractions

    GROUP BY model_id

)

SELECT * FROM average_maintenance_fractions
