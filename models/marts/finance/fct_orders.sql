{{ config(materialized="incremental",
unique_key="order_id",
incremental_strategy="merge") }}



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
-- ,
-- final as (
-- select c.customer_id, o.order_id, o.order_date, sum(p.amount) as amount
-- from orders o 
-- left outer join customers c on c.customer_id = o.customer_id
-- left outer join payments p on o.order_id = p.order_id
-- group by 1,2,3
-- )
-- select * from final


-- select * from final
select * from orders
{% if is_incremental() %}
where order_date > (select max(order_date) from {{ this }})
{% endif %}
order by order_date desc