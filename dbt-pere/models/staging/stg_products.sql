
with source as (

    select * from {{ source('stg_greenery', 'products') }}

),

renamed as (

    select
        id,
        product_id,
        name,
        price,
        quantity

    from source

)

select * from renamed

