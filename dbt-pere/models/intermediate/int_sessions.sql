{% set event_types = dbt_utils.get_query_results_as_dict("select distinct event_type from" ~ ref('stg_events')) %}

     select
     session_id
     {% for event_type in event_types['event_type'] %}
     , max(case when event_type = '{{event_type}}' then 1 else 0 end) as {{event_type}}_present
     {% endfor %}

from {{ ref('stg_events') }}
group by session_id