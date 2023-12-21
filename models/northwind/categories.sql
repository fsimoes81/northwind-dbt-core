{{
    config(
        materialized='incremental',
        unique_key='category_id'
    )
}}

select *, now() as dh_insert from {{source('sources','categories')}}