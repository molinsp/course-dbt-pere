with users as (
    SELECT * FROM {{ ref('int_users') }}
)

select
    user_id
    , first_name
    , last_name
    , email
    , phone_number
    , created_at
    , address
    , address_zipcode
    , address_state
    , address_country
FROM users