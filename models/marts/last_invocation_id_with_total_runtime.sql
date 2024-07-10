with

all_invocation_ids_and_execution_times as (

    select * from {{ ref('int_join_with_run_results') }}

),

last_invocation_id as (

    select
        invocation_id,
        execution_time

    from all_invocation_ids_and_execution_times
    order by compile_completed_at desc

    limit 1

),

include_total_execution_time as (

    select
        invocation_id,
        sum(execution_time) as total_execution_time

    from all_invocation_ids_and_execution_times

    where invocation_id in (
        select invocation_id from last_invocation_id
    )

    group by invocation_id

)


    select * from include_total_execution_time