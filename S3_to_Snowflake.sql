-- Drop existing Zillow database
drop database if exists zillow_database;

-- Create Zillow database
create database zillow_database;

-- Drop existing Zillow warehouse
drop warehouse if exists zillow_analytics;

-- Create Zillow warehouse
create warehouse zillow_analytics;

create schema zillow_schema;
create or replace table zillow_database.zillow_schema.zillow_table (
  bathrooms INT,
  bedrooms INT,
  city STRING,
  country STRING,
  homeStatus STRING,
  homeType STRING,
  isFeatured BOOLEAN,
  isNonOwnerOccupied BOOLEAN, 
  isPreforeclosureAuction BOOLEAN,
  isPremierBuilder BOOLEAN,
  isZillowOwned BOOLEAN,
  latitude INT, 
  longitude INT,
  livingArea INT,
  price INT,
  zestimate INT,
  rentZestimate INT,
  streetAddress STRING,
  zipcode STRING
);
-- Test Table
SELECT * FROM ZILLOW_DATABASE.ZILLOW_SCHEMA.ZILLOW_TABLE;


-- Create schema for file format definitions
CREATE SCHEMA file_format_schema;
-- Define CSV file format for Zillow data
create or replace file format zillow_database.file_format_schema.csv_format
    type='csv'
    compression='none'
    FIELD_DELIMITER=','
    -- RECORD_DELIMITER='\n'
    SKIP_HEADER=1

    
-- Create schema for external stages    
create schema external_stage_schema;
-- Create external stage for Zillow data 
create or replace stage zillow_database.external_stage_schema.zillow_data_stage
    url="s3://zillow-data-storage/"
    FILE_FORMAT=zillow_database.file_format_schema.csv_format
    CREDENTIALS = ( AWS_KEY_ID = 'AKIAXESQ6JSJYHZQKY2N' 
                    AWS_SECRET_KEY = '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')
-- List files in the stage
list @zillow_database.external_stage_schema.zillow_data_stage;

-- Create schema for Snowpipe definitions
create schema zillow_database.snowpipe_schema

--create pipe to ingest data from external stage to snowflake table
create or replace pipe zillow_database.snowpipe_schema.zillow_snowpipe
    AUTO_INGEST=TRUE
    AS
    copy into zillow_database.zillow_schema.zillow_table
    from @zillow_database.external_stage_schema.zillow_data_stage

DESCRIBE pipe zillow_database.snowpipe_schema.zillow_snowpipe


    
