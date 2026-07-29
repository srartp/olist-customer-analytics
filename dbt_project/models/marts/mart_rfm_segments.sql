with customer_orders as (

    select
        c.customer_unique_id,
        o.order_id,
        o.order_purchase_timestamp,
        o.total_payment_value
    from {{ ref('fct_orders') }} o
    left join {{ ref('stg_customers') }} c ON o.customer_id = c.customer_id
),

rfm_base as (

    select
        customer_unique_id,
        count(order_id) as n_orders,
        sum(total_payment_value) as total_spent,
        max(order_purchase_timestamp) as last_order_date
    from customer_orders
    group by customer_unique_id
),

rfm_with_recency as (

    select
        customer_unique_id,
        n_orders,
        total_spent,
        last_order_date,
        date_diff('day', last_order_date, (select max(order_purchase_timestamp) from {{ ref('fct_orders') }})) as recency_days
    from rfm_base
)
select * from rfm_with_recency

