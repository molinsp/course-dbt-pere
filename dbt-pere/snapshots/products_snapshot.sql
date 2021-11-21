{% snapshot products_snapshot %}

  {{
    config(
      target_schema='snapshots',
      unique_key='id',

      strategy='check',
      check_cols=['price', 'quantity']
    )
  }}

  SELECT * 
  FROM {{ source('stg_greenery', 'products') }}

{% endsnapshot %}