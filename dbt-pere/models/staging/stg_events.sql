
with source as (

    select * from {{ source('stg_greenery', 'events') }}

),

renamed as (

    select
        id,
        event_id,
        session_id,
        user_id,
        page_url,
        created_at,
        event_type,
        substring(page_url from '.*product\/(.*)') as product_id

    from source

)

select * from renamed

