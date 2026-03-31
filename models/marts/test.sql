select id from `jaffle_shop_raw.raw_orders`
order by id
limit 1;

update `jaffle_shop_raw.raw_orders`
set ORDERED_AT = current_timestamp()
where id = '00702550-b488-4e28-a7b9-87d5d4fd2ddd';