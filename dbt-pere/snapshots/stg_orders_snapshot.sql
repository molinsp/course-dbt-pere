{% snapshot stg_orders_snapshot %}

  {{
    config(
      target_schema='snapshots',
      unique_key='order_id',

      strategy='check',
      check_cols=['status']
    )
  }}

  SELECT * 
  FROM {{ ref('stg_orders') }}

{% endsnapshot %}