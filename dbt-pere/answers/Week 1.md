# Week 1 Exercises 
## How many users do we have?
```sql
SELECT 
    COUNT(DISTINCT user_id)  as user_count
FROM stg_users
```
## On average, how many orders do we receive per hour?
```sql
with hourly_orders as (
    SELECT 
        date_trunc('hour', created_at) as hour
        , COUNT(order_id) as orders_per_hour
    FROM "stg_orders" 
    WHERE created_at IS NOT NULL
    GROUP BY 1
) 
SELECT  
    AVG(orders_per_hour)  as avg_orders_per_hour 
FROM hourly_orders
```
## On average, how long does an order take from being placed to being delivered?
```sql
with orders as (
    SELECT 
       created_at, 
       delivered_at,
        DATE_PART('day', delivered_at - created_at) as delivery_days
    FROM "stg_orders" 
    WHERE created_at IS NOT NULL and delivered_at IS NOT NULL
) 
SELECT 
    AVG(delivery_days) as avg_delivery_days  
FROM orders
```
## How many users have only made one purchase? Two purchases? Three+ purchases?
```sql
with orders as (
    SELECT 
       user_id, 
      COUNT(DISTINCT order_id) as order_count
    FROM "stg_orders" 
    WHERE created_at IS NOT NULL
    GROUP BY 1
) 

SELECT order_count , COUNT(DISTINCT user_id) as number_of_users  
FROM orders
GROUP BY 1
```
## Sessions per hour
```sql
with hourly_events as (
    SELECT 
        date_trunc('hour', created_at) as hour
        , COUNT(session_id) as sessions_per_hour
    FROM "stg_events" 
    WHERE created_at IS NOT NULL
    GROUP BY 1
) 
SELECT  
    AVG(sessions_per_hour)  as avg_sessions_per_hour
FROM hourly_events
```