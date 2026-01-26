import pandas as pd
from sqlalchemy import create_engine

dtype = {
    "VendorID": "Int64",
    "passenger_count": "Int64",
    "trip_distance": "float64",
    "RatecodeID": "Int64",
    "store_and_fwd_flag": "string",
    "PULocationID": "Int64",
    "DOLocationID": "Int64",
    "payment_type": "Int64",
    "fare_amount": "float64",
    "extra": "float64",
    "mta_tax": "float64",
    "tip_amount": "float64",
    "tolls_amount": "float64",
    "improvement_surcharge": "float64",
    "total_amount": "float64",
    "congestion_surcharge": "float64"
}

def ingest_data(
        url: str,
        engine,
        target_table: str
) -> pd.DataFrame:
    if url.endswith(".parquet"):
        df = pd.read_parquet(url)
    else:
        df = pd.read_csv(
            url,
            dtype=dtype
        )


    df.head(0).to_sql(
        name=target_table,
        con=engine,
        if_exists="replace",
        index=False
    )
    print(f"Table {target_table} created")

    df.to_sql(
        name=target_table,
        con=engine,
        if_exists="append",
        index=False
    )
    print(f"Inserted {target_table} : {len(df)}")

    return df


def main():
    pg_user = 'root'
    pg_pass = 'root'
    pg_host = 'pgdatabase'
    pg_port = '5432'
    pg_db = 'ny_taxi'

    target_table1 = 'green_taxi_data'
    target_table2 = 'taxi_zones'

    engine = create_engine(
        f'postgresql://{pg_user}:{pg_pass}@{pg_host}:{pg_port}/{pg_db}'
    )

    trip_url = 'https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2025-11.parquet'
    zone_url = 'https://github.com/DataTalksClub/nyc-tlc-data/releases/download/misc/taxi_zone_lookup.csv'

    # Ingest green taxi trips
    ingest_data(
        url=trip_url,
        engine=engine,
        target_table=target_table1
    )

    # Ingest taxi zones lookup
    ingest_data(
        url=zone_url,
        engine=engine,
        target_table=target_table2
    )


if __name__ == '__main__':
    main()