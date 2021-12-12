with stg_events as (
    select * from {{ ref('stg_events') }}
)
, dim_users as (
    select * from {{ ref('dim_users') }}
)

select e.*
    , u.first_name as user_first_name
    , u.last_name as user_last_name
    , u.email as user_email
    , u.phone_number as user_phone_number
    , u.created_at as user_created_at
    , u.address as user_address
    , u.address_zipcode as user_zipcode
    , u.address_state as user_state
    , u.address_country as user_country
from stg_events e
left join dim_users u
    on e.user_id = u.user_id