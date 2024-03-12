WITH

all_packages AS (

    SELECT * FROM {{ ref('stg_dbt_models') }}

),

relevant_package_only AS (

    SELECT
        model_id,
        alias,
        database_name,
        schema_name,
        depends_on_nodes


    FROM all_packages

    WHERE package_name = '{{ var("relevant_package") }}'

)

SELECT * FROM relevant_package_only
