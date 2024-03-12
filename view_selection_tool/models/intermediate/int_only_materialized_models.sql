WITH


all_materializations AS (

    SELECT * FROM {{ ref('int_join_with_run_results') }}

),

relevant_models_only AS (

    SELECT
        model_id,
        alias,
        database_name,
        schema_name,
        invocation_id,
        rows_affected,
        materialization

    FROM all_materializations

    WHERE materialization IN {{ var("relevant_materializations") }}

)

SELECT * FROM relevant_models_only
