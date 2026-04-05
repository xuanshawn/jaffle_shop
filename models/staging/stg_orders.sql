{% set as_of_date = var('as_of_date', none) %}

with 
source as (
    select * from {{ source('jaffle_shop', 'orders') }}
),

staged as (
    select 
        id as order_id,
        user_id as customer_id,
        order_date,
        date_diff(current_date(), order_date, day) as days_since_ordered,
        status like '%pending%' as is_status_pending,
        case 

            when status like '%returned%' then 'returned'
            when status like '%pending%' then 'placed'
            else status
        end as status
    from source
        

)
select * from staged