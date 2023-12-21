with emp_calcs as (
    select
        date_part('year', current_date) - date_part('year',cast(birth_date as date)) as age,
        date_part('year', current_date) - date_part('year',cast(hire_date as date)) as time_of_service,
        first_name || ' ' || last_name as full_name,
        *
    from {{source('sources','employees')}}
)
select * from emp_calcs