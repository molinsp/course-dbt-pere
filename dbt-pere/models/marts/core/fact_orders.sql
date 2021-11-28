with orders as (
    select * from {{ ref('int_orders') }}
)

select 
    order_id
    , user_id
    , promo_id
    , created_at
    , order_cost
    , shipping_cost
    , order_total
    , shipping_service
    , estimated_delivery_at
    , delivered_at
    , status
    , address
    , address_zipcode
    , address_state
    , address_country
from orders
