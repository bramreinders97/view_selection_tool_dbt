WITH

without_monitoring_id AS (

    SELECT * FROM {{ ref('int_only_materialized_models') }}

),

including_monitoring_id AS (

    SELECT
        model_id,
        invocation_id,
        {{
            dbt.concat([
                "invocation_id",
                "'.'",
                "'\"'",
                "database_name",
                "'\".\"'",
                "schema_name",
                "'\".\"'",
                "alias",
                "'\"'"
            ])
        }}
        AS monitoring_id,
        rows_affected,
        materialization

    FROM without_monitoring_id
)

SELECT * FROM including_monitoring_id
