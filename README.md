Apple Sales Data Analysis | SQL Server
Project Overview
This project analyzes an Apple retail sales dataset using Microsoft SQL Server. It explores sales performance, store and product performance, customer purchasing trends, and warranty claims.

A collection of SQL queries was developed to answer business questions and extract insights from the data. The analysis applies relational joins, aggregations, Common Table Expressions (CTEs), window functions, and date-based calculations.
Business Objectives
- Understand the distribution of stores across countries.
- Compare sales volume and performance across stores.
- Analyze sales activity over selected periods.
- Identify product categories with the highest average prices.
- Find top-performing and least-selling products.
- Examine warranty claim activity and repair statuses.
- Calculate the percentage of claims marked as Warranty Void.
- Explore warranty claims in relation to sale dates and product launch dates.
Dataset Structure
The analysis uses the following relational tables:
Table	Description
stores	Store details, including store name, ID, and country.
sales	Sales transactions, including sale date, store, product, and quantity.
products	Product details, including product name, category, price, and launch date.
category	Product category information.
warranty	Warranty claim records and repair statuses associated with sales.


The tables are connected through key fields such as store_id, product_id, category_id, and sale_id.
Tools & Technologies
- Microsoft SQL Server – Database management and SQL analysis.
- SQL – Data querying and business analysis.
- SQL Server Management Studio (SSMS) – Writing and executing SQL queries.
Analysis Areas
1. Store Performance Analysis
- Count the number of stores in each country.
- Calculate total units sold by each store.
- Identify the store with the highest sales volume in the latest available year.
- Determine the best-selling day for each store.
2. Sales Analysis
- Count sales transactions during a selected period, such as December 2023.
- Compare units sold across stores.
- Identify the least-selling products in each country.
- Explore sales performance over time.
3. Product & Category Analysis
- Calculate the average product price for each category.
- Count unique products sold in the latest available year.
- Identify least-selling products by country.
- Explore product sales trends in relation to product launch dates.
4. Warranty Analysis
- Calculate the percentage of warranty records marked as Warranty Void.
- Identify warranty claims filed in a selected year.
- Analyze warranty void cases filed more than 180 days after a sale.
- Explore warranty records for products launched in recent years.
- Examine warranty claim activity across stores and products.
SQL Concepts Applied
- SELECT, WHERE, ORDER BY, and GROUP BY
- Aggregate functions: COUNT(), SUM(), and AVG()
- INNER JOIN to combine related tables
- CASE WHEN for conditional classification
- Common Table Expressions (CTEs) using WITH
- Window functions such as RANK() and PARTITION BY
- Date functions including YEAR(), MONTH(), DATENAME(), and DATEDIFF()
- Subqueries for dynamic date filtering
- FORMAT() for percentage presentation
Repository Structure
Apple-Sales-Analysis/
│
├── SQL/
│   └── Apple_Sales_Analysis.sql
│
├── README.md
│
└── Dataset/
    └── (Add dataset files here, if permitted)
Update the file and folder names above to match the actual structure of your repository.
How to Run the Project
1. Install Microsoft SQL Server and SQL Server Management Studio (SSMS).
2. Clone or download this repository.
3. Obtain the dataset files and import the required tables into SQL Server.
4. Ensure that the database contains the tables stores, sales, products, category, and warranty.
5. Open the SQL script in SSMS.
6. Execute the queries to explore the data and review the analysis.
Note: The supplied queries assume that the source tables have already been created and populated. Update database and table references if your local setup uses different names.

Key Takeaways
This project demonstrates how SQL can be used to turn retail data into structured business analysis. It explores sales performance across stores and products, highlights purchasing patterns, and examines warranty claim behavior.

The project also provides practical experience in querying relational databases and applying SQL techniques to real-world business questions.
Future Improvements
- Build an interactive dashboard using Power BI or Tableau.
- Add more detailed revenue and profitability analysis.
- Perform deeper time-series analysis of product sales.
- Investigate warranty claim rates by product, country, and store.
- Optimize queries and document validated business findings.
Author
Abdelrahman Hamdi
Data Analyst | SQL | Power BI | Tableau | Excel
This project was created for learning and portfolio development purposes.
