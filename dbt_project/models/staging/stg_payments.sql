select
    order_id,
    count(payment_sequential) as n_payments,
    sum(payment_value) as total_payment_value
from {{ source('olist_raw', 'order_payments') }}
group by order_id