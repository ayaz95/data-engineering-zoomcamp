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

<svg xmlns="http://www.w3.org/2000/svg" width="640" height="450" viewBox="0 0 640 450">
  <rect width="640" height="450" fill="#1a1a2e" rx="6"/>
  <style>
    text {
      font-family: 'Courier New', Courier, monospace;
      font-size: 13.2px;
      fill: #e0e0e0;
    }
    .comment { fill: #6a9955; }
  </style>

  <text x="16" y="28">my_new_project/</text>
  <text x="16" y="50">├── models/</text>
  <text x="16" y="72">│   ├── staging/</text>
  <text x="16" y="94">│   │   ├── stg_green_tripdata.sql<tspan class="comment">       # Cleaned Green Taxi data</tspan></text>
  <text x="16" y="116">│   │   ├── stg_yellow_tripdata.sql<tspan class="comment">      # Cleaned Yellow Taxi data</tspan></text>
  <text x="16" y="138">│   │   └── sources.yml<tspan class="comment">                  # Source definitions</tspan></text>
  <text x="16" y="160">│   ├── intermediate/</text>
  <text x="16" y="182">│   │   ├── int_trips_unioned.sql<tspan class="comment">        # Union of Green + Yellow trips</tspan></text>
  <text x="16" y="204">│   │   └── int_trips.sql<tspan class="comment">                # Trips with surrogate key &amp; enrichment</tspan></text>
  <text x="16" y="226">│   └── marts/</text>
  <text x="16" y="248">│       ├── schema.yml<tspan class="comment">                   # Model contracts and documentation</tspan></text>
  <text x="16" y="270">│       ├── dim_zones.sql<tspan class="comment">                # Dimension table for taxi zones</tspan></text>
  <text x="16" y="292">│       ├── fct_trips.sql<tspan class="comment">                # Core fact table for all trips</tspan></text>
  <text x="16" y="314">│       └── reporting/</text>
  <text x="16" y="336">│           └── monthly_revenue_per_locations.sql<tspan class="comment">  # Monthly revenue report</tspan></text>
  <text x="16" y="358">├── seeds/</text>
  <text x="16" y="380">│   ├── taxi_zone_lookup.csv<tspan class="comment">             # NYC taxi zone reference data</tspan></text>
  <text x="16" y="402">│   └── payment_type_lookup.csv<tspan class="comment">          # Payment type reference data</tspan></text>
  <text x="16" y="424">├── dbt_project.yml<tspan class="comment">                       # Project configuration</tspan></text>
  <text x="16" y="446">└── packages.yml<tspan class="comment">                          # dbt package dependencies</tspan></text>
</svg>

### Data Architecture
The project follows a layered transformation approach:

Raw Data (BigQuery)
      ↓
Staging Models        → Clean and cast raw source data
      ↓
Intermediate Models   → Union Green + Yellow taxi trips
      ↓
Marts (Dim + Fact)    → Dimension and Fact tables for analytics
      ↓
Reporting Models      → Aggregated metrics for dashboards

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
