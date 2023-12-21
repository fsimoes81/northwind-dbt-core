with prod as (
    select 
        c.category_name
        ,s.company_name
        ,p.product_name
        ,p.unit_price 
        ,p.product_id 
    from {{source('sources','products')}} p
    left join {{source('sources','suppliers')}} s on (p.supplier_id = s.supplier_id)
    left join {{source('sources','categories')}} c on (p.category_id = c.category_id)    
), orders_detail as (
    select
        pd.*
        ,od.order_id
        ,od.quantity
        ,od.discount
    from {{ref('orderdetails')}} od
    left join prod pd on (od.product_id = pd.product_id)
), orders as (
    select
        o.order_date
        ,o.order_id
        ,c.company_name as customer
        ,e.full_name as employee
        ,e.age
        ,e.time_of_service
    from {{source('sources','orders')}} o
    left join {{ref('customers')}} c on (o.customer_id = c.customer_id)
    left join {{ref('employees')}} e on (o.employee_id = e.employee_id)
    left join {{source('sources','shippers')}} s on (o.ship_via = s.shipper_id)
), fact as (
    select 
        od.*
        ,cast(o.order_date as date) as order_date
        ,o.customer
        ,o.employee
        ,o.age
        ,o.time_of_service
    from orders_detail od
    inner join orders o
    on (od.order_id = o.order_id)
)
select *, now() as dh_insert from fact