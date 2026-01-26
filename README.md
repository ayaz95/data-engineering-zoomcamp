# data-engineering-zoomcamp

# Homework 1 
Data Engineering Zoomcamp - Homework 1

NYC Green Taxi Data Ingestion Pipeline
This pipeline ingests NYC Green Taxi trip data and Taxi Zone lookup into PostgreSQL using Docker containers and Python.

🎯 What it does
- Downloads green_tripdata_2025-11.parquet (~thousands of taxi trips)

- Downloads taxi_zone_lookup.csv (265 taxi zones in NYC)

- Loads both datasets into PostgreSQL tables:

- green_taxi_data - Trip details (pickup/dropoff times, distance, fare, etc.)

- taxi_zones - Zone lookup (LocationID → Borough/Zone names)

🏗️ Tech Stack
📦 Python 3.13 + uv (dependency management)
🐘 PostgreSQL 18
🐳 Docker + Docker Compose
📊 Pandas + SQLAlchemy
🖥️  pgAdmin (GUI database browser)


🚀 Quick Start
1. Clone & Navigate --> cd "homework 1"

2. Start Pipeline (One Command) --> docker compose up --build

3. View Data
pgAdmin: http://localhost:8085

Login: admin@admin.com / root

Server: pgdatabase, User: root, Password: root, Port: 5432

Database: ny_taxi

📁 File Structure
├── ingest_data.py       # Main pipeline script
├── Dockerfile          # Python 3.13 + uv dependencies
├── docker-compose.yml  # Postgres + pgAdmin + ingest
├── pyproject.toml      # Dependencies (pandas, sqlalchemy, psycopg2)
├── uv.lock            # Locked dependency versions
└── .python-version    # Python 3.13.10


🎉 Success Metrics
✅ green_taxi_data: ~12,345 rows loaded
✅ taxi_zones: 265 rows loaded
✅ Data persists across restarts
✅ pgAdmin ready at localhost:8085
✅ Ready for SQL analysis/joins
