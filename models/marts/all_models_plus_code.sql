WITH

including_other_cols AS (

    SELECT * FROM {{ ref('int_join_with_run_results') }}

),

most_recent_compiled_code_per_model AS (

    SELECT
        model_id,
        MAX(compile_completed_at) AS latest_compiled_at

    FROM including_other_cols

    GROUP BY model_id

),

only_model_ids_plus_most_recent_code AS (

    SELECT
        i.model_id,
        i.compiled_code

    FROM including_other_cols AS i
    INNER JOIN most_recent_compiled_code_per_model AS m ON
        i.model_id = m.model_id
        AND i.compile_completed_at = m.latest_compiled_at

)

SELECT * FROM only_model_ids_plus_most_recent_code
