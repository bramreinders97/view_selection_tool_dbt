WITH

rows_affected_per_run AS (

    SELECT * FROM {{ ref('int_include_monitoring_id') }}

),

row_counts_per_model AS (

    SELECT * FROM {{ ref('stg_data_monitoring_metrics') }}

),

maintenenace_fractions AS (

    SELECT
        row_affected.model_id,
        row_affected.invocation_id,
        row_affected.rows_affected,
        row_affected.materialization,
        row_counts.row_count,
        CASE
            WHEN row_counts.row_count = 0 THEN NULL
            ELSE row_affected.rows_affected / row_counts.row_count
        END AS maintenance_fraction

    FROM rows_affected_per_run AS row_affected
    INNER JOIN row_counts_per_model AS row_counts
        ON row_affected.monitoring_id = row_counts.monitoring_id

)

SELECT * FROM maintenenace_fractions
