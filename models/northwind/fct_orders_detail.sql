select 
	od.order_id, 
	od.product_id, 
	pr.product_name,
	pr.supplier_id,
	pr.category_id,
	od.unit_price, 
	od.quantity, 
	od.unit_price * od.quantity as total,
	(pr.unit_price * od.quantity) - (od.unit_price * od.quantity) as discount,
    now() as dh_insert
from {{source('sources','orderdetails')}} od
left join {{source('sources','products')}} pr
on (od.product_id = pr.product_id)