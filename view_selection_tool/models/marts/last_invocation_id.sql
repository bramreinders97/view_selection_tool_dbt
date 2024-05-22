with

all_invocation_ids as (

    select * from {{ ref('int_join_with_run_results') }}

),

last_invocation_id as (

    select
        invocation_id

    from all_invocation_ids
    order by compile_completed_at desc

    limit 1

)

    select * from last_invocation_id