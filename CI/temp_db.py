from sqlalchemy import create_engine
import pandas as pd
import os


csv_info = [
    {
        "filepath": 'data_monitoring_metrics.csv',
        "cols": [
            "id",
            "full_table_name",
            "column_name",
            "metric_name",
            "metric_value",
            "source_value",
            "bucket_start",
            "bucket_end",
            "bucket_duration_hours",
            "updated_at",
            "dimension",
            "dimension_value",
            "metric_properties",
            "created_at"
        ]
    },
    {
        "filepath": 'dbt_invocations.csv',
        "cols": [
            "invocation_id",
            "job_id",
            "job_name",
            "job_run_id",
            "run_started_at",
            "run_completed_at",
            "generated_at",
            "created_at",
            "command",
            "dbt_version",
            "elementary_version",
            "full_refresh",
            "invocation_vars",
            "vars",
            "target_name",
            "target_database",
            "target_schema",
            "target_profile_name",
            "threads",
            "selected",
            "yaml_selector",
            "project_id",
            "project_name",
            "env",
            "env_id",
            "cause_category",
            "cause",
            "pull_request_id",
            "git_sha",
            "orchestrator",
            "dbt_user",
            "job_url",
            "job_run_url",
            "account_id",
            "target_adapter_specific_fields"
        ]
    },
    {
        "filepath": 'dbt_models.csv',
        "cols": [
            "unique_id",
            "alias",
            "checksum",
            "materialization",
            "tags",
            "meta",
            "owner",
            "database_name",
            "schema_name",
            "depends_on_macros",
            "depends_on_nodes",
            "description",
            "name",
            "package_name",
            "original_path",
            "path",
            "patch_path",
            "generated_at",
            "metadata_hash"
        ]
    },
    {
        "filepath": 'dbt_run_results.csv',
        "cols": [
            "model_execution_id",
            "unique_id",
            "invocation_id",
            "generated_at",
            "created_at",
            "name",
            "message",
            "status",
            "resource_type",
            "execution_time",
            "execute_started_at",
            "execute_completed_at",
            "compile_started_at",
            "compile_completed_at",
            "rows_affected",
            "full_refresh",
            "compiled_code",
            "failures",
            "query_id",
            "thread_id",
            "materialization",
            "adapter_response"
        ]
    },
]


def fill_temp_db():
    engine = create_engine(
        "postgresql://bram:secret_password@postgres/bram-vst"
    )

    for table_info in csv_info:
        # Read CSV file into DataFrame
        csv_file = os.path.join(
            os.path.dirname(os.path.abspath(__file__)), table_info['filepath']
        )

        df = pd.read_csv(csv_file, names=table_info['cols'])

        # Insert data into PostgreSQL
        df.to_sql("test_table", con=engine, if_exists="replace", index=False, schema='public')


if __name__ == '__main__':
    fill_temp_db()
