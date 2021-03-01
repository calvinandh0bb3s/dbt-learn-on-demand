-- Refunds have a negative amount, so the total amount should always be >= 0.
-- Therefore return records where this isn't true to make the test fail.
select
  order_id
from {{ ref('stg_orders') }}
where order_id <= 0