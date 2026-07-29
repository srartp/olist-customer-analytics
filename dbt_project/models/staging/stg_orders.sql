select
    order_id,
    customer_id,
    order_status,
    order_purchase_timestamp,
    order_delivered_customer_date
from {{ source('olist_raw', 'orders') }}
where order_status = 'delivered'
  and order_purchase_timestamp >= '2017-01-01'
  and order_purchase_timestamp < '2018-09-01'