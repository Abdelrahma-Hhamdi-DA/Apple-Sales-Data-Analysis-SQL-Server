/* 
List the months in the last three years where sales exceeded 5,000 units in the USA.
Identify the product category with the most warranty claims filed in the last two years.
Complex (5 Questions)
Determine the percentage chance of receiving warranty claims after each purchase for each country.
Analyze the year-by-year growth ratio for each store.
Calculate the correlation between product price and warranty claims for products sold in the last five years, segmented by price range.
Identify the store with the highest percentage of "Paid Repaired" claims relative to total claims filed.
Write a query to calculate the monthly running total of sales for each store over the past four years and compare trends during this period.
Bonus Question
Analyze product sales trends over time, segmented into key periods: from launch to 6 months, 6-12 months, 12-18 months, and beyond 18 months.
*/

--Find the number of stores in each country
SELECT COUNT(store_id) Number, country
FROM stores
GROUP BY country;

--Calculate the total number of units sold by each store
SELECT st.store_name, SUM(sa.quantity) number_of_units
FROM stores st
JOIN sales sa
ON st.store_id = sa.store_id
GROUP BY store_name;

--Identify how many sales occurred in December 2023
 SELECT
     COUNT(sale_id) AS [Numer Of Sales]  ,
     DATENAME(MONTH,sale_date) AS month,
     YEAR(sale_date) AS year
FROM sales
WHERE YEAR(sale_date) = 2023 AND DATENAME(MONTH,sale_date) = 'December'
GROUP BY DATENAME(MONTH,sale_date), YEAR(sale_date);

WITH date_ AS(
    SELECT    
	 sale_id  ,
     DATENAME(MONTH,sale_date) AS month,
     YEAR(sale_date) AS year
FROM sales)

SELECT COUNT(sale_id) AS num
FROM date_
WHERE YEAR = 2023 AND MONTH = 'December'
GROUP BY YEAR,MONTH;

SELECT
     COUNT(sale_id) AS [Numer Of Sales]
FROM sales
WHERE YEAR(sale_date) = 2023 AND DATENAME(MONTH,sale_date) = 'December'
GROUP BY DATENAME(MONTH,sale_date), YEAR(sale_date);


--Determine how many stores have never had a warranty claim filed.
SELECT COUNT(st.store_id)
FROM stores st
JOIN sales sa
ON st.store_id = sa.store_id
JOIN warranty w
ON w.sale_id = sa.sale_id
WHERE repair_status = 'Warranty Claim';

--Calculate the percentage of warranty claims marked as "Warranty Void".
SELECT FORMAT( 
    AVG(CASE 
	WHEN repair_status = 'Warranty Void' THEN 1.0
	ELSE 0.0
	END),'P2') AS percentage
FROM warranty;

-- Identify which store had the highest total units sold in the last year.
SELECT TOP 1 st.store_name,SUM(sa.quantity) Highst_store
FROM stores st
JOIN sales sa
ON sa.store_id = st.store_id
WHERE YEAR(sale_date) = (SELECT MAX(YEAR(sale_date)) FROM SALES)
GROUP BY store_name;

--Count the number of unique products sold in the last year.
SELECT COUNT(DISTINCT p.product_name) AS "number of unique products sold in the last year"
FROM products p
JOIN sales s 
ON s.product_id = p.product_id
WHERE YEAR(s.sale_date) = (SELECT MAX(YEAR(sale_date)) FROM sales);

--Find the average price of products in each category.
SELECT c.category_name, AVG(p.price) AVG_Price
FROM category c
JOIN products p
ON p.category_id = c.category_id
GROUP BY c.category_name;

--How many warranty claims were filed in 2020?
SELECT COUNT(repair_status)
FROM warranty w
JOIN sales s
ON s.sale_id = w.sale_id
WHERE repair_status ='warranty claims' AND YEAR(sale_date) = 2020; 

--For each store, identify the best-selling day based on highest quantity sold.
WITH best AS (
SELECT
      DATENAME (WEEKDAY ,s.sale_date) Day,
	  SUM(s.quantity) quantity,
	  st.store_name ,
	  RANK() OVER( PARTITION BY st.store_name ORDER BY SUM(s.quantity) DESC) NUM 

FROM sales s
JOIN stores st
ON s.store_id = st.store_id
 GROUP BY st.store_name, DATENAME (WEEKDAY ,s.sale_date))

 SELECT store_name, Day , quantity
 FROM best
 Where NUM = 1;

 --Identify the least selling product in each country for each year based on total units sold.
 WITH least AS (
 SELECT 
      p.product_name,
	  st.country,
	  YEAR(MAX(sa.sale_date)) year,
	  SUM(sa.quantity) quantity,
	  RANK() OVER( PARTITION BY country ORDER BY  SUM(sa.quantity)) rank
FROM products p
JOIN sales sa
ON sa.product_id = p.product_id
JOIN stores st
ON st.store_id = sa.store_id
GROUP BY product_name, country, quantity)
SELECT product_name , country
FROM least
WHERE rank = 1;

--Calculate how many Warranty Void were filed >180 days of a product sale.
WITH warranty_days AS
(SELECT DATEDIFF(DAY, sale_date, claim_date) day_num,
  CASE
  WHEN repair_status = 'Warranty Void' THEN 1
  ELSE 0
  END AS warranty_void
FROM warranty w
JOIN sales s
ON s.sale_id = w.sale_id
)
SELECT SUM (warranty_void) AS [number of Warranty Void ]
FROM warranty_days
WHERE day_num > 180;

--Determine how many warranty void were filed for products launched in the last two years.
WITH WARRANTYVOID AS (SELECT YEAR(launch_date) YEAR,
       CASE
        When  REPAIR_STATUS = 'warranty void' then 1
	    ELSE 0
	  END AS warranty_void
FROM products p
JOIN sales s
ON s.product_id = p.product_id
JOIN warranty w
ON w.sale_id = s.sale_id)
SELECT TOP 2 
      SUM(warranty_void) NUM,YEAR

FROM WARRANTYVOID
GROUP BY YEAR
ORDER BY YEAR DESC;

--