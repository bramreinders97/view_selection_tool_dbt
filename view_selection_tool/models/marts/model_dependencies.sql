WITH

including_irrelevant_cols AS (

    SELECT * FROM {{ ref('int_keep_models_relevant_package') }}

),

model_dependencies AS (

    SELECT
        model_id,
        depends_on_nodes,
        {{ dbt.concat(["'\"'", "database_name", "'\".\"'", "schema_name", "'\".\"'", "alias", "'\"'"]) }}
        AS compiled_code_reference

    FROM including_irrelevant_cols

)

SELECT * FROM model_dependencies
