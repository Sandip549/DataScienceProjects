SELECT * FROM retail_store.tr_orderdetails;
select count(*) from tr_orderdetails;

/* find the maximum quantity sold in a transaction*/
select max(Quantity),count(*) from tr_orderdetails;

/* Q 2 find the unique products in all the transaction */
select distinct ProductID, Quantity from tr_orderdetails where Quantity=3 order by ProductID asc, Quantity desc;

/* Q 3 find the unique properties */
select distinct PropertyID from tr_orderdetails;

/* Group by Q 4 find the product category that has maximum products */
select ProductCategory,count(*) as Count from tr_products group by ProductCategory order by 2 desc; 
# here 2 is for second column in the result for its sorting

/* Q 5 find the state where most stores are present */
select * from tr_propertyinfo;
select PropertyState, count(*) as Count from tr_propertyinfo group by PropertyState order by 2 desc;

/* Q 6 find the top 5 product IDs that did maximum sales in terms of Quantity */
select ProductID, sum(Quantity) as total_quantity from tr_orderdetails group by ProductID order by 2 desc limit 5;

/* Q 7 find the top 5 property IDs that did maximum Quantity */
select PropertyID, sum(Quantity) as total_quantity from tr_orderdetails group by PropertyID order by 2 desc limit 5;

/* Joins and Group By */
/* Q 8 find top 5 product names that did maximum sales in terms of Quantity */
# in excel we using VLOOKUP for this and in SQL we use JOINS
select * from tr_orderdetails as o
left join tr_Products as p on o.ProductID = p.ProductID;

select o.*,p.ProductName,P.ProductCategory,p.Price from tr_orderdetails as o left join 
tr_products as p on o.ProductID = p.ProductID;

/* Q 8 ans */
select p.ProductName, sum(o.Quantity) as total_quantity from tr_orderdetails as o left join tr_products as p
on o.ProductID = p.ProductID group by p.ProductName order by 2 desc limit 5;

/* Q 8.1 find top 5 product that did maximum sales */
select p.ProductName, sum(o.Quantity * p.Price) as sales from tr_orderdetails as o left join tr_products as p 
on o.ProductID = p.ProductID group by p.ProductName order by sales desc limit 5;

/* Q 9 find top 5 cities that did maximum sales */
select pi.PropertyCity, sum(o.Quantity * p.Price) as sales from tr_orderdetails as o 
left join tr_products as p on o.ProductID = p.ProductID 
left join tr_propertyinfo as pi on o.PropertyID = pi.`Prop ID`
group by pi.PropertyCity order by Sales desc limit 5;

/* Q 10 find the top 5 */
select pi.PropertyCity, p.ProductName, sum(o.Quantity * p.Price) as Sales from tr_orderdetails as o
left join tr_products as p on o.ProductID = p.ProductID
left join tr_propertyinfo as pi on o.PropertyID = pi.`Prop ID` where pi.PropertyCity = 'Arlington'
group by pi.PropertyCity, p.ProductName order by Sales desc limit 5;
