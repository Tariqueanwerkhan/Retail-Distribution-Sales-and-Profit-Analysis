select * from sales_orders;

select * from customers;

select * from products;

select * from regions;

select * from state_regions;

select * from budgets_2017;

-- Missing values check
SELECT
    COUNT(*) FILTER (WHERE "OrderDate" IS NULL) AS null_order_date,
    COUNT(*) FILTER (WHERE "Customer Name Index" IS NULL) AS null_customer_name,
    COUNT(*) FILTER (WHERE "Channel" IS NULL) AS null_channel,
    COUNT(*) FILTER (WHERE "Currency Code" IS NULL) AS null_currency,
    COUNT(*) FILTER (WHERE "Warehouse Code" IS NULL) AS null_warehouse,
    COUNT(*) FILTER (WHERE "Delivery Region Index" IS NULL) AS null_region,
    COUNT(*) FILTER (WHERE "Product Description Index" IS NULL) AS null_product,
    COUNT(*) FILTER (WHERE "Order Quantity" IS NULL) AS null_quantity,
    COUNT(*) FILTER (WHERE "Unit Price" IS NULL) AS null_price,
    COUNT(*) FILTER (WHERE "Line Total" IS NULL) AS null_line_total,
    COUNT(*) FILTER (WHERE "Total Unit Cost" IS NULL) AS null_cost
FROM sales_orders;


-- Duplicate orders check
SELECT "OrderNumber", COUNT(*)
FROM sales_orders
GROUP BY "OrderNumber"
HAVING COUNT(*) > 1;


-- Remove duplicates (optional, if any found)
DELETE FROM sales_orders a
USING sales_orders b
WHERE a.ctid < b.ctid
  AND a."OrderDate" = b."OrderDate"
  AND a."Customer Name Index" = b."Customer Name Index";


-- Check for invalid or negative values
SELECT *
FROM sales_orders
WHERE "Order Quantity" <= 0
   OR "Unit Price" <= 0
   OR "Total Unit Cost" < 0;




ALTER TABLE sales_orders
ALTER COLUMN "Line Total" TYPE NUMERIC USING "Line Total"::NUMERIC,
ALTER COLUMN "Total Unit Cost" TYPE NUMERIC USING "Total Unit Cost"::NUMERIC;



-- ADVANCED EDA & ANALYTICS QUERIES
-- Profit Margin Analysis

-- Profit = Line Total - Total Unit Cost
-- Profit Margin % = (Profit / Line Total) * 100

SELECT
    "OrderDate",
    "Channel",
    ROUND(SUM("Line Total" - "Total Unit Cost"), 2) AS total_profit,
    ROUND(AVG(("Line Total" - "Total Unit Cost") / NULLIF("Line Total", 0)) * 100, 2) AS avg_profit_margin
FROM sales_orders
GROUP BY "OrderDate", "Channel"
ORDER BY "OrderDate";



-- Year-over-Year (YoY) Sales Growth
WITH yearly_sales AS (
    SELECT
        EXTRACT(YEAR FROM "OrderDate") AS year,
        SUM("Line Total") AS total_sales
    FROM sales_orders
    GROUP BY EXTRACT(YEAR FROM "OrderDate")
)
SELECT
    year,
    total_sales,
    ROUND((total_sales - LAG(total_sales) OVER (ORDER BY year)) / 
          LAG(total_sales) OVER (ORDER BY year) * 100, 2) AS yoy_growth_percent
FROM yearly_sales
ORDER BY year;




-- Customer Segmentation (by total spending)
SELECT
    "Customer Name Index",
    SUM("Line Total") AS total_spent,
    CASE
        WHEN SUM("Line Total") >= 50000 THEN 'High Value'
        WHEN SUM("Line Total") BETWEEN 20000 AND 49999 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM sales_orders
GROUP BY "Customer Name Index"
ORDER BY total_spent DESC;



-- Regional Performance Ranking
SELECT
    "Delivery Region Index",
    ROUND(SUM("Line Total"), 2) AS total_sales,
    ROUND(SUM("Line Total" - "Total Unit Cost"), 2) AS total_profit,
    RANK() OVER (ORDER BY SUM("Line Total") DESC) AS sales_rank
FROM sales_orders
GROUP BY "Delivery Region Index";




-- Product Category-wise Comparison
SELECT
    "Product Description Index",
    ROUND(SUM("Line Total"), 2) AS total_sales,
    ROUND(SUM("Line Total" - "Total Unit Cost"), 2) AS total_profit,
    ROUND(AVG(("Line Total" - "Total Unit Cost") / NULLIF("Line Total", 0)) * 100, 2) AS avg_profit_margin
FROM sales_orders
GROUP BY "Product Description Index"
ORDER BY total_profit DESC;



-- Top 10 Products by Total Profit
SELECT
    "Product Description Index",
    ROUND(SUM("Line Total" - "Total Unit Cost"), 2) AS total_profit
FROM sales_orders
GROUP BY "Product Description Index"
ORDER BY total_profit DESC
LIMIT 10;



-- Monthly Revenue & Profit Trend
SELECT
    DATE_TRUNC('month', "OrderDate") AS month,
    ROUND(SUM("Line Total"), 2) AS total_revenue,
    ROUND(SUM("Line Total" - "Total Unit Cost"), 2) AS total_profit,
    ROUND(AVG(("Line Total" - "Total Unit Cost") / NULLIF("Line Total", 0)) * 100, 2) AS avg_profit_margin
FROM sales_orders
GROUP BY month
ORDER BY month;



-- Year-over-Year (YoY) Revenue Growth
WITH yearly_sales AS (
    SELECT
        EXTRACT(YEAR FROM "OrderDate") AS year,
        SUM("Line Total") AS total_revenue
    FROM sales_orders
    GROUP BY year
)
SELECT
    year,
    total_revenue,
    ROUND(
        (total_revenue - LAG(total_revenue) OVER (ORDER BY year)) 
        / NULLIF(LAG(total_revenue) OVER (ORDER BY year), 0) * 100, 
    2) AS yoy_growth_percent
FROM yearly_sales
ORDER BY year;



-- Customer Segmentation by Spending
SELECT
    "Customer Name Index",
    SUM("Line Total") AS total_spent,
    CASE 
        WHEN SUM("Line Total") >= 100000 THEN 'Platinum'
        WHEN SUM("Line Total") BETWEEN 50000 AND 99999 THEN 'Gold'
        WHEN SUM("Line Total") BETWEEN 20000 AND 49999 THEN 'Silver'
        ELSE 'Bronze'
    END AS customer_segment
FROM sales_orders
GROUP BY "Customer Name Index"
ORDER BY total_spent DESC;



-- Best Performing Warehouses
SELECT
    "Warehouse Code",
    ROUND(SUM("Line Total" - "Total Unit Cost"), 2) AS total_profit,
    ROUND(SUM("Line Total"), 2) AS total_sales
FROM sales_orders
GROUP BY "Warehouse Code"
ORDER BY total_profit DESC;





----------------------------------------------------------------------------------------------------------------
