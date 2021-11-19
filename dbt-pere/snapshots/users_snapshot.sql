{% snapshot users_snapshot %}

  {{
    config(
      target_schema='snapshots',
      unique_key='id',

      strategy='timestamp',
      updated_at='updated_at'
    )
  }}

  SELECT * 
  FROM {{ source('stg_greenery', 'users') }}

{% endsnapshot %}