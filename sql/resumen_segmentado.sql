--Datos por segmento de cliente
WITH y_2014 AS(  
  SELECT
    segment,
    SUM(sales) AS revenue,
    SUM(profit) AS profit,
    (SUM(profit)/SUM(sales)) * 100.00 AS margin_pct
  FROM "memory"."store_data.csv"
  WHERE EXTRACT(YEAR FROM order_date) == 2014
  GROUP BY segment
), 
y_2015 AS(
  SELECT
    segment,
    SUM(sales) AS revenue,
    SUM(profit) AS profit,
    (SUM(profit)/SUM(sales)) * 100.00 AS margin_pct
  FROM "memory"."store_data.csv"
  WHERE EXTRACT(YEAR FROM order_date) == 2015
  GROUP BY segment
), 
y_2016 AS(
  SELECT
    segment,
    SUM(sales) AS revenue,
    SUM(profit) AS profit,
    (SUM(profit)/SUM(sales)) * 100.00 AS margin_pct
  FROM "memory"."store_data.csv"
  WHERE EXTRACT(YEAR FROM order_date) == 2016
  GROUP BY segment
), 
y_2017 AS(
  SELECT
    segment,
    SUM(sales) AS revenue,
    SUM(profit) AS profit,
    (SUM(profit)/SUM(sales)) * 100.00 AS margin_pct
  FROM "memory"."store_data.csv"
  WHERE EXTRACT(YEAR FROM order_date) == 2017
  GROUP BY segment
)

SELECT 
  y_2014.segment,
  ROUND(y_2014.revenue, 2) AS revenue_2014,
  ROUND(y_2014.profit, 2) AS profit_2014,
  ROUND(y_2014.margin_pct, 2) AS margin_pct_2014,
  ROUND(y_2015.revenue, 2) AS revenue_2015,
  ROUND(y_2015.profit, 2) AS profit_2015,
  ROUND(y_2015.margin_pct, 2) AS margin_pct_2015,
  ROUND(y_2016.revenue, 2) AS revenue_2016,
  ROUND(y_2016.profit, 2) AS profit_2016,
  ROUND(y_2016.margin_pct, 2) AS margin_pct_2016,
  ROUND(y_2017.revenue, 2) AS revenue_2017,
  ROUND(y_2017.profit, 2) AS profit_2017,
  ROUND(y_2017.margin_pct, 2) AS margin_pct_2017
FROM y_2014
INNER JOIN y_2015 
  ON y_2014.segment = y_2015.segment
INNER JOIN y_2016 
  ON y_2014.segment = y_2016.segment
INNER JOIN y_2017 
  ON y_2014.segment = y_2017.segment;


--Datos por categoría de producto
 WITH y_2014 AS(  
  SELECT
    category,
    SUM(sales) AS revenue,
    SUM(profit) AS profit,
    (SUM(profit)/SUM(sales)) * 100.00 AS margin_pct
  FROM "memory"."store_data.csv"
  WHERE EXTRACT(YEAR FROM order_date) == 2014
  GROUP BY category
), 
y_2015 AS(
  SELECT
    category,
    SUM(sales) AS revenue,
    SUM(profit) AS profit,
    (SUM(profit)/SUM(sales)) * 100.00 AS margin_pct
  FROM "memory"."store_data.csv"
  WHERE EXTRACT(YEAR FROM order_date) == 2015
  GROUP BY category
), 
y_2016 AS(
  SELECT
    category,
    SUM(sales) AS revenue,
    SUM(profit) AS profit,
    (SUM(profit)/SUM(sales)) * 100.00 AS margin_pct
  FROM "memory"."store_data.csv"
  WHERE EXTRACT(YEAR FROM order_date) == 2016
  GROUP BY category
), 
y_2017 AS(
  SELECT
    category,
    SUM(sales) AS revenue,
    SUM(profit) AS profit,
    (SUM(profit)/SUM(sales)) * 100.00 AS margin_pct
  FROM "memory"."store_data.csv"
  WHERE EXTRACT(YEAR FROM order_date) == 2017
  GROUP BY category
)

SELECT 
  y_2014.category,
  ROUND(y_2014.revenue, 2) AS revenue_2014,
  ROUND(y_2014.profit, 2) AS profit_2014,
  ROUND(y_2014.margin_pct, 2) AS margin_pct_2014,
  ROUND(y_2015.revenue, 2) AS revenue_2015,
  ROUND(y_2015.profit, 2) AS profit_2015,
  ROUND(y_2015.margin_pct, 2) AS margin_pct_2015,
  ROUND(y_2016.revenue, 2) AS revenue_2016,
  ROUND(y_2016.profit, 2) AS profit_2016,
  ROUND(y_2016.margin_pct, 2) AS margin_pct_2016,
  ROUND(y_2017.revenue, 2) AS revenue_2017,
  ROUND(y_2017.profit, 2) AS profit_2017,
  ROUND(y_2017.margin_pct, 2) AS margin_pct_2017
FROM y_2014
INNER JOIN y_2015 
  ON y_2014.category = y_2015.category
INNER JOIN y_2016 
  ON y_2014.category = y_2016.category
INNER JOIN y_2017 
  ON y_2014.category = y_2017.category;


--Datos por region
 WITH y_2014 AS(  
  SELECT
    region,
    SUM(sales) AS revenue,
    SUM(profit) AS profit,
    (SUM(profit)/SUM(sales)) * 100.00 AS margin_pct
  FROM "memory"."store_data.csv"
  WHERE EXTRACT(YEAR FROM order_date) == 2014
  GROUP BY region
), 
y_2015 AS(
  SELECT
    region,
    SUM(sales) AS revenue,
    SUM(profit) AS profit,
    (SUM(profit)/SUM(sales)) * 100.00 AS margin_pct
  FROM "memory"."store_data.csv"
  WHERE EXTRACT(YEAR FROM order_date) == 2015
  GROUP BY region
), 
y_2016 AS(
  SELECT
    region,
    SUM(sales) AS revenue,
    SUM(profit) AS profit,
    (SUM(profit)/SUM(sales)) * 100.00 AS margin_pct
  FROM "memory"."store_data.csv"
  WHERE EXTRACT(YEAR FROM order_date) == 2016
  GROUP BY region
), 
y_2017 AS(
  SELECT
    region,
    SUM(sales) AS revenue,
    SUM(profit) AS profit,
    (SUM(profit)/SUM(sales)) * 100.00 AS margin_pct
  FROM "memory"."store_data.csv"
  WHERE EXTRACT(YEAR FROM order_date) == 2017
  GROUP BY region
)

SELECT 
  y_2014.region,
  ROUND(y_2014.revenue, 2) AS revenue_2014,
  ROUND(y_2014.profit, 2) AS profit_2014,
  ROUND(y_2014.margin_pct, 2) AS margin_pct_2014,
  ROUND(y_2015.revenue, 2) AS revenue_2015,
  ROUND(y_2015.profit, 2) AS profit_2015,
  ROUND(y_2015.margin_pct, 2) AS margin_pct_2015,
  ROUND(y_2016.revenue, 2) AS revenue_2016,
  ROUND(y_2016.profit, 2) AS profit_2016,
  ROUND(y_2016.margin_pct, 2) AS margin_pct_2016,
  ROUND(y_2017.revenue, 2) AS revenue_2017,
  ROUND(y_2017.profit, 2) AS profit_2017,
  ROUND(y_2017.margin_pct, 2) AS margin_pct_2017
FROM y_2014
INNER JOIN y_2015 
  ON y_2014.region = y_2015.region
INNER JOIN y_2016 
  ON y_2014.region = y_2016.region
INNER JOIN y_2017 
  ON y_2014.region = y_2017.region
ORDER BY y_2017.revenue DESC;