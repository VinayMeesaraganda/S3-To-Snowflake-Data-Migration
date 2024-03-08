# S3-To-Snowflake-Data-Migration
This script automates ingesting data in CSV format from S3 to a Snowflake table.

## Requirements:
- Snowflake account with permissions
- Locate the S3 bucket storage where the data files are stored
- Replace AWS credentials placeholders with your actual values

## Process:
- Run the script to create Snowflake objects (database, table, etc.) and configure ingestion.
- Place Zillow data in the S3 bucket.
- Snowpipe automatically ingests new data.

## Output:
Data is available for analysis in the Snowflake table.

A detailed explanation and steps to execute it are mentioned in the blog here [here](https://medium.com/@raj.vinay2408/s3-to-snowflake-seamless-data-migration-44289dd43f72).
