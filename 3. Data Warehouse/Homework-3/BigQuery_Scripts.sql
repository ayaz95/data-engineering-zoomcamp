-- Create an external table using the Yellow Taxi Trip Records.

CREATE OR REPLACE EXTERNAL TABLE `kestra-sandbox-486100.zoomcamp.yellow_taxi_external`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://ayaz_dezoomcamp_hw3_2025/yellow_tripdata_2024-*.parquet']
);

-- Create a regular, materialized table in BigQuery using the Yellow Taxi Trip Records. 

CREATE OR REPLACE TABLE `kestra-sandbox-486100.zoomcamp.yellow_taxi_materialized`
AS (SELECT * FROM `kestra-sandbox-486100.zoomcamp.yellow_taxi_external`)

-- Q1. What is count of records for the 2024 Yellow Taxi Data?

SELECT COUNT(*) FROM `kestra-sandbox-486100.zoomcamp.yellow_taxi_materialized`
-- Output: 20,332,093

/* Q2. Write a query to count the distinct number of PULocationIDs for the entire dataset on both the tables.

What is the estimated amount of data that will be read when this query is executed on the External Table and the Table?

18.82 MB for the External Table and 47.60 MB for the Materialized Table
0 MB for the External Table and 155.12 MB for the Materialized Table
2.14 GB for the External Table and 0MB for the Materialized Table
0 MB for the External Table and 0MB for the Materialized Table */

/* External table */
SELECT DISTINCT PULocationID FROM `kestra-sandbox-486100.zoomcamp.yellow_taxi_external`

/* Materialized table */
SELECT DISTINCT PULocationID FROM `kestra-sandbox-486100.zoomcamp.yellow_taxi_materialized`

-- Output: 0 MB for the External Table and 155.12 MB for the Materialized Table

/* Q3. Write a query to retrieve the PULocationID from the table (not the external table) in BigQuery. Now write a query to retrieve the PULocationID and DOLocationID on the same table.

Why are the estimated number of Bytes different?

- BigQuery is a columnar database, and it only scans the specific columns requested in the query. Querying two columns (PULocationID, DOLocationID) requires reading more data than querying one column (PULocationID), leading to a higher estimated number of bytes processed.
- BigQuery duplicates data across multiple storage partitions, so selecting two columns instead of one requires scanning the table twice, doubling the estimated bytes processed.
- BigQuery automatically caches the first queried column, so adding a second column increases processing time but does not affect the estimated bytes scanned.
- When selecting multiple columns, BigQuery performs an implicit join operation between them, increasing the estimated bytes processed
*/

/* 155.12 MB */
SELECT PULocationID FROM `kestra-sandbox-486100.zoomcamp.yellow_taxi_materialized`

/* 310.24 MB */
SELECT PULocationID, DOLocationID FROM `kestra-sandbox-486100.zoomcamp.yellow_taxi_materialized`

/* Output:  BigQuery is a columnar database, and it only scans the specific columns requested in the query. 
Querying two columns (PULocationID, DOLocationID) requires reading more data than querying one column (PULocationID), leading to a higher estimated number of bytes processed. */


-- Q4. How many records have a fare_amount of 0?

SELECT COUNT(fare_amount) FROM `kestra-sandbox-486100.zoomcamp.yellow_taxi_external` WHERE fare_amount = 0

-- Output: 8,333

/* Q5. What is the best strategy to make an optimized table in Big Query if your query will always filter based on tpep_dropoff_datetime and order the results by VendorID (Create a new table with this strategy)

Partition by tpep_dropoff_datetime and Cluster on VendorID
Cluster on by tpep_dropoff_datetime and Cluster on VendorID
Cluster on tpep_dropoff_datetime Partition by VendorID
Partition by tpep_dropoff_datetime and Partition by VendorID */

-- Output - Partition by tpep_dropoff_datetime and Cluster on VendorID


/* Q6. Write a query to retrieve the distinct VendorIDs between tpep_dropoff_datetime 2024-03-01 and 2024-03-15 (inclusive)

Use the materialized table you created earlier in your from clause and note the estimated bytes. Now change the table in the from clause to the partitioned table you created for question 5 and note the estimated bytes processed. What are these values?

Choose the answer which most closely matches.

12.47 MB for non-partitioned table and 326.42 MB for the partitioned table
310.24 MB for non-partitioned table and 26.84 MB for the partitioned table
5.87 MB for non-partitioned table and 0 MB for the partitioned table
310.31 MB for non-partitioned table and 285.64 MB for the partitioned table */

-- Creating a partitioning and clustering table 
CREATE OR REPLACE TABLE `kestra-sandbox-486100.zoomcamp.yellow_taxi_partitioned`
PARTITION BY DATE(tpep_dropoff_datetime)
CLUSTER BY VendorID
AS
SELECT *
FROM `kestra-sandbox-486100.zoomcamp.yellow_taxi_external`;

-- distinct VendorIDs between tpep_dropoff_datetime 2024-03-01 and 2024-03-15 from materialized table
SELECT COUNT(VendorID) FROM `kestra-sandbox-486100.zoomcamp.yellow_taxi_materialized`
WHERE tpep_dropoff_datetime BETWEEN '2024-03-01' and '2024-03-15'

-- distinct VendorIDs between tpep_dropoff_datetime 2024-03-01 and 2024-03-15 from partitioned table 
SELECT COUNT(VendorID) FROM `kestra-sandbox-486100.zoomcamp.yellow_taxi_partitioned`
WHERE tpep_dropoff_datetime BETWEEN '2024-03-01' and '2024-03-15'

-- Output: 310.24 MB for non-partitioned table and 26.84 MB for the partitioned table


/* Q7. Where is the data stored in the External Table you created?

Big Query
Container Registry
GCP Bucket
Big Table */

-- Output: GCP Bucket

/* Q8. It is best practice in Big Query to always cluster your data:

True
False*/

-- Output: False

/* Q9. Write a SELECT count(*) query FROM the materialized table you created. How many bytes does it estimate will be read? Why? */

/* Output: Estimated bytes will be 0 because BigQuery uses table metadata rather than scanning actual data. 
The row count is stored as metadata when the table was created from the external table source. */





