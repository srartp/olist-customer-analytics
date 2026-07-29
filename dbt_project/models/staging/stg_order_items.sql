select
    order_id,
    count(order_item_id) as n_items,
    sum(price) as items_total_price,
    sum(freight_value) as items_total_freight
from {{ source('olist_raw', 'order_items') }}
group by order_id