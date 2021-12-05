with users_product_purchases as (
    select * from {{ ref('int_user_product_purchases') }}
),
users as (
    select * from {{ ref('int_users') }}
), most_times_purchased_ranked AS (

    SELECT    user_id
           , product_name
           , rank() OVER (PARTITION BY user_id ORDER BY times_purchased DESC) as rank_most_times_purchased
           , rank() OVER (PARTITION BY user_id ORDER BY total_amount_purchased DESC) as rank_most_quantity_purchased
    FROM users_product_purchases
)
, most_times_purchased AS (
    SELECT      user_id
            , STRING_AGG(product_name,',') as most_times_purchased_products

    FROM most_times_purchased_ranked
    WHERE rank_most_times_purchased = 1
    GROUP BY 1

)

, most_quantity_purchased AS (
    SELECT      user_id
            , STRING_AGG(product_name,',') as most_quantity_purchased_products

    FROM most_times_purchased_ranked
    WHERE rank_most_quantity_purchased = 1
    GROUP BY 1
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
    , most_times_purchased_products
    , most_quantity_purchased_products

from users users
left join most_times_purchased mtp ON mtp.user_id = users.user_id
left join most_quantity_purchased mqp ON mqp.user_id = users.user_id