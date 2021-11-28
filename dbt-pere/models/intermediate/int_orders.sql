with orders as (
    select * from {{ ref('stg_orders')}}
)
, addresses as (
    select * from {{ ref('stg_addresses')}}
)


select orders.*
        , addresses.address as address
        , addresses.zipcode as address_zipcode
        , addresses.state as address_state
        , addresses.country as address_country
from orders
left join addresses
    on orders.address_id = addresses.address_id

