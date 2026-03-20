with

customers as (

    select * from {{ ref('stg_customers') }}

),

orders as (

    select * from {{ ref('orders') }}

),
payments as (

    select * from {{ ref('stg_stripe_payments') }}

)
select c.customer_id, o.order_id, sum(p.amount) as amount
from customers c 
join orders o on c.customer_id = o.customer_id
join payments p on o.order_id = p.order_id
group by 1,2
