
with source as (

    select * from {{ source('stg_greenery', 'order_items') }}

),

renamed as (

    select
        id,
        order_id,
        product_id,
        quantity

    from source

)

select * from renamed

