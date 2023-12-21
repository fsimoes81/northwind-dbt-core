select * from {{ref('orderfact')}}
where date_part('year', order_date) = 2020