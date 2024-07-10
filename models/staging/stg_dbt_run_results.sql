WITH

original AS (

    SELECT * FROM {{ source('elementary_src', 'dbt_run_results') }}

),

useful_cols_only AS (

    SELECT
        unique_id AS model_id,
        invocation_id,
        rows_affected,
        materialization,
        compiled_code,
        compile_completed_at,
        execution_time

    FROM original
    WHERE compiled_code IS NOT NULL

)

SELECT * FROM useful_cols_only
