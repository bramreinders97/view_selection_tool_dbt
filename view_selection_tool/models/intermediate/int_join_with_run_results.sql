WITH


relevant_package_only AS (

    SELECT * FROM {{ ref('int_keep_models_relevant_package') }}

),


dbt_run_results AS (

    SELECT * FROM {{ ref('stg_dbt_run_results') }}

),

joined AS (

    SELECT
        p.model_id,
        p.alias,
        p.database_name,
        p.schema_name,
        r.invocation_id,
        r.rows_affected,
        r.materialization,
        r.compiled_code,
        r.compile_completed_at,
        r.execution_time

    FROM relevant_package_only AS p
    INNER JOIN dbt_run_results AS r
        ON p.model_id = r.model_id

)

SELECT * FROM joined
