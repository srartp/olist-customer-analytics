-- Load Olist raw CSV files into DuckDB

CREATE TABLE orders AS 
SELECT * FROM read_csv_auto('data/olist_orders_dataset.csv');

CREATE TABLE customers AS 
SELECT * FROM read_csv_auto('data/olist_customers_dataset.csv');

CREATE TABLE geolocation AS 
SELECT * FROM read_csv_auto('data/olist_geolocation_dataset.csv');

CREATE TABLE order_items AS 
SELECT * FROM read_csv_auto('data/olist_order_items_dataset.csv');

CREATE TABLE order_payments AS 
SELECT * FROM read_csv_auto('data/olist_order_payments_dataset.csv');

CREATE TABLE order_reviews AS 
SELECT * FROM read_csv_auto('data/olist_order_reviews_dataset.csv');

CREATE TABLE products AS 
SELECT * FROM read_csv_auto('data/olist_products_dataset.csv');

CREATE TABLE sellers AS 
SELECT * FROM read_csv_auto('data/olist_sellers_dataset.csv');

CREATE TABLE product_category_name_translation AS 
SELECT * FROM read_csv_auto('data/product_category_name_translation.csv');

