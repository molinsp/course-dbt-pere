with int_sessions as (
    select * from {{ ref('int_sessions') }}
)
, dim_users as (
    select * from {{ ref('dim_users') }}
)

select s.*
    , first_name as user_first_name
    , last_name as user_last_name
    , email as user_email
    , phone_number as user_phone_number
    , created_at as user_created_at
    , address as user_address
    , address_zipcode as user_zipcode
    , address_state as user_state
    , address_country as user_country

from int_sessions s  
left join dim_users u
    on s.user_id = u.user_id


