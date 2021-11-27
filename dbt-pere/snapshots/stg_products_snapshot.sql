{% snapshot stg_products_snapshot %}

  {{
    config(
      target_schema='snapshots',
      unique_key='id',

      strategy='check',
      check_cols=['price', 'quantity']
    )
  }}

  SELECT * 
  FROM {{ ref('stg_products') }}

{% endsnapshot %}