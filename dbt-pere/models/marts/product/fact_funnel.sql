with stg_events as (
    select * from {{ ref('stg_events') }}
    where event_type in ('page_view', 'add_to_cart', 'checkout')
)
, event_counts as (
    select event_type
    , COUNT(*) as event_count 
    from stg_events 
    group by event_type 
    order by 2 DESC
), event_percent as (
    select event_type, 
        event_count, 
        100.0* event_count/(
            SELECT MAX(event_count) 
            FROM event_counts) 
        as event_percentage 
        , 100 - 100.0 * event_count/lag(event_count, 1) over (ORDER BY event_count DESC) as avg_drop_off
   FROM event_counts 
   ORDER BY event_count DESC

)

select * from event_percent