--Márgenes por región 2017
WITH y_2017 AS (  
  SELECT 
    region,
    SUM(sales) AS revenue,
    SUM(profit) AS profit,
    (SUM(profit)/SUM(sales)) * 100.00 AS margin_pct
  FROM "memory"."store_data.csv"
  WHERE EXTRACT(YEAR FROM order_date) = 2017
  GROUP BY region
),
overall AS(
  SELECT 
    region,
    (SUM(profit)/SUM(sales)) * 100.00 AS margin_pct_4y_avg
  FROM "memory"."store_data.csv"
  GROUP BY region
)
SELECT 
  y_2017.region,
  ROUND(y_2017.revenue, 2) AS revenue, 
  ROUND(y_2017.profit, 2) As profit,
  ROUND(y_2017.margin_pct, 2) AS margin_pct,
  ROUND(overall.margin_pct_4y_avg, 2) AS margin_pct_4y_avg
FROM y_2017
INNER JOIN overall
  ON y_2017.region = overall.region
ORDER BY y_2017.margin_pct DESC;

--Márgenes por subcategoría 2017
WITH y_2017 AS (  
  SELECT 
    category,
    sub_category,
    SUM(sales) AS revenue,
    SUM(profit) AS profit,
    (SUM(profit)/SUM(sales)) * 100.00 AS margin_pct,
    RANK() OVER(PARTITION BY category ORDER BY (SUM(profit)/SUM(sales)) ASC, SUM(profit) ASC) AS rank
  FROM "memory"."store_data.csv"
  WHERE EXTRACT(YEAR FROM order_date) = 2017
  GROUP BY category, sub_category
)

SELECT 
  category,
  sub_category,
  ROUND(revenue, 2) AS revenue,
  ROUND(profit, 2) AS profit,
  ROUND(margin_pct, 2) AS margin_pct
FROM y_2017
ORDER BY category, rank;


--Proprción en ingresos y márgenes por producto
WITH product_margin AS (  
  SELECT 
    category,
    sub_category,
    product_name,
    SUM(sales) AS revenue,
    SUM(profit) AS profit,
    (SUM(profit)/SUM(sales)) * 100.00 AS margin_pct
  FROM "memory"."store_data.csv"
  WHERE EXTRACT(YEAR FROM order_date) = 2017 
        AND (sub_category = 'Tables' OR sub_category = 'Bookcases' OR sub_category = 'Supplies' OR sub_category = 'Machines')
  GROUP BY category, sub_category, product_name
),
revenue_sub_category AS(
  SELECT 
    sub_category,
    SUM(sales) AS total_revenue
  FROM "memory"."store_data.csv"
  WHERE EXTRACT(YEAR FROM order_date) = 2017
  GROUP BY sub_category
 )

SELECT 
  pm.category,
  pm.sub_category,
  pm.product_name,
  ROUND(pm.revenue, 2) AS revenue,
  ROUND((pm.revenue * 100.00) / rev_cat.total_revenue, 2) AS revenue_proportion_pct,
  ROUND(pm.profit, 2) AS profit,
  ROUND(pm.margin_pct, 2) AS margin_pct
FROM product_margin AS pm
INNER JOIN revenue_sub_category AS rev_cat
  ON pm.sub_category = rev_cat.sub_category
WHERE margin_pct < 0
ORDER BY pm.category, pm.sub_category, revenue_proportion_pct DESC;


--Análisis de descuentos en productos con pérdida
WITH product_margin AS (  
  SELECT 
    category,
    sub_category,
    product_name,
    SUM(sales) AS revenue,
    (SUM(discount)/SUM(sales))  * 100.00 AS discount_pct,
    SUM(profit) AS profit,
    (SUM(profit)/SUM(sales)) * 100.00 AS margin_pct
  FROM "memory"."store_data.csv"
  WHERE EXTRACT(YEAR FROM order_date) = 2017 
        AND (sub_category = 'Tables' OR sub_category = 'Bookcases' OR sub_category = 'Supplies' OR sub_category = 'Machines')
  GROUP BY category, sub_category, product_name
),
revenue_sub_category AS(
  SELECT 
    sub_category,
    SUM(sales) AS total_revenue
  FROM "memory"."store_data.csv"
  WHERE EXTRACT(YEAR FROM order_date) = 2017
  GROUP BY sub_category
 )

SELECT 
  pm.category,
  pm.sub_category,
  pm.product_name,
  ROUND((pm.revenue * 100.00) / rev_cat.total_revenue, 2) AS revenue_proportion_pct,
  ROUND(pm.discount_pct, 2) AS discount_pct,
  ROUND(pm.margin_pct, 2) AS margin_pct
FROM product_margin AS pm
INNER JOIN revenue_sub_category AS rev_cat
  ON pm.sub_category = rev_cat.sub_category
WHERE margin_pct < 0
ORDER BY pm.category, pm.sub_category, revenue_proportion_pct DESC;