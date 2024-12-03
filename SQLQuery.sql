select * 
from PizzaSales;

-- 1.sum of total price of pizza orders
select sum(total_price) as Total_Revenue
from PizzaSales;

--total_revenue : 817860.05083847

-- 2. Average amount spent per order
SELECT SUM(total_price)/COUNT(DISTINCT order_id) AS AvgOrder_Value
FROM PizzaSales;
--Avgordervalue : 38.3072623343546

-- 3. Tota pizzas sold
SELECT SUM(quantity) AS Total_PizzasSold
from PizzaSales
--PizzasSold : 49574

-- 4. Toal distinct orders
SELECT COUNT(DISTINCT order_id) AS Total_orders 
FROM PizzaSales
-- total_orders : 21350

-- 5.to find how many pizzas in a order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS AvgPizzas_perOrder
FROM PizzaSales
-- AvgPizzas in a order : 2.32


-- 6. Daily trend total orders

SELECT DATENAME(DW, order_date) AS order_day, COUNT(DISTINCT order_id) AS Total_orders
FROM PizzaSales
GROUP BY DATENAME(DW, order_date);

-- 7. Monthly trend for Total Orders:
SELECT DATENAME(MONTH, order_date) AS Month_Name, COUNT(DISTINCT order_id) AS Total_Orders
FROM PizzaSales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY Total_Orders DESC;

-- 8. Percentage of sales by pizza Category
SELECT pizza_category, SUM(total_price) AS Total_Sales, SUM(total_price) * 100 / (SELECT SUM(total_price) FROM PizzaSales WHERE MONTH(order_date) = 1) AS PCT
FROM PizzaSales 
WHERE MONTH(order_date) = 1
GROUP BY pizza_category;

-- 9. Percentage of sales by pizza size
SELECT pizza_size, SUM(total_price) AS Total_Sales, SUM(total_price) * 100 / (SELECT SUM(total_price) FROM PizzaSales WHERE DATEPART(quarter, order_date) = 1 ) AS PCT
FROM PizzaSales 
WHERE DATEPART(quarter, order_date) = 1
GROUP BY pizza_size
ORDER BY PCT DESC;

-- 10. TOP 5 best selling pizzas
SELECT TOP 5 pizza_name, SUM(total_price) aS Total_Revenue
FROM PizzaSales
GROUP BY pizza_name
ORDER BY Total_Revenue desc;

-- 11. Bottom 5 selling pizzas
SELECT TOP 5 pizza_name, SUM(total_price) aS Total_Revenue
FROM PizzaSales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC;

-- 12. Top 5 selling pizzas by quantity
SELECT TOP 5 pizza_name, SUM(quantity) aS Total_Quantity
FROM PizzaSales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC;

-- 12. Bottom 5 selling pizzas by quantity
SELECT TOP 5 pizza_name, SUM(quantity) aS Total_Quantity
FROM PizzaSales
GROUP BY pizza_name
ORDER BY Total_Quantity ASC;

-- 13. TOP 5 pizzas by order id
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM PizzaSales
GROUP BY pizza_name
ORDER BY Total_Orders DESC;

-- 4. Bottom 5 pizzas by order id
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM PizzaSales
GROUP BY pizza_name
ORDER BY Total_Orders ASC;