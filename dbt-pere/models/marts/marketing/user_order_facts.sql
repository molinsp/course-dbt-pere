with orders as (
    select * from {{ ref('int_orders') }}
)
, users as (
    select * from {{ ref('int_users') }}
)
, order_facts as (
    select 
        user_id
        , count(distinct order_id) as order_count
        , max(created_at) as last_order
        , sum(order_total) as total_ammount_ordered
        , count(distinct shipping_service) as count_shipping_services
        , sum(case when promo_id is not null then 1 else 0 end) as count_orders_with_discount
    from orders
    where created_at is not null
    group by 1
)


select users.user_id
    , users.first_name
    , users.last_name
    , users.email
    , users.phone_number
    , users.created_at
    , users.address
    , users.address_zipcode
    , users.address_state
    , users.address_country
    , order_facts.order_count
    , order_facts.last_order
    , order_facts.total_ammount_ordered
    , order_facts.total_ammount_ordered / nullif(order_facts.order_count, 0) as avg_order_ammount
    , order_facts.count_shipping_services
    , order_facts.count_orders_with_discount
    , 100.0 * order_facts.count_orders_with_discount / nullif(order_facts.order_count, 0) as percent_orders_with_discount
from users
left join order_facts
    on users.user_id = order_facts.user_id