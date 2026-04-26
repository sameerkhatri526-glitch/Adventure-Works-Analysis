create database SQL_Project;
use sql_project;
Set SQL_Safe_updates=0;

select * from dimcustomer;
select * from dimdate;
select * from dimsalesterritory;
select * from dimproduct;
select * from dimproductcategory;
select * from dimproductsubcategory;
select * from fact_internet_sales_new;
select * from factinternetsales;


#1 Union Two table
select * from fact_internet_sales_new;
select * from factinternetsales
union all
select * from fact_internet_sales_new;

#2 Sales amount 
select unitprice,orderquantity,UnitPriceDiscountPct,
(unitprice * orderquantity * (1 - UnitPriceDiscountPct)) as sales_amount from fact_internet_sales_new ;
  
  
#3 Productioncost  
select unitprice,orderquantity,
(unitprice * orderquantity) as Production_cost from fact_internet_sales_new;

#4 Profit
select  unitprice,orderquantity,unitpricediscountPct,TotalProductCost,
    
    #Sales Amount
    (unitprice * orderquantity * (1 - unitpricediscountPct)) as sales_amount,
    
    #Production Cost
    (TotalProductCost * orderquantity) as Production_cost,
    
    #Profit
    round((unitprice * orderquantity * (1 - unitpricediscountPct)) 
     - (TotalProductCost * orderquantity),2) as profit

from fact_internet_sales_new;

#5 Yearwise Sales Amount filter

select year(OrderDateKey) as year,
monthname(OrderDateKey) as month,
round(sum(unitprice * orderquantity * (1 - unitpricediscountPct)),2) as total_sales from fact_internet_sales_new
where year (OrderDateKey) = 2014
group by    
year(OrderDateKey),month(OrderDateKey)
order by 
month(OrderDateKey);

#6 Yearwise Sales

select year(OrderDateKey) as year,
round(sum(unitprice * orderquantity * (1 - unitpricediscountPct)),2) as total_sales from fact_internet_sales_new
group by year(OrderDateKey)
order by year;


#7 Monthwise sales

select year(OrderDateKey) as year, monthname(OrderDateKey) as Month,
round(sum(unitprice * orderquantity * (1 - unitpricediscountPct)),2) as total_sales from fact_internet_sales_new
group by year(orderdatekey),monthname(OrderDateKey) 
order by year,Month ;

 
#8 Quarterwise saeles 

select year(OrderDateKey) as year,concat('Q', quarter(OrderDateKey)) as Quarter,
round(sum(unitprice * orderquantity * (1 - unitpricediscountPct)),2) as total_sales from fact_internet_sales_new
group by year(OrderDateKey),Quarter(OrderDateKey)
Order by year, Quarter(OrderDateKey);


#9 Sales amount and Production Cost

select (unitprice * orderquantity * (1 - unitpricediscountPct)) as Sales_amount,
    (TotalProductCost * orderquantity) As Production_cost from fact_internet_sales_new;
    
    






