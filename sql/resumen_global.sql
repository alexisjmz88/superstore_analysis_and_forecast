--Determinar rango de fechas
SELECT 
  MIN(order_date) AS inicio_periodo,
  MAX(order_date) AS final_periodo
FROM "memory"."store_data.csv";

--Resumen de ventas anuales
WITH current_year AS(
  SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS total_products_sold,
    SUM(sales) AS total_revenue,
    SUM(profit) AS total_gross_profit,
    (SUM(profit)/SUM(sales))*100.00 AS gross_margin_pct
  FROM "memory"."store_data.csv"
  GROUP BY year
),
last_year AS(
  SELECT 
    year,
    LAG(total_orders) OVER(ORDER BY year ASC) AS total_orders,
    LAG(total_products_sold) OVER(ORDER BY year ASC) AS total_products_sold,
    LAG(total_revenue) OVER(ORDER BY year ASC) AS total_revenue,
    LAG(total_gross_profit) OVER(ORDER BY year ASC) AS total_gross_profit,
    LAG(gross_margin_pct) OVER(ORDER BY year ASC) AS gross_margin_pct
  FROM current_year
  ORDER BY year
)
SELECT 
  cy.year,
  cy.total_orders,
  ((cy.total_orders - ly.total_orders) / ly.total_orders) * 100.00 AS orders_YoY_pct,
  cy.total_products_sold,
  ((cy.total_products_sold - ly.total_products_sold) / ly.total_products_sold) * 100.00 AS products_YoY_pct,
  cy.total_revenue,
  ((cy.total_revenue - ly.total_revenue) / ly.total_revenue) * 100.00 AS revenue_YoY_pct,
  cy.total_gross_profit,
  ((cy.total_gross_profit - ly.total_gross_profit) / ly.total_gross_profit) * 100.00 AS profit_YoY_pct,
  cy.gross_margin_pct,
  ((cy.gross_margin_pct - ly.gross_margin_pct) / ly.gross_margin_pct) * 100.00 AS margin_YoY_pct
FROM current_year AS cy 
LEFT JOIN last_year AS ly 
  ON cy.year = ly.year
ORDER BY cy.year;

--Resumen de ventas mensuales
WITH current_year AS(
  SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS total_products_sold,
    SUM(sales) AS total_revenue,
    SUM(profit) AS total_gross_profit,
    (SUM(profit)/SUM(sales))*100.00 AS gross_margin_pct
  FROM "memory"."store_data.csv"
  GROUP BY year, month
  ORDER BY year, month
), summary AS(
  SELECT 
    year,
    month,
    total_orders AS current_orders,
    LAG(total_orders) OVER(PARTITION BY month ORDER BY year) AS last_orders,
    total_products_sold as current_products_sold,
    LAG(total_products_sold) OVER(PARTITION BY month ORDER BY year) AS last_products_sold,
    total_revenue AS current_revenue,
    LAG(total_revenue) OVER(PARTITION BY month ORDER BY year) AS last_revenue,
    total_gross_profit AS current_profit,
    LAG(total_gross_profit) OVER(PARTITION BY month ORDER BY year) AS last_profit,
    gross_margin_pct AS current_gross_margin_pct,
    LAG(gross_margin_pct) OVER(PARTITION BY month ORDER BY year) AS last_gross_margin_pct
  FROM current_year
  ORDER BY year, month
)
SELECT 
  year,
  month,
  current_orders,
  ((current_orders - last_orders) / last_orders) * 100.00 AS orders_YoY_pct,
  current_products_sold,
  ((current_products_sold - last_products_sold) / last_products_sold) * 100.00 AS products_sold_YoY_pct,
  current_revenue,
  ((current_revenue - last_revenue) / last_revenue) * 100.00 AS revenue_YoY_pct,
  current_profit,
  ((current_profit - last_profit) / last_profit) * 100.00 AS profit_YoY_pct,
  current_gross_margin_pct,
  ((current_gross_margin_pct - last_gross_margin_pct) / last_gross_margin_pct) * 100.00 AS margin_YoY_pct
FROM summary
ORDER BY year, month;