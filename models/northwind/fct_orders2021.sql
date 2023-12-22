select * from {{ref('fct_orders')}}
where date_part('year', order_date) = 2021