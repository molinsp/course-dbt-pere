{% snapshot promos_snapshot %}

  {{
    config(
      target_schema='snapshots',
      unique_key='id',

      strategy='check',
      check_cols=['discout', 'status']
    )
  }}

  SELECT * 
  FROM {{ ref('stg_greenery', 'promos') }}

{% endsnapshot %}