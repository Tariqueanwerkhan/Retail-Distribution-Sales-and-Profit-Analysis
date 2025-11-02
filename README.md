🧠 Project Title

# Retail-Distribution-Sales-and-Profit-Analysis 

---

🎯 Objective

The main goal of this project is to analyze sales performance across different channels, regions, and products using a complete data pipeline — from raw Excel data to database integration, data cleaning, exploratory data analysis (EDA), and advanced SQL-based insights.

This project helps to answer key business questions such as:

Which regions and channels generate the highest profit?

Who are the top customers and products by sales and margin?

What is the year-over-year growth trend?

How can we segment customers based on their total spending?

Which warehouses perform best in terms of revenue and profit?


--- 


🧩 Project Overview

This is a Regional Sales Analysis Project where data was sourced from an Excel workbook containing multiple sheets:

Sheet Name	Description
Sales Orders	Contains detailed transaction data (order date, quantity, price, cost, etc.)
Customers	Customer details
Regions	Delivery and geographical information
State Regions	Mapping of states to regions
Products	Product catalog
2017 Budgets	Annual sales budget data
⚙️ Tools & Technologies Used
Category	Tools / Libraries
Database	PostgreSQL (via pgAdmin4)
Programming	Python (Pandas, SQLAlchemy)
Visualization	Power BI / Matplotlib / Seaborn
Data Source	Excel Workbook (Regional Database.xlsx)
IDE / Notebook	Jupyter Notebook
🧱 Workflow

--- 


Data Loading (Python)

Imported the Excel workbook with pd.ExcelFile().

Extracted individual sheets as DataFrames.

Uploaded all tables to PostgreSQL using SQLAlchemy.

<img width="1669" height="767" alt="image" src="https://github.com/user-attachments/assets/0756c4ee-7c8e-44b8-92af-4e019d1ea94c" />

<img width="1698" height="910" alt="image" src="https://github.com/user-attachments/assets/805cda07-b700-4b32-9ca5-936215b56288" />


Import Libraries and Load Data
<img width="1750" height="914" alt="image" src="https://github.com/user-attachments/assets/82448cd2-8974-46f5-9bc4-3da8b5c864e6" />


Data Cleaning
<img width="1791" height="908" alt="image" src="https://github.com/user-attachments/assets/fcb211c2-d80b-428a-9c4c-d64cfdbeff43" />


Database Creation (PostgreSQL)

Created sales_analysis_db database.

Imported all tables (sales_orders, customers, regions, state_regions, products, budgets_2017).

Profit Margin Analysis
<img width="1560" height="892" alt="image" src="https://github.com/user-attachments/assets/20cadc89-47c8-427f-9b4f-d542b42b3302" />

<img width="1772" height="934" alt="image" src="https://github.com/user-attachments/assets/050ebc92-c704-4e6a-a588-a34134f9dac1" />

Data Cleaning (SQL)

Checked for missing values, duplicates, and invalid entries.

Converted numeric columns like Line Total and Total Unit Cost to proper numeric type.

Verified data integrity and structure.

Exploratory Data Analysis (EDA)

Summary statistics of quantity, unit price, total cost, and line total.

Validation of data types, ranges, and currency codes.

Correlation between cost, price, and profit.

Advanced SQL Analytics

Profit Margin Analysis

Year-over-Year (YoY) Sales Growth

Customer Segmentation (by total spending)

Regional Performance Ranking

Product Category-wise Comparison

Top 10 Products by Profit

Monthly Revenue & Profit Trend

Best Performing Warehouses


---


📊 Key Insights

Top Channels: Retail and Online contributed the majority of total profit.

High Value Customers: A small set of customers (≈10%) generated over 60% of revenue.

Profit Margin: Average margin across all products ranged between 22–35%.

Regional Trends: Western region outperformed in total sales and profit.

YoY Growth: A positive growth trend between 2014–2016, with a dip in early 2017.

Top Products: Product 13 and Product 26 led in profitability.


---
