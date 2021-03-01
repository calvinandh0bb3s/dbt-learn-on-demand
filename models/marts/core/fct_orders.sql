with orders as (

    select * from {{ ref('stg_orders')}}
    
),
payments as (

    select * from {{ ref('stg_payments') }}

),
successes as (
    select
        order_id,
        sum(case when status = 'success' then amount else 0 end) as successful_payments
    from payments
    group by order_id
),

final as (
    
    select 
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        successes.successful_payments as amount
    from orders 
    left join successes using (order_id)
)

select * from final