select
    order_id,
    count(review_id) as n_reviews,
    avg(review_score) as avg_review_score
from {{ source('olist_raw', 'order_reviews') }}
group by order_id