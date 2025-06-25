select count( distinct category) as uniqu_category from retail_sales_project;
select * from retail_sales_project;
---- Business & DataAnalysis  question ----
/*Write a  SQL query to review  the data where sale made on "2022-11-05"*/
select transactions_id,sale_date,customer_id,category,gender,quantiy 
from retail_sales_project where sale_date ="2022-11-05";

/*write a queary to review  all the data  where category  is clothing  and the quantity 
sold is more than 4in the month of nov 2022 */
select * from retail_sales_project
where category = "clothing" 
and sale_date = "2022-11--%" 
or quantiy >=48;
/*write a queary to review  all the data  where category  is clothing  and the quantity 
sold is more than 4in the month of nov 2022 */
select *
from retail_sales_project
where category= "Clothing"
AND
date_format(sale_date,"%Y-%M")="2022-November"
 AND quantiy >=4;
select category,sum(quantiy) 
from retail_sales_project
where category= "Clothing"
GROUP BY 1;
/* WRITE a sql query to calculate total sale  for each category?*/
select category,sum(total_sale) as category_wise_sales,count(*) as total_order from retail_sales_project
group by category;

/* WRITE a sql query to calculate  average age  who purchse items from the "beauty"category*/

select 
round(avg(age),2) as avg_age
from retail_sales_project
where category like "Beauty%";
/*Write a SQL query tp find  all transaction where the total_sale is grater than 1000*/

select transactions_id, total_sale, sale_date from retail_sales_project 
where total_sale >1000;

/*Write a SQL query to find  a total number of transaction(transaction_id) made by each gender in each category */
select
category,
gender,
count(*) AS toatl_Transaction
from retail_sales_project
group by 
category,
gender
order by 1;

/*Write a SQL query to calculate  the average 
 sales for each month, find out the best selling month in each year*/
select 
extract(year from sale_date) as year, 
extract(month from sale_date)as month,
round(avg(total_sale),2) as avg_sale
from retail_sales_project
group by 1,2
order by 1,3 desc;

select year,month,AVG_sale from(
select 
extract(year from sale_date) as year, 
extract(month from sale_date)as month,
round(avg(total_sale),2) as avg_sale,
rank() over(partition by extract(year from sale_date) order by round(avg(total_sale),2)Desc) as ran
from retail_sales_project
group by 1,2
) as p1
 where ran = 1;
select * from retail_sales_project;
 /*Write  top 5  customer based on highest total_sales*/ 
 select customer_id,
 Sum(total_sale) as heighest_sale
 from retail_sales_project
 group by customer_id
 order by 2 desc
 limit 5;
/* write a SQL query to find unique customer from each category*/
select 
category,
count(distinct(customer_id))as cust_id
from retail_sales_project
group by category;

/*write a SQL query to create each shift and number of orders eg.Morning<=12,Afternoon Between 12& 17,evening>12))*/
with hourly_retailsales
as(
select *,
Case 
when extract(hour from sale_time) < 12 then "Morning"
when extract( hour from sale_time )between 12 and 17 then "Afternoon"
else "Evning"
end as shift
from retail_sales_project)
select 
count(transactions_id) as total_order,shift
 from hourly_retailsales
group by shift;


