with orders as (
    select * from {{ ref('int_orders') }}
)
, order_items as (
   select * from {{ ref('stg_order_items') }} 
)
, products as (
   select * from {{ ref('stg_products') }} 
)
, promos as (
   select * from {{ ref('stg_promos') }} 
)

select orders.order_id
    , orders.user_id as order_user_id
    , orders.created_at as order_created_at
    , orders.order_cost 
    , orders.shipping_cost as order_shipping_cost
    , orders.order_total
    , orders.shipping_service as order_shipping_service
    , orders.delivered_at as order_delivered_at
    , orders.status
    , orders.address
    , orders.address_zipcode 
    , orders.address_state
    , orders.address_country
    , promos.discount as promos_discount
    , promos.status as promos_status
    , products.name as product_name
    , products.price as product_price
    , order_items.quantity as order_product_quantity
from orders
left join promos
    on orders.promo_id = promos.promo_id
left join order_items
    on orders.order_id = order_items.order_id
left join products
    on order_items.product_id = products.product_id