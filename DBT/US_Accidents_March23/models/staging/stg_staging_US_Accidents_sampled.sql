{{
    config(
        materialized='view'
    )
}}
with 

source as (

    select * from {{ source('staging', 'US_Accidents_March23_sampled_500k') }}

),

renamed as (

    select
        {{ dbt_utils.generate_surrogate_key(['id', 'start_time']) }} as recordid,
        id,
        source,
        severity,
        {{ get_severity_type_descripition('severity') }} as severity_type_description,
        start_time,
        end_time,
        start_lat,
        start_lng,
        end_lat,
        end_lng,
        distance_mi,
        description,
        street,
        city,
        county,
        state,
        zipcode,
        country,
        timezone,
        airport_code,
        weather_timestamp,
        temperature_f,
        wind_chill_f,
        humidity,
        pressure_in,
        visibility_mi,
        wind_direction,
        wind_speed_mph,
        precipitation_in,
        weather_condition,
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
        sunrise_sunset,
        civil_twilight,
        nautical_twilight,
        astronomical_twilight

    from source

)

select * from renamed
