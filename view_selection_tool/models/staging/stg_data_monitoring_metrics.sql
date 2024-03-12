WITH

original AS (

    SELECT * FROM {{ source('elementary_src', 'data_monitoring_metrics') }}

),

id_and_row_count AS (

    SELECT
        id AS monitoring_id,
        metric_value AS row_count

    FROM original
    WHERE metric_name = 'row_count'

)

SELECT * FROM id_and_row_count
