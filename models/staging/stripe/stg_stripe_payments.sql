with

source as (

    -- {# This references seed (CSV) data - try switching to {{ source('ecom', 'raw_stores') }} #}
    select * from dbt-tutorial.stripe.payment

),

renamed as (

    select

        ----------  ids
        id as payment_id,
        orderid as order_id,

        ---------- text
        paymentmethod as payment_method,
        status,

        ---------- numerics
       amount,
        ---------- timestamps,etc
        created,
        _batched_at as batched_at

    from source

)

select * from renamed
