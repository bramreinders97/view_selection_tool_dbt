WITH

all_models AS (

    SELECT * FROM {{ ref('int_keep_models_relevant_package') }}

),

referenced_models AS (

    SELECT
        JSONB_ARRAY_ELEMENTS_TEXT(depends_on_nodes::JSONB) AS referenced_model_id

    FROM all_models

),

unique_referenced_models AS (

    SELECT DISTINCT
        referenced_model_id

    FROM referenced_models

),

destination_models AS (

    SELECT
        model_id

    FROM all_models

    WHERE model_id NOT IN
          (SELECT referenced_model_id FROM unique_referenced_models)

)

    SELECT * FROM destination_models
