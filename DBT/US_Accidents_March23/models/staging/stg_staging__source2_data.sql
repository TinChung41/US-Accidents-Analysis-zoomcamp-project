{{
  config(
    materialized='view'
  )
}}

with 

source as (

  select * from {{ source('staging', 'dev_gcs_to_bigquerry_standardize_columns_v1') }}

),

sample as (

  select
    -- identifiers
    {{ dbt_utils.generate_surrogate_key(['id', 'start_time']) }} as recordid,
    id,
    source,
    {{ dbt.safe_cast("severity", api.Column.translate_type("integer")) }} as severity,
    {{ get_severity_type_descripition('severity') }} as severity_type_description,
    
    -- timestamps
    cast(start_time as timestamp) as start_time,
    cast(end_time as timestamp) as end_time,
    cast(weather_timestamp as timestamp) as weather_timestamp,

    -- location info
    cast(start_lat as numeric) as start_lat,
    cast(start_lng as numeric) as start_lng,
    cast(end_lat as numeric) as end_lat,
    cast(end_lng as numeric) as end_lng,
    cast(distance_mi as numeric) as distance_mi,
    description,
    street,
    city,
    county,
    state,
    cast(substring(zipcode, 1, 5) as numeric) as zipcode,
    country,
    timezone,
    airport_code,
    
    -- weather info
    cast(temperature_f as numeric) as temperature_f,
    cast(wind_chill_f as numeric) as wind_chill_f,
    cast(humidity as numeric) as humidity,
    cast(pressure_in as numeric) as pressure_in,
    cast(visibility_mi as numeric) as visibility_mi,
    wind_direction,
    cast(wind_speed_mph as numeric) as wind_speed_mph,
    cast(precipitation_in as numeric) as precipitation_in,
    weather_condition,

    -- road info
    amenity,
    bump,
    crossing,
    give_way,
    junction,
    no_exit,
    railway,
    roundabout,
    station,
    stop,
    traffic_calming,
    traffic_signal,
    turning_loop,

    -- time info
    sunrise_sunset,
    civil_twilight,
    nautical_twilight,
    astronomical_twilight

  from source

)

select * from sample