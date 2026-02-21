## Analytics Engineering with dbt & BigQuery

### Overview
This project is part of the Data Engineering Zoomcamp and covers Analytics Engineering using dbt (data build tool) with Google BigQuery as the data warehouse. It transforms raw NYC Taxi trip data into clean, analytics-ready models following the Medallion Architecture pattern.

### Tech Stack
dbt Cloud — transformation and orchestration
Google BigQuery — data warehouse
NYC Taxi Dataset — Green and Yellow taxi trip data
Git — version control

### Project Structure 

<img width="571" height="380" alt="image" src="https://github.com/user-attachments/assets/1303d2b0-9020-4061-aeb4-a798aa979b4f" />

### Data Architecture
The project follows a layered transformation approach:

<img width="481" height="207" alt="image" src="https://github.com/user-attachments/assets/4c59ae83-8651-43f7-a992-60e2307214b4" />

### Models

1. Staging
stg_green_tripdata — Casts and renames columns from raw Green Taxi data. Filters out null vendor records.
stg_yellow_tripdata — Casts and renames columns from raw Yellow Taxi data. Filters out null vendor records.

2. Intermediate
int_trips_unioned — Unions Green and Yellow taxi trips into a single dataset. Adds service_type column ('Green' or 'Yellow') and generates a unique trip_id using a surrogate key.

3. Marts
dim_zones — Dimension table built from the taxi_zone_lookup seed, containing borough, zone, and service zone for each location ID.
fct_trips — Core fact table joining trips with pickup and dropoff zone dimensions. Includes trip duration in minutes.
monthly_revenue_per_locations — Reporting model aggregating monthly revenue, trip counts, and averages by pickup zone and service type.

### Configuration

Set up your BigQuery connection in dbt Cloud under Account Settings → Projects → Connection
Ensure your development dataset is configured under Profile Settings → Credentials
Update dbt_project.yml with your project name and schema settings

### Running the project 

# Install dependencies
dbt deps

# Load seed files into BigQuery
dbt seed

# Run all models
dbt run

# Run tests
dbt test

# Run everything together
dbt build

### Running Specific Models

# Run only staging models
dbt run --select staging

# Run a specific model and all its dependencies
dbt run --select +fct_trips

# Run a specific model and all downstream models
dbt run --select fct_trips+

### Source Data
The raw data is sourced from the NYC Taxi & Limousine Commission and loaded into BigQuery:

TableDescription
GreenTaxi_TripData ----> Green taxi trip records
YellowTaxi_TripData ----> Yellow taxi trip records


## Learn More
dbt Documentation - https://docs.getdbt.com/
Data Engineering Zoomcamp - https://github.com/DataTalksClub/data-engineering-zoomcamp
NYC TLC Trip Record Data - https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page
