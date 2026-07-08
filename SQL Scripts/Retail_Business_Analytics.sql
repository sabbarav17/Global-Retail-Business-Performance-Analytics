use Global_Retail_Data;
go

/*
==========================================================
PROJECT: Global Retail Business Performance Analysis

OBJECTIVE:
Analyze sales, profitability, customers, products,
geographic performance, discount strategy, shipping,
and operational risks to generate strategic business
recommendations.

TOOLS:
- SQL Server
- Aggregate Functions
- GROUP BY
- CASE WHEN
- Business KPI Analysis
==========================================================
*/

/*-----------------------
1.Data Quality Assesment
-------------------------*/


select count(*) as total_rows,
count(distinct row_id) as distinctrows
from Global_Retail_Data

select row_id, count(*) as cnt
from Global_Retail_Data
group by row_id
having count(*) >1;

select top 20 * from Global_Retail_Data
where [row id] is null

delete from Global_Retail_Data
where [row id] is null;

select count(*) from Global_Retail_Data

select column_name 
from information_schema.columns
where table_name = 'Global_Retail_Data'

   --Renaming the column names
EXEC sp_rename 'Global_Retail_Data.[Category]', 'category', 'COLUMN';
EXEC sp_rename 'Global_Retail_Data.[City]', 'city', 'COLUMN';
EXEC sp_rename 'Global_Retail_Data.[Country]', 'country', 'COLUMN';
EXEC sp_rename 'Global_Retail_Data.[Customer ID]', 'customer_id', 'COLUMN';
EXEC sp_rename 'Global_Retail_Data.[Customer Name]', 'customer_name', 'COLUMN';
EXEC sp_rename 'Global_Retail_Data.[Discount]', 'discount', 'COLUMN';
EXEC sp_rename 'Global_Retail_Data.[Market]', 'market', 'COLUMN';
EXEC sp_rename 'Global_Retail_Data.[ji_lu-shu]', 'ji_lu_shu', 'COLUMN';
EXEC sp_rename 'Global_Retail_Data.[Order Date]', 'order_date', 'COLUMN';
EXEC sp_rename 'Global_Retail_Data.[Order ID]', 'order_id', 'COLUMN';
EXEC sp_rename 'Global_Retail_Data.[Order Priority]', 'order_priority', 'COLUMN';
EXEC sp_rename 'Global_Retail_Data.[Product ID]', 'product_id', 'COLUMN';
EXEC sp_rename 'Global_Retail_Data.[Product Name]', 'product_name', 'COLUMN';
EXEC sp_rename 'Global_Retail_Data.[Profit]', 'profit', 'COLUMN';
EXEC sp_rename 'Global_Retail_Data.[Quantity]', 'quantity', 'COLUMN';
EXEC sp_rename 'Global_Retail_Data.[Region]', 'region', 'COLUMN';
EXEC sp_rename 'Global_Retail_Data.[Row ID]', 'row_id', 'COLUMN';
EXEC sp_rename 'Global_Retail_Data.[Sales]', 'sales', 'COLUMN';
EXEC sp_rename 'Global_Retail_Data.[Segment]', 'segment', 'COLUMN';
EXEC sp_rename 'Global_Retail_Data.[Ship Date]', 'ship_date', 'COLUMN';
EXEC sp_rename 'Global_Retail_Data.[Ship Mode]', 'ship_mode', 'COLUMN';
EXEC sp_rename 'Global_Retail_Data.[Shipping Cost]', 'shipping_cost', 'COLUMN';
EXEC sp_rename 'Global_Retail_Data.[State]', 'state', 'COLUMN';
EXEC sp_rename 'Global_Retail_Data.[Sub-Category]', 'sub_category', 'COLUMN';
EXEC sp_rename 'Global_Retail_Data.[Year]', 'year', 'COLUMN';


SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Global_Retail_Data'
ORDER BY ORDINAL_POSITION;

  --Finding null values

SELECT
    SUM(CASE WHEN category IS NULL THEN 1 ELSE 0 END) AS category_nulls,
    SUM(CASE WHEN city IS NULL THEN 1 ELSE 0 END) AS city_nulls,
    SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END) AS country_nulls,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS customer_id_nulls,
    SUM(CASE WHEN customer_name IS NULL THEN 1 ELSE 0 END) AS customer_name_nulls,
    SUM(CASE WHEN discount IS NULL THEN 1 ELSE 0 END) AS discount_nulls,
    SUM(CASE WHEN market IS NULL THEN 1 ELSE 0 END) AS market_nulls,
    SUM(CASE WHEN ji_lu_shu IS NULL THEN 1 ELSE 0 END) AS ji_lu_shu_nulls,
    SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END) AS order_date_nulls,
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS order_id_nulls,
    SUM(CASE WHEN order_priority IS NULL THEN 1 ELSE 0 END) AS order_priority_nulls,
    SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS product_id_nulls,
    SUM(CASE WHEN product_name IS NULL THEN 1 ELSE 0 END) AS product_name_nulls,
    SUM(CASE WHEN profit IS NULL THEN 1 ELSE 0 END) AS profit_nulls,
    SUM(CASE WHEN quantity IS NULL THEN 1 ELSE 0 END) AS quantity_nulls,
    SUM(CASE WHEN region IS NULL THEN 1 ELSE 0 END) AS region_nulls,
    SUM(CASE WHEN row_id IS NULL THEN 1 ELSE 0 END) AS row_id_nulls,
    SUM(CASE WHEN sales IS NULL THEN 1 ELSE 0 END) AS sales_nulls,
    SUM(CASE WHEN segment IS NULL THEN 1 ELSE 0 END) AS segment_nulls,
    SUM(CASE WHEN ship_date IS NULL THEN 1 ELSE 0 END) AS ship_date_nulls,
    SUM(CASE WHEN ship_mode IS NULL THEN 1 ELSE 0 END) AS ship_mode_nulls,
    SUM(CASE WHEN shipping_cost IS NULL THEN 1 ELSE 0 END) AS shipping_cost_nulls,
    SUM(CASE WHEN state IS NULL THEN 1 ELSE 0 END) AS state_nulls,
    SUM(CASE WHEN sub_category IS NULL THEN 1 ELSE 0 END) AS sub_category_nulls,
    SUM(CASE WHEN year IS NULL THEN 1 ELSE 0 END) AS year_nulls,
    SUM(CASE WHEN market2 IS NULL THEN 1 ELSE 0 END) AS market2_nulls,
    SUM(CASE WHEN weeknum IS NULL THEN 1 ELSE 0 END) AS weeknum_nulls
FROM global_retail_data;
           -- No nulls found--

  

   --Checking blank spaces

SELECT
    SUM(CASE WHEN category = '' THEN 1 ELSE 0 END) AS category_empty,
    SUM(CASE WHEN city = '' THEN 1 ELSE 0 END) AS city_empty,
    SUM(CASE WHEN country = '' THEN 1 ELSE 0 END) AS country_empty,
    SUM(CASE WHEN customer_id = '' THEN 1 ELSE 0 END) AS customer_id_empty,
    SUM(CASE WHEN customer_name = '' THEN 1 ELSE 0 END) AS customer_name_empty,
    SUM(CASE WHEN market = '' THEN 1 ELSE 0 END) AS market_empty,
    SUM(CASE WHEN ji_lu_shu = '' THEN 1 ELSE 0 END) AS ji_lu_shu_empty,
    SUM(CASE WHEN order_id = '' THEN 1 ELSE 0 END) AS order_id_empty,
    SUM(CASE WHEN order_priority = '' THEN 1 ELSE 0 END) AS order_priority_empty,
    SUM(CASE WHEN product_id = '' THEN 1 ELSE 0 END) AS product_id_empty,
    SUM(CASE WHEN product_name = '' THEN 1 ELSE 0 END) AS product_name_empty,
    SUM(CASE WHEN region = '' THEN 1 ELSE 0 END) AS region_empty,
    SUM(CASE WHEN segment = '' THEN 1 ELSE 0 END) AS segment_empty,
    SUM(CASE WHEN ship_mode = '' THEN 1 ELSE 0 END) AS ship_mode_empty,
    SUM(CASE WHEN state = '' THEN 1 ELSE 0 END) AS state_empty,
    SUM(CASE WHEN sub_category = '' THEN 1 ELSE 0 END) AS sub_category_empty
FROM global_retail_data;
         --No blank spaces--



   --leading trailing spaces and name variations

   --state
select 
     upper(trim(state)) as standardized_state,
	 count(distinct state) as variations
from global_retail_data
group by upper(trim(state))
having count(distinct state) > 1;

   --city
select 
     upper(trim(city)) as standardized_city,
	 count(distinct city) as variations
from global_retail_data
group by upper(trim(city))
having count(distinct city) > 1;

   --Country
select 
     upper(trim(country)) as standardized_country,
	 count(distinct country) as variations
from global_retail_data
group by upper(trim(country))
having count(distinct country) > 1;

  --Region

select 
     upper(trim(region)) as standardized_region,
	 count(distinct region) as variations
from global_retail_data
group by upper(trim(region))
having count(distinct region) > 1;

  --Market
select 
     upper(trim(market)) as standardized_market,
	 count(distinct market) as variations
from global_retail_data
group by upper(trim(market))
having count(distinct market) > 1;

   --Ship_mode
select 
     upper(trim(ship_mode)) as standardized_ship_mode,
	 count(distinct ship_mode) as variations
from global_retail_data
group by upper(trim(ship_mode))
having count(distinct ship_mode) > 1;

  --Sub_Category

select 
     upper(trim(sub_category)) as standardized_sub_category,
	 count(distinct sub_category) as variations
from global_retail_data
group by upper(trim(sub_category))
having count(distinct sub_category) > 1;

 --Customer_Name

select 
     upper(trim(customer_name)) as standardized_customer_name,
	 count(distinct customer_name) as variations
from global_retail_data
group by upper(trim(customer_name))
having count(distinct customer_name) > 1;

  --Product_Name
select 
     upper(trim(product_name)) as standardized_product_name,
	 count(distinct product_name) as variations
from global_retail_data
group by upper(trim(product_name))
having count(distinct product_name) > 1;


/*-----------------------
2.Data profiling
-------------------------*/

  --Total Orders
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM global_retail_data;

  --Total Customers
select count(distinct customer_id) as total_custoomers
from global_retail_data

  --Total Products
select count(distinct product_id) as total_Products
from global_retail_data

  --Total Countries
select count(distinct country) as total_Countries
from global_retail_data

  --Total Category
select count(distinct category) as total_Category
from global_retail_data

  --Total Sub_category
select count(distinct sub_category) as total_Sub_category
from global_retail_data

  --Year Range and Count
select count(distinct year) from global_retail_data
select min(year) as min_year, max(year) as max_year from global_retail_data

  --Weeknumber Range
select min(weeknum) as min_weeknum, max(weeknum) as max_weeknum from global_retail_data

 /*-----------------------
3.Executive Performance KPI'S
-------------------------*/

   --Total_sales 
 select sum(sales) as total_sales from global_retail_data

   --Total_Profit
select sum(profit) as total_profit from global_retail_data

  --Profit_Margin
select round(sum(profit) / sum(sales),4) * 100 as profit_margin from  global_retail_data

  --Total Orders
select count(distinct order_id) as total_orders from global_retail_data

  --Total Customers
select count(distinct customer_id) as total_customers from global_retail_data

  --Avg_order_value
select round(sum(sales) / count(distinct order_id),2) as avg_order_value from global_retail_data

/*-----------------------
4.profitability optimization
-------------------------*/

  --why profit is not increasing at the same rates as sales
select discount, sum(sales) as total_sales, sum(profit) as total_profit,
count(distinct order_id) as total_orders,round(sum(profit) / sum(sales) * 100,4) as profit_margin,
round(sum(sales) / count(distinct order_id),2) as avg_sales_per_order,
round(sum(profit) / count(distinct order_id),2) as avg_profit_per_order
from global_retail_data
group by discount 
order by discount asc
--Increasing discounts generally reduce profitability. Discounts of 30% or more are associated with negative profit margins, 
--indicating that the company may be sacrificing profit to drive sales.



  -- Shipping Cost Impact on Profitability

    --ship mode impact
 select ship_mode, sum(profit) as total_profit,
        sum(sales) as total_sales,
		count(distinct order_id) as total_orders,
		round(sum(profit) / sum(sales) * 100,2) as profit_margin
 from global_retail_data
 group by ship_mode
 order by total_profit desc

    --shipping cost impact
 select shipping_cost, sum(profit) as total_profit
 from global_retail_data
 group by shipping_cost
 order by shipping_cost asc

   --shipping mode and shipping cost does not appear to be main reason for profit low
 select 
      ship_mode,
	  avg(shipping_cost) as avg_ship_cost,
	  round(sum(profit) / sum(sales) * 100,2) as profit_margin
from global_retail_data 
group by ship_mode
order by avg_ship_cost desc

  --loss making transactions percentage
 
 select 
       count(*) as total_transactions,
	   sum(case when profit < 0 then 1 else 0 end) as loss_transactions,
	   round(
	   sum(case when profit < 0 then 1 else 0 end) * 100 / count(*) ,2) as loss_percentage
from global_retail_data

-- Shipping mode and average shipping cost do not show a significant impact on overall profitability. 
--Although Same Day shipping has more than double the average shipping cost of Standard Class,
--loss making transactions 24 percent
--profit margins remain relatively consistent across all shipping modes. Therefore, 
--discount strategy and product performance should be prioritized for profitability improvements 




/*-----------------------
5.Product performance
-------------------------*/

  --Top 10 most profitable products

select product_name,
       sum(sales) as Total_sales,
       sum(profit) as Total_profit,
	   sum(sales) / count(distinct order_id) Avg_sales_per_order,
	   count(distinct order_id) as total_orders,round(sum(profit) / sum(sales) * 100,4) as profit_margin
from global_retail_data
group by  product_name
order by Total_profit desc

  --Top 10 loss making products

select product_name,
       sum(sales) as Total_sales,
       sum(profit) as Total_profit,
	   sum(sales) / count(distinct order_id) Avg_sales_per_order,
	   count(distinct order_id) as total_orders,round(sum(profit) / sum(sales) * 100,4) as profit_margin
from global_retail_data
group by  product_name
order by Total_profit asc


  --Category Performance (Only 3 categories)

select category,
       sum(sales) as total_sales,
	   sum(profit) as total_profit,
	   count(distinct order_id) as total_orders,
	   round(sum(profit) / sum(sales) * 100,2) as profit_margin 
from global_retail_data
group by category
order by total_profit desc

  --sub_Category Performance (Only 3 categories)

select sub_category,
       sum(sales) as total_sales,
	   sum(profit) as total_profit,
	   count(distinct order_id) as total_orders,
	   round(sum(profit) / sum(sales) * 100,2) as profit_margin 
from global_retail_data
group by sub_category
order by total_profit desc

  -- Tables are in negative profit and ne profit margin of -8.47 %

  -- Tables with profits
select product_name,
      sum(sales) as total_sales,
	  sum(profit) as total_profit,
	  round(sum(profit) / sum(sales) * 100,2) as profit_margin
from global_retail_data
WHERE sub_category = 'Tables'
group by product_name
having sum(profit) > 0
order by total_profit asc

  --Tables with negative profits
select product_name,
      sum(sales) as total_sales,
	  sum(profit) as total_profit,
	  round(sum(profit) / sum(sales) * 100,2) as profit_margin
from global_retail_data
WHERE sub_category = 'Tables'
group by product_name
having sum(profit) <  0
order by total_profit asc

  --Discount vs Tables
select discount,
      sum(sales) as total_sales,
	  sum(profit) as total_profit,
	  round(sum(profit) / sum(sales) * 100,2) as profit_margin
from global_retail_data
WHERE sub_category = 'Tables'
group by discount
order by discount asc

   /*Conclusion:
     Tables become loss-making primarily due to high discounts*/
--The Tables sub-category is not inherently unprofitable. It becomes loss-making primarily when high discounts are applied.

--Furniture has low profitability.
-- Tables is the only loss-making sub-category.
-- Many table products lose money.
-- High discounts (30% and above) are the likely driver of those losses.


/*-----------------------
6.Customer_Analysis
-------------------------*/

  -- Top customers by profit
select customer_id,customer_name,
       count( distinct order_id) as total_orders,
       sum(sales) as total_sales,
	   sum(profit) as total_profit,
	   round((sum(profit) / sum(sales)) * 100,2)   as profit_margin
from   global_retail_data
group by customer_id,customer_name
order by total_profit desc--most valuable customers
--order by total_orders desc --most Most frequent buyers
--order by total_sales desc -- Biggest spenders


  -- Top customers by sales
select customer_id,customer_name,
       count( distinct order_id) as total_orders,
       sum(sales) as total_sales,
	   sum(profit) as total_profit,
	   round((sum(profit) / sum(sales)) * 100,2)   as profit_margin
from   global_retail_data
group by customer_id,customer_name
order by total_sales desc


/*==========================================================
 CASE STUDY: Sean Miller
  Investigate why a high-sales customer generated losses.
  ==========================================================*/
select customer_name,discount,
       count(distinct order_id) as total_orders,
	   sum(sales) as total_sales,
	   sum(profit) as total_profit,
	   round((sum(profit) / sum(sales)) * 100,2)   as profit_margin,
	   count(distinct category) as total_category,
	   count(distinct sub_category) as total_sub_category
from global_retail_data
where customer_name = 'sean miller'
group by customer_name,discount
order by total_profit desc

 --Case Study
 --Investigate why high-sales customer Sean Miller is genarating losses.

  --Sean miller analysis based on category
select customer_name,category,
       sum(sales) as total_sales,
	   sum(profit) as total_profit,
	   round((sum(profit) / sum(sales)) * 100,2)   as profit_margin
from global_retail_data
where customer_name = 'sean miller'
group by category,customer_name
order by total_profit desc

  --sean miller analysis based on sub category
select customer_name,sub_category,
       sum(sales) as total_sales,
	   sum(profit) as total_profit,
	   round((sum(profit) / sum(sales)) * 100,2)   as profit_margin
from global_retail_data
where customer_name = 'sean miller'
group by sub_category,customer_name
order by total_profit desc

  /* Conclusion:
     Sean Miller's losses are mainly driven by heavily discounted Machine purchases.*/

  --customer segment analysis
select segment,
       sum(sales) as total_sales,
	   sum(profit) as total_profit,
	   count(distinct order_id) as total_orders,
	   round((sum(profit) / sum(sales)) * 100,2)   as profit_margin,
	   round(sum(sales) / count(distinct order_id),2) as avg_sales_per_order
from global_retail_data
group by segment
order by total_profit desc

  --Which customer segment contributes the most to the company's total revenue?

select 
     segment,
	 sum(sales) as total_sales,
	 sum(profit) as total_profit,
	 count(distinct order_id) as total_orders,
     round((sum(profit) / sum(sales)) * 100,4) as profit_margin
from global_retail_data
group by segment
order by total_profit desc

/*-----------------------
7.Geographic performance analysis
-------------------------*/

  --country performance
  --Top Countries
select country,
       sum(sales) as total_sales,
	   sum(profit) as total_profit,
	   count(distinct order_id) as total_orders,
	   round((sum(profit) / sum(sales)) * 100,2)   as profit_margin,
	   round(sum(sales) / count(distinct order_id),2) as avg_sales_per_order
from global_retail_data
group by country
order by total_profit desc

  --Bottom countries
select country,
       sum(sales) as total_sales,
	   sum(profit) as total_profit,
	   count(distinct order_id) as total_orders,
	   round((sum(profit) / sum(sales)) * 100,2)   as profit_margin,
	   round(sum(sales) / count(distinct order_id),2) as avg_sales_per_order
from global_retail_data
group by country
order by total_profit asc

  --Drill down Discount analysis for turkey
select country,discount,
       count(distinct order_id) as total_orders,
	   sum(sales) as total_sales,
	   sum(profit) as total_profit,
	   round((sum(profit) / sum(sales)) * 100,2)   as profit_margin,
	   count(distinct category) as total_category,
	   count(distinct sub_category) as total_sub_category
from global_retail_data
where country = 'turkey'
group by country,discount
order by total_profit asc 

  --Category analysis 
select country, category,
       count(distinct order_id) as total_orders,
	   sum(sales) as total_sales,
	   sum(profit) as total_profit,
	   round((sum(profit) / sum(sales)) * 100,2)   as profit_margin
from global_retail_data
where country = 'turkey'
group by country,category
order by total_profit desc  

  --Sub_Category analysis
select country, sub_category,
       count(distinct order_id) as total_orders,
	   sum(sales) as total_sales,
	   sum(profit) as total_profit,
	   round((sum(profit) / sum(sales)) * 100,2)   as profit_margin
from global_retail_data
where country = 'turkey'
group by country,sub_category
order by total_profit desc 

  --Discount analysis for Nigeria
select country,discount,
       count(distinct order_id) as total_orders,
	   sum(sales) as total_sales,
	   sum(profit) as total_profit,
	   round((sum(profit) / sum(sales)) * 100,2)   as profit_margin,
	   count(distinct category) as total_category,
	   count(distinct sub_category) as total_sub_category
from global_retail_data
where country = 'Nigeria'
group by country,discount
order by total_profit asc 
  
  /*Conclusion:
   Aggressive discounting appears to be the primary driver of losses.*/

   --Discount analysis for Netherlands
select country,discount,
       count(distinct order_id) as total_orders,
	   sum(sales) as total_sales,
	   sum(profit) as total_profit,
	   round((sum(profit) / sum(sales)) * 100,2)   as profit_margin,
	   count(distinct category) as total_category,
	   count(distinct sub_category) as total_sub_category
from global_retail_data
where country = 'Netherlands'
group by country,discount
order by total_profit asc
       
 --Discount analysis for honduras   
select country,discount,
       count(distinct order_id) as total_orders,
	   sum(sales) as total_sales,
	   sum(profit) as total_profit,
	   round((sum(profit) / sum(sales)) * 100,2)   as profit_margin,
	   count(distinct category) as total_category,
	   count(distinct sub_category) as total_sub_category
from global_retail_data
where country = 'honduras'
group by country,discount
order by total_profit asc

  --Discount analysis for usa
select country,discount,
       count(distinct order_id) as total_orders,
	   sum(sales) as total_sales,
	   sum(profit) as total_profit,
	   round((sum(profit) / sum(sales)) * 100,2)   as profit_margin,
	   count(distinct category) as total_category,
	   count(distinct sub_category) as total_sub_category
from global_retail_data
where country = 'united states'
group by country,discount
order by total_profit desc

  --Discount analysis for china
select country,discount,
       count(distinct order_id) as total_orders,
	   sum(sales) as total_sales,
	   sum(profit) as total_profit,
	   round((sum(profit) / sum(sales)) * 100,2)   as profit_margin,
	   count(distinct category) as total_category,
	   count(distinct sub_category) as total_sub_category
from global_retail_data
where country = 'china'
group by country,discount
order by total_profit desc

  --Discount analysis for india
select country,discount,
       count(distinct order_id) as total_orders,
	   sum(sales) as total_sales,
	   sum(profit) as total_profit,
	   round((sum(profit) / sum(sales)) * 100,2)   as profit_margin,
	   count(distinct category) as total_category,
	   count(distinct sub_category) as total_sub_category
from global_retail_data
where country = 'india'
group by country,discount
order by total_profit desc


  --Regional performance

select region,
       count(distinct order_id) as total_orders,
	   sum(sales) as total_sales,
       sum(profit) as total_profit,
	   round((sum(profit) / sum(sales)) * 100,2)   as profit_margin,
	   round(sum(sales) / count(distinct order_id),2) as avg_sales_per_order
from global_retail_data
group by region
order by total_profit desc

 --Market performance
select market,
       count(distinct order_id) as total_orders,
	   sum(sales) as total_sales,
       sum(profit) as total_profit,
	   round((sum(profit) / sum(sales)) * 100,2)   as profit_margin,
	   round(sum(sales) / count(distinct order_id),2) as avg_sales_per_order
from global_retail_data
group by market
order by total_profit desc

  --Market2 performance
select market2,
       count(distinct order_id) as total_orders,
	   sum(sales) as total_sales,
       sum(profit) as total_profit,
	   round((sum(profit) / sum(sales)) * 100,2)   as profit_margin,
	   round(sum(sales) / count(distinct order_id),2) as avg_sales_per_order
from global_retail_data
group by market2
order by total_profit desc

 /*Drilling down Southeast Asia (bad performer)*/

  --Based on discount
select discount,
       count(distinct order_id) as total_orders,
	   sum(sales) as total_sales,
       sum(profit) as total_profit,
	   round((sum(profit) / sum(sales)) * 100,2)   as profit_margin,
	   round(sum(sales) / count(distinct order_id),2) as avg_sales_per_order
from global_retail_data
where region = 'Southeast Asia'
group by discount
order by discount asc


 
  --Based on category
select category,region,
       count(distinct order_id) as total_orders,
	   sum(sales) as total_sales,
       sum(profit) as total_profit,
	   round((sum(profit) / sum(sales)) * 100,2)   as profit_margin,
	   count(distinct sub_category) as total_sub_category
from global_retail_data
where region = 'Southeast Asia'
group by category,region
order by total_profit desc

 -- Based on sub_category
select sub_category,region,category,
       count(distinct order_id) as total_orders,
	   sum(sales) as total_sales,
       sum(profit) as total_profit,
	   round((sum(profit) / sum(sales)) * 100,2)   as profit_margin
	   --count(distinct category) as total_category
from global_retail_data
where region = 'Southeast Asia'
group by sub_category,region,category
order by total_profit desc
  /*-- Conclusion:
   Weak profitability is linked to Furniture (especially Tables) and high-discount transactions.*/

  --Drill down best performer (North Asia)

  --Based on discount
select discount,
       count(distinct order_id) as total_orders,
	   sum(sales) as total_sales,
       sum(profit) as total_profit,
	   round((sum(profit) / sum(sales)) * 100,2)   as profit_margin,
	   round(sum(sales) / count(distinct order_id),2) as avg_sales_per_order
from global_retail_data
where region = 'North Asia'
group by discount
order by discount asc


 
  --Based on category
select category,
       count(distinct order_id) as total_orders,
	   sum(sales) as total_sales,
       sum(profit) as total_profit,
	   round((sum(profit) / sum(sales)) * 100,2)   as profit_margin,
	   count(distinct sub_category) as total_sub_category
from global_retail_data
where region = 'North Asia'
group by category--,region
order by total_profit desc

  -- Based on sub_category
select sub_category,category,
       count(distinct order_id) as total_orders,
	   sum(sales) as total_sales,
       sum(profit) as total_profit,
	   round((sum(profit) / sum(sales)) * 100,2)   as profit_margin
	   --count(distinct category) as total_category
from global_retail_data
where region = 'North Asia'
group by sub_category,category
order by total_profit desc

 /*-- Conclusion:
   Strong profitability is supported by controlled discounting and consistently profitable categories.*/

/*-----------------------
8.Discount Strategy Evaluation
-------------------------*/

  --Discount vs Sales

SELECT discount * 100 AS discount_percentage,
       sum(sales) as total_sales,
	   sum(profit) as total_profit,
	   count(distinct order_id) as total_orders,
	   round((sum(profit)/sum(sales)) * 100,4) as profit_margin,
	   round((sum(sales) / count(distinct order_id)) ,2) as avg_sales_per_order
from global_retail_data
group by discount
order by discount desc


/*-----------------------
9.Time Based analysis
-------------------------*/
  --Yearly Performance

select year,
       sum(sales) as total_sales,
	   sum(profit) as total_profit,
	   count(distinct order_id) as total_orders,
	   round((sum(profit)/sum(sales)) * 100,4) as profit_margin,
	   round((sum(sales) / count(distinct order_id)) ,2) as avg_sales_per_order
from global_retail_data
group by year
order by total_profit desc


-- Note:
-- Monthly analysis was not performed because the
-- order_date column did not contain usable values.

  --Weekly performance
select weeknum,
       sum(sales) as total_sales,
	   sum(profit) as total_profit,
	   count(distinct order_id) as total_orders,
	   round((sum(profit)/sum(sales)) * 100,4) as profit_margin,
	   round((sum(sales) / count(distinct order_id)) ,2) as avg_sales_per_order
from global_retail_data
where year = '2012'
group by weeknum
order by weeknum asc 

/*==========================================================
  PROJECT SUMMARY

  Key Findings:
  - High discounts significantly reduce profitability.
  - Tables is the primary loss-making sub-category.
  - Southeast Asia underperforms due to weak product profitability.
  - Customer segments are balanced with similar profit margins.
  - The business demonstrates steady year-over-year growth.

  Recommendations:
  - Optimize discount policies.
  - Review the Tables sub-category.
  - Focus on high-margin products.
  - Improve pricing in underperforming regions.
  - Retain high-value customers.
==========================================================*/












