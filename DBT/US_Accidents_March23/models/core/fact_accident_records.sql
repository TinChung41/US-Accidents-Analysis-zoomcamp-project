{{
    config(
        materialized='table'
    )
}}

with source_1_data as (
    select *, 
        'Source1' as Source_1--renamed for clarity
    from {{ ref('stg_staging__source1_data') }} 
),
source_2_data as (
    select *,
            'Source2' as Source_2 --renamed for clarity
    from {{ ref('stg_staging__source2_data') }}
),
unioned_data as (
    select * from source_1_data
    union all
    select * from source_2_data

)
select * 
from unioned_data