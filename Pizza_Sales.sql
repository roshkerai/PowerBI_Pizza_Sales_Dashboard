SELECT * FROM pizza_sales

-- 1. Total Revenue

SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales;

-- 2. Average Order Value

SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_order_Value FROM pizza_sales;

-- 3. Total Pizza Sold

SELECT SUM(quantity) AS Total_pizza_sold FROM pizza_sales;

-- 4. Total Orders Placed

SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales;

-- 5. Average Pizzas Per Order

SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS Avg_Pizzas_per_order
FROM pizza_sales;

-- 6. Daily Trend for Total Orders

SELECT DATENAME(DW, order_date) AS order_day, COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales
GROUP BY DATENAME(DW, order_date);

-- 7. Monthly Trend for Total Orders

SELECT DATENAME(MONTH, order_date) AS Month_Name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date);

-- 8. Percentage of Sales by Pizza Category

SELECT pizza_category, SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales)  AS Percentage_of_Sales
FROM pizza_sales
GROUP BY pizza_category;

-- 8.1 Adding Total sales column in output

SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS Percentage_of_Sales
FROM pizza_sales
GROUP BY pizza_category;

-- 8.2 Filtering by Month of Jan

SELECT pizza_category, SUM(total_price) as Total_Sales, SUM(total_price) * 100 / 
(SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) = 1)  AS Percentage_of_Sales
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category;

-- 9. Percentage of Sales by Pizza Size

SELECT pizza_size, SUM(total_price) AS Total_Sales, 
SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales)  AS Percentage_of_Sales
FROM pizza_sales
GROUP BY pizza_size;

-- 9.1 Output to be with two decimal points

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as Total_Sales,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS Percentage_of_Sales
FROM pizza_sales
GROUP BY pizza_size
ORDER BY Percentage_of_Sales;

-- 9.2 Output will be in descending order

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as Total_Sales,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS Percentage_of_Sales
FROM pizza_sales
GROUP BY pizza_size
ORDER BY Percentage_of_Sales desc;

-- 9.3 Output will be filtered by quarter

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as Total_Sales,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales WHERE DATEPART(quarter, order_date) = 1) AS DECIMAL(10,2)) AS Percentage_of_Sales
FROM pizza_sales
WHERE DATEPART(quarter, order_date) = 1
GROUP BY pizza_size
ORDER BY Percentage_of_Sales desc;

-- 10. Top 5 Best Sellers by Revenue

SELECT Top 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC;

-- 11. Bottom 5 Sellers by Revenue

SELECT Top 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC;

-- 12. Top 5 Best Sellers by Quantity

SELECT Top 5 pizza_name, SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC;

-- 13. Bottom 5 Sellers by Quantity

SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity ASC;

-- 14. Top 5 Best Sellers by Total Orders

SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC;

-- 15. Bottom 5 Sellers by Total Orders

SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC;