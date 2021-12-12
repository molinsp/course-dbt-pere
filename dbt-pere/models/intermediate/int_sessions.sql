{% set event_types = dbt_utils.get_query_results_as_dict("select distinct event_type from" ~ ref('stg_events')) %}

with sessions_with_event_dummies as (
     select
     session_id
     {% for event_type in event_types['event_type'] %}
     , max(case when event_type = '{{event_type}}' then 1 else 0 end) as has_{{event_type}}
     {% endfor %}
     , MIN(created_at) as session_start
     , MAX(created_at) as session_end

from {{ ref('stg_events') }}
group by session_id
),
sessions_with_products as (
     select  session_id, product_id from {{ ref('stg_events') }} group by 1,2
),
sessions_with_users as (
     select  session_id, user_id from {{ ref('stg_events') }} group by 1,2
)

select s.*, p.product_id, u.user_id
from sessions_with_event_dummies s
left join sessions_with_products p
     on s.session_id = p.session_id
left join sessions_with_users u
     on s.session_id = u.session_id
