SELECT * FROM customer_shopping_behavior
LIMIT 20;

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'customer_shopping_behavior';

SELECT "Gender",
       SUM("Purchase Amount (USD)") AS revenue
FROM customer_shopping_behavior
GROUP BY "Gender";

-- which customer used a discount but still spent more than the average purchase amount:
SELECT "Customer ID", "Purchase Amount (USD)"
FROM customer_shopping_behavior
WHERE "Discount Applied" = 'Yes'
  AND "Purchase Amount (USD)" >= (
      SELECT AVG("Purchase Amount (USD)")
      FROM customer_shopping_behavior
  );

-- top 5 product with highest avg review rating
SELECT "Item Purchased",
       AVG("Review Rating") AS average_product_rating
FROM customer_shopping_behavior
GROUP BY "Item Purchased"
ORDER BY average_product_rating DESC
LIMIT 5;

-- compare avg purchase amounts between standard and express shipping
SELECT "Shipping Type",
       ROUND(AVG("Purchase Amount (USD)"), 2) AS average_purchase
FROM customer_shopping_behavior
WHERE "Shipping Type" IN ('Standard', 'Express')
GROUP BY "Shipping Type";

-- Which payment method is used most frequently?
SELECT "Payment Method",
       COUNT(*) AS total_orders
FROM customer_shopping_behavior
GROUP BY "Payment Method"
ORDER BY total_orders DESC;

--Which locations generate the highest revenue?
SELECT "Location",
       SUM("Purchase Amount (USD)") AS revenue
FROM customer_shopping_behavior
GROUP BY "Location"
ORDER BY revenue DESC;

--Which season has the highest sales?
SELECT "Season",
       SUM("Purchase Amount (USD)") AS revenue
FROM customer_shopping_behavior
GROUP BY "Season"
ORDER BY revenue DESC;

-- Which customers are the top 10 highest spenders?
SELECT "Customer ID",
       SUM("Purchase Amount (USD)") AS total_spent
FROM customer_shopping_behavior
GROUP BY "Customer ID"
ORDER BY total_spent DESC
LIMIT 10;

-- Find customers who spent more than the average purchase amount.
SELECT "Customer ID",
       "Purchase Amount (USD)"
FROM customer_shopping_behavior
WHERE "Purchase Amount (USD)" >
(
SELECT AVG("Purchase Amount (USD)")
FROM customer_shopping_behavior
);

-- Does offering discounts increase customer spending?
SELECT "Discount Applied",
       ROUND(AVG("Purchase Amount (USD)"),2) AS avg_purchase
FROM customer_shopping_behavior
GROUP BY "Discount Applied";

-- Which age spends the most money?
SELECT "Age",
       SUM("Purchase Amount (USD)") AS revenue
FROM customer_shopping_behavior
GROUP BY "Age"
ORDER BY revenue DESC;

--Which color is purchased the most?
SELECT "Color",
       COUNT(*) AS total_orders
FROM customer_shopping_behavior
GROUP BY "Color"
ORDER BY total_orders DESC;

--Which size is purchased the most?
SELECT "Size",
       COUNT(*) AS total_orders
FROM customer_shopping_behavior
GROUP BY "Size"
ORDER BY total_orders DESC;

-- Which category performs best in each season?
SELECT "Season",
       "Category",
       SUM("Purchase Amount (USD)") AS revenue
FROM customer_shopping_behavior
GROUP BY "Season","Category"
ORDER BY "Season", revenue DESC;

-- what is the revenue contribute of each age group
SELECT
    CASE
        WHEN "Age" < 20 THEN 'Under 20'
        WHEN "Age" BETWEEN 20 AND 30 THEN '20-30'
        WHEN "Age" BETWEEN 31 AND 40 THEN '31-40'
        ELSE 'Above 40'
    END AS age_group,

    SUM("Purchase Amount (USD)") AS total_revenue

FROM customer_shopping_behavior

GROUP BY age_group

ORDER BY total_revenue DESC;