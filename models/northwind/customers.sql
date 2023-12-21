with markup as (
    select 
        first_value(c.customer_id) 
        over (
            partition by c.company_name, c.contact_name 
            order by c.company_name
            rows between unbounded preceding and unbounded following
        ) as unique_id
    from {{source('sources','customers')}} c 
), unique_customers as (
    select distinct unique_id from markup
), final as (
    select c.* from {{source('sources','customers')}} c  
    where customer_id in (select unique_id from unique_customers)
)
select * from final