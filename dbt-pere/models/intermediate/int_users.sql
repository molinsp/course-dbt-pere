with users as (
    select * from {{ ref('stg_users') }}
)
, addresses as (
    select * from {{ ref('stg_addresses')}}
)

select users.* 
    , addresses.address as address
        , addresses.zipcode as address_zipcode
        , addresses.state as address_state
        , addresses.country as address_country
from users
left join addresses
    on users.address_id = addresses.address_id

