--Exploración inicial
SELECT *
FROM "memory"."store_data.csv";

--Tipos de dato por columna
DESCRIBE "memory"."store_data.csv";

--Conteo de nulos
SELECT 
  SUM(CASE WHEN row_id ISNULL THEN 1 ELSE 0 END) AS row_id,
  SUM(CASE WHEN order_id ISNULL THEN 1 ELSE 0 END) AS order_id,
  SUM(CASE WHEN order_date ISNULL THEN 1 ELSE 0 END) AS order_date,
  SUM(CASE WHEN ship_date ISNULL THEN 1 ELSE 0 END) AS ship_date,
  SUM(CASE WHEN ship_mode ISNULL THEN 1 ELSE 0 END) AS ship_mode,
  SUM(CASE WHEN customer_id ISNULL THEN 1 ELSE 0 END) AS customer_id,
  SUM(CASE WHEN customer_name ISNULL THEN 1 ELSE 0 END) AS customer_name,
  SUM(CASE WHEN segment ISNULL THEN 1 ELSE 0 END) AS segment,
  SUM(CASE WHEN country ISNULL THEN 1 ELSE 0 END) AS country,
  SUM(CASE WHEN city ISNULL THEN 1 ELSE 0 END) AS city,
  SUM(CASE WHEN state ISNULL THEN 1 ELSE 0 END) AS state,
  SUM(CASE WHEN postal_code ISNULL THEN 1 ELSE 0 END) AS postal_code,
  SUM(CASE WHEN region ISNULL THEN 1 ELSE 0 END) AS region,
  SUM(CASE WHEN product_id ISNULL THEN 1 ELSE 0 END) AS product_id,
  SUM(CASE WHEN category ISNULL THEN 1 ELSE 0 END) AS category,
  SUM(CASE WHEN sub_category ISNULL THEN 1 ELSE 0 END) AS sub_category,
  SUM(CASE WHEN product_name ISNULL THEN 1 ELSE 0 END) AS product_name,
  SUM(CASE WHEN sales ISNULL THEN 1 ELSE 0 END) AS sales,
  SUM(CASE WHEN quantity ISNULL THEN 1 ELSE 0 END) AS quantity,
  SUM(CASE WHEN discount ISNULL THEN 1 ELSE 0 END) AS discount,
  SUM(CASE WHEN profit ISNULL THEN 1 ELSE 0 END) AS profit
FROM "memory"."store_data.csv";

--Conteo de duplicados
SELECT 
  COUNT(*) AS total_registros,
  COUNT(DISTINCT row_id) AS total_unicos
FROM "memory"."store_data.csv";