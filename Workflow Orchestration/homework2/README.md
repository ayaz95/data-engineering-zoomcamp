# NYC Taxi Data Pipeline: Kestra + Docker + GCP

### 🎯 Overview ###
This project demonstrates an ELT pipeline that:

- Extracts taxi trip data from external APIs
- Loads the data into Google Cloud Storage (GCS) as a data lake
- Transforms the data in BigQuery as a data warehouse
- Provides query capabilities through BigQuery

** 📦 Prerequisites **
Before you begin, ensure you have the following installed:

- Docker (version 20.10 or higher)
- Docker Compose (version 2.0 or higher)
- Google Cloud Platform account with:
  - Cloud Storage API enabled
  - BigQuery API enabled
  - Service Account with appropriate permissions

- Git for version control

** GCP Setup Requirements **
1.  A GCP project
2. Service Account with the following roles:
      - Storage Admin (for GCS)
      - BigQuery Admin
3. Service Account JSON key file

** Architecture Overview **

<img width="1007" height="639" alt="image" src="https://github.com/user-attachments/assets/6cfc5173-1eac-4171-9e14-b4c141acf242" />

** Project Files (Deliverables) **

Docker Compose File: Multi-container setup with Kestra, PostgreSQL, and pgAdmin
Kestra Flow Files: Main ELT pipeline
Documentation: Comprehensive README with setup and usage instructions
Query Examples: Sample BigQuery queries for data analysis

** Success Metrics **

✅ Successful data extraction from API
✅ Data loaded to GCS without errors
✅ BigQuery tables created and populated
✅ Scheduled jobs running automatically
✅ Query performance under 5 seconds for standard reports
✅ Zero data loss during pipeline execution

