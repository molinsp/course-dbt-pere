
with source as (

    select * from {{ source('stg_greenery', 'promos') }}

),

renamed as (

    select
        id,
        promo_id,
        discout,
        status

    from source

)

select * from renamed

