# Week 3 Exercises 
## Part 1
Answer: 36%
```sql
select 
    100.0 *
    count(
        distinct
        case when event_type = 'checkout' then session_id else null end
      )
    /
    count(
        distinct session_id 
    ) as conversion_rate
from "stg_events" 
```

Answer:

**Query**
```sql
with sessions as (
     select 
          session_id
          , MAX(product_id) as product_id
          , sum(case when event_type = 'checkout' then 1 else 0 end) as has_checkout
          , 1 as session_count
     from "stg_events"
     group by session_id
)

select p.name
     , 100.0*sum(has_checkout)/sum(session_count) as conversion_rate
from sessions s
left join "stg_products" p on s.product_id = p.product_id
where s.product_id is not null
group by p.name
order by 2 desc
```

## Part 2
Added the jinja macro to flag event types per sessions

```
{% set event_types = dbt_utils.get_query_results_as_dict("select distinct event_type from" ~ ref('stg_events')) %}

     select
     session_id
     {% for event_type in event_types['event_type'] %}
     , max(case when event_type = '{{event_type}}' then 1 else 0 end) as {{event_type}}_present
     {% endfor %}

from {{ ref('stg_events') }}
group by session_id
```

## Part 3