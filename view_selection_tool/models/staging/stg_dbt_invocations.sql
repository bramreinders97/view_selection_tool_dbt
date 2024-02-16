WITH

original AS (

    SELECT * FROM {{ source('elementary_src', 'dbt_invocations') }}

),

useful_cols_only AS (

    SELECT
        invocation_id,
        selected

    FROM original

)

SELECT * FROM useful_cols_only