WITH

including_irrelevant_cols AS (

    SELECT * FROM {{ ref('int_keep_models_relevant_package') }}

),

model_dependencies AS (

    SELECT
        model_id,
        depends_on_nodes

    FROM including_irrelevant_cols

)

    SELECT * FROM model_dependencies