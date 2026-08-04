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
),

rfm_scores as (

    select 
        customer_unique_id,
        n_orders, 
        total_spent,
        last_order_date,
        recency_days,
        ntile(5) over (order by recency_days desc, customer_unique_id) as r_score,
        ntile(5) over (order by n_orders asc, customer_unique_id) as f_score,
        ntile(5) over (order by total_spent asc, customer_unique_id) as m_score
    
    from rfm_with_recency
),

segments as (

    select
        *,
        case
            when r_score >= 4 and f_score >= 4 and m_score >= 4 then 'Champions'
            when r_score >= 4 and f_score <= 2 then 'New Customers'
            when r_score >= 3 and f_score >= 3 then 'Loyal Customers'
            when r_score <= 2 and f_score >= 4 and m_score >= 4 then 'At Risk'
            when r_score <= 2 and f_score <= 2 and m_score <= 2 then 'Lost'
            when r_score >= 3 and m_score >= 4 then 'Big Spenders'
            when r_score <= 2 and m_score >= 3 then 'Needs Attention'
            when r_score >= 3 then 'Promising'
            else 'Others'
        end as customer_segment

    from rfm_scores

)

select * from segments


