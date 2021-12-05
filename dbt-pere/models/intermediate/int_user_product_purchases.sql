with products_sold as (
    select * from {{ ref('int_products_sold') }}
)

SELECT  order_user_id as user_id
    , product_name
    , COUNT(DISTINCT order_id) as times_purchased
    , SUM(order_product_quantity) as total_amount_purchased
FROM products_sold
GROUP BY 1,2
