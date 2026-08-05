with customer_orders as (

    select
        c.customer_unique_id,
        o.order_id,
        o.order_purchase_timestamp
    from {{ ref('fct_orders') }} o
    left join {{ ref('stg_customers') }} c on o.customer_id = c.customer_id

),

first_purchase as (

    select
        customer_unique_id,
        date_trunc('month', min(order_purchase_timestamp)) as cohort_month
    from customer_orders
    group by customer_unique_id

),

orders_with_cohort as (

    select
        co.customer_unique_id,
        fp.cohort_month,
        date_trunc('month', co.order_purchase_timestamp) as order_month
    from customer_orders co
    left join first_purchase fp on co.customer_unique_id = fp.customer_unique_id

),

cohort_activity as (

    select
        cohort_month,
        order_month,
        date_diff('month', cohort_month, order_month) as month_number,
        count(distinct customer_unique_id) as n_active_customers
    from orders_with_cohort
    group by cohort_month, order_month

),

cohort_size as (

    select
        cohort_month,
        n_active_customers as cohort_initial_size
    from cohort_activity
    where month_number = 0

),

retention_rates as (

    select
        ca.cohort_month,
        ca.order_month,
        ca.month_number,
        ca.n_active_customers,
        cs.cohort_initial_size,
        round(ca.n_active_customers * 100.0 / cs.cohort_initial_size, 2) as retention_rate_pct
    from cohort_activity ca
    left join cohort_size cs on ca.cohort_month = cs.cohort_month

)

select * from retention_rates
order by cohort_month, month_number

