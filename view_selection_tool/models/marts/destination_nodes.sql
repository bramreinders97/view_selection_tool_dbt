WITH

all_models AS (

    SELECT * FROM {{ ref('int_keep_models_relevant_package') }}

),

referenced_models AS (

    SELECT * FROM {{ ref('int_referenced_models') }}

),

destination_models AS (

    SELECT model_id

    FROM all_models

    WHERE
        model_id NOT IN
        (SELECT referenced_model_id FROM referenced_models)

)

SELECT * FROM destination_models
