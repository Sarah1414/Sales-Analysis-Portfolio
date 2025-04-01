

select * from [synthetic_online_retail_data];


-- 🛒 Online Retail Sales Analysis  

/* 

📊 Overview  
This project analyzes **synthetic online retail sales data**, mimicking transactions from an e-commerce platform. 
The dataset contains customer demographics, product details, purchase history, and review scores. 
Using SQL, we uncover sales trends, customer behavior, and product performance.

## 📈 SQL Analysis  
✅ **Total Sales by Category**  
✅ **Top-Selling Products**  
✅ **Customer Segmentation by Age**  
✅ **Payment Preferences**  

*/

-- 1️ Total Sales Revenue  

SELECT 
    SUM(quantity * price) AS total_revenue 
FROM synthetic_online_retail_data;

-- 2️ Total Orders Placed  
SELECT 
    COUNT(DISTINCT order_date) AS total_orders 
FROM synthetic_online_retail_data;

-- 3️ Top 10 Best-Selling Products  

SELECT TOP 10 
    product_name, 
    SUM(quantity) AS total_quantity_sold 
FROM synthetic_online_retail_data 
GROUP BY product_name 
ORDER BY total_quantity_sold DESC;


-- 4️ Sales Revenue by Product Category  
SELECT 
    category_name, 
    SUM(quantity * price) AS total_sales 
FROM synthetic_online_retail_data 
GROUP BY category_name 
ORDER BY total_sales DESC;

-- 6️ Customer Segmentation by Age Group  

SELECT 
    CASE 
        WHEN age BETWEEN 18 AND 25 THEN '18-25' 
        WHEN age BETWEEN 26 AND 35 THEN '26-35' 
        WHEN age BETWEEN 36 AND 45 THEN '36-45' 
        ELSE '46+' 
    END AS age_group, 
    COUNT(DISTINCT customer_id) AS customer_count 
FROM synthetic_online_retail_data 
GROUP BY age 
ORDER BY customer_count DESC;

-- 7️ Average Order Value (AOV)  
SELECT 
    AVG(quantity * price) AS avg_order_value 
FROM synthetic_online_retail_data;

-- 8️ Top 5 Cities by Total Sales  

SELECT TOP 5
    city, 
    SUM(quantity * price) AS total_sales 
FROM synthetic_online_retail_data 
GROUP BY city 
ORDER BY total_sales DESC;

-- 9️ Most Preferred Payment Method  
SELECT 
    payment_method, 
    COUNT(*) AS total_transactions 
FROM synthetic_online_retail_data 
GROUP BY payment_method 
ORDER BY total_transactions DESC;

-- 🔟 Average Product Rating (Review Score)  
SELECT TOP 10
    product_name, 
    AVG(review_score) AS avg_rating 
FROM synthetic_online_retail_data 
GROUP BY product_name 
ORDER BY avg_rating DESC ;

-- 1️1 Customer Repeat Rate (Customers with Multiple Orders)  
SELECT TOP 10
    customer_id, 
    COUNT(order_date) AS order_count 
FROM synthetic_online_retail_data 
GROUP BY customer_id 
HAVING COUNT(order_date) > 1  -- Use COUNT(order_date) directly
ORDER BY order_count DESC;

-- 12 Best-Selling Product Categories
SELECT 
    category_name, 
    SUM(quantity) AS total_quantity_sold 
FROM synthetic_online_retail_data 
GROUP BY category_name 
ORDER BY total_quantity_sold DESC;


--13  Customers Who Made Only One Purchase
SELECT 
    customer_id, 
    COUNT(order_date) AS total_orders 
FROM synthetic_online_retail_data 
GROUP BY customer_id 
HAVING COUNT(order_date) = 1;

-- 14 Percentage Contribution of Each Payment Method
SELECT 
    payment_method, 
    COUNT(*) AS total_transactions, 
    CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS DECIMAL(10,2)) AS percentage_contribution
FROM synthetic_online_retail_data 
GROUP BY payment_method 
ORDER BY total_transactions DESC;

--15 Customers Who Left Negative Reviews (Rating ≤ 2)
SELECT 
    customer_id, 
    COUNT(*) AS negative_reviews 
FROM synthetic_online_retail_data 
WHERE review_score <= 2 
GROUP BY customer_id 
ORDER BY negative_reviews DESC;

--16 Window Function: Rank Customers by Spending

SELECT 
    customer_id, 
    SUM(quantity * price) AS total_spent, 
    RANK() OVER (ORDER BY SUM(quantity * price) DESC) AS spending_rank
FROM synthetic_online_retail_data 
GROUP BY customer_id;


-- 17 Common Table Expression (CTE): Top Products by Revenue

WITH ProductSales AS (
    SELECT 
        product_name, 
        SUM(quantity * price) AS total_revenue
    FROM synthetic_online_retail_data 
    GROUP BY product_name
)
SELECT TOP 10 product_name, total_revenue 
FROM ProductSales 
ORDER BY total_revenue DESC;












