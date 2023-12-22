
{{
    config(
        materialized='incremental',
        unique_key='category_id',
        incremental_strategy='delete+insert',
        tags = ['incremental_mode']
    )
}}


select * from {{source('sources','categories')}}

-- {% if is_incremental() %}
-- where category_id > (select max(category_id) from {{ this }})
-- {% endif %}