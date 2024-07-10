WITH

original AS (

    SELECT * FROM {{ source('elementary_src', 'dbt_models') }}

),

useful_cols_only AS (

    SELECT
        unique_id AS model_id,
        alias,
        database_name,
        schema_name,
        package_name,
        depends_on_nodes

    FROM original

)

SELECT * FROM useful_cols_only
