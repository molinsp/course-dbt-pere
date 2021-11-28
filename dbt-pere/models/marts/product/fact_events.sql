with events as (
    select * from {{ ref('stg_events') }}
)

select * from events