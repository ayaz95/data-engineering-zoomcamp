select 
cast(VendorID as integer) as vendor_id,
cast(tpep_pickup_datetime as timestamp) as pickup_datetime,
cast(tpep_dropoff_datetime as timestamp) as dropoff_datetime,
store_and_fwd_flag,
cast(RatecodeID as integer) as rate_code_id,
cast(PULocationID as integer) as pickup_location_id,
cast(DOLocationID as integer) as dropoff_location_id,
cast(passenger_count as integer) as passenger_count,
cast(trip_distance as numeric) as trip_distance,
cast(fare_amount as numeric) as fare_amount,
cast(extra as numeric) as extra,
cast(mta_tax as numeric) as mta_tax,
cast(tip_amount as numeric) as tip_amount,
cast(tolls_amount as numeric) as tolls_amount,
0 as ehail_fee,
cast(improvement_surcharge as numeric) as improvement_surcharge,
cast(total_amount as numeric) as total_amount,
cast(payment_type as numeric) as payment_type,
1 as trip_type
 from {{ source('raw_data', 'YellowTaxi_TripData')}} 
 where VendorID is not null