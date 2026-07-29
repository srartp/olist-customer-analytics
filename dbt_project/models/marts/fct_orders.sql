select
    o.order_id,
    o.customer_id,
    o.order_status,
    o.order_purchase_timestamp,
    oi.n_items,
    oi.items_total_price,
    oi.items_total_freight,
    p.total_payment_value,
    r.avg_review_score
from {{ ref('stg_orders') }} o
left join {{ ref('stg_order_items') }} oi on o.order_id = oi.order_id
left join {{ ref('stg_payments') }} p on o.order_id = p.order_id
left join {{ ref('stg_reviews') }} r on o.order_id = r.order_id