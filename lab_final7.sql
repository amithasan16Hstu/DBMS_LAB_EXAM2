create database l1;
use l1;
create table salesman(
salesman_id int not null,
salesman_name varchar(20),
city varchar(20),
commission double,
primary key(salesman_id)
);
insert into salesman(salesman_id,salesman_name,city,commission)
values(7001,'John Legend','Los Angeles',0.12),(7002,'Elton John','New York',0.15),
(7003,'Freddie Mercury','San Diego',0.10),(7004,'Prince','New York',0.14);

create table customer(
customer_id int not null,
cust_name varchar(20),
city varchar(20),
grade int,
salesman_id int,
primary key(customer_id),
foreign key(salesman_id) references salesman(salesman_id)
);
insert into customer(customer_id,cust_name,city,grade,salesman_id)
values(4001,'Alice Cooper','Los Angeles',150,7001),(4002,'Bob Marley','New York',200,7002),
(4003,'Charlie Chap','San Francisco',100,7003),(4004,'Diana Prince','New York',300,7004);

create table orders(
ord_no int not null,
purch_amt double,
ord_date date,
customer_id int,
salesman_id int,
primary key(ord_no),
foreign key(customer_id) references customer(customer_id),
foreign key(salesman_id) references salesman(salesman_id)
);
insert into orders(ord_no,purch_amt,ord_date,customer_id,salesman_id)
values(9001,300.75,'2023-05-20',4001,7001),(9002,150.50,'2023-04-15',4002,7002),
(9003,250.00,'2023-06-10',4003,7003),(9004,500.00,'2023-03-25',4004,7004);

-- Find customers and salespeople who live in the same city.
-- Return cust_name, salesman_name, and city.
select c.cust_name as CustomerName,s.salesman_name as SalesmanName,c.city
from customer c
join salesman s on c.salesman_id=s.salesman_id
where c.city=s.city;

-- Find salespeople with commissions greater than 0.12 and their associated customers. 
-- Return cust_name, city, grade, salesman_name, and commission.

select c.cust_name as CustomerName,c.city as CustomerCity,c.grade,s.salesman_name as SalesmanName,s.commission
from customer c
join salesman s on c.salesman_id=s.salesman_id
where s.commission>0.12;

-- List orders where the purchase amount is greater than 200 and sort the result by purch_amt in descending order. 
-- Return ord_no, purch_amt, cust_name, and salesman_name.

select o.ord_no,o.purch_amt,c.cust_name,s.salesman_name
from customer c
join salesman s on c.salesman_id=s.salesman_id
join orders o on s.salesman_id=o.salesman_id
where purch_amt>200
order by purch_amt desc;

-- Find customers who placed orders in May 2023.
-- Return cust_name, salesman_name, and ord_date.

select c.cust_name,s.salesman_name,o.ord_date
from customer c
join salesman s on c.salesman_id=s.salesman_id
join orders o on s.salesman_id=o.salesman_id
where o.ord_date>'2023-05-01' and o.ord_date<'2023-05-31';

-- Find the total purchase amount (purch_amt) made by each customer.
-- Return cust_name and total_purch_amt.

select c.cust_name, sum(o.purch_amt) as total_purch_amt
from customer c
join orders o
on c.salesman_id=o.salesman_id
group by cust_name;

-- List the salesperson with the highest total sales.
-- Return salesman_name, city, and total_sales.

select s.salesman_name,s.city, sum(o.purch_amt) as total_sales
from salesman s
join orders o on s.salesman_id=o.salesman_id
group by s.salesman_name,s.city
order by sum(o.purch_amt) desc;

-- Find customers who have not placed any orders.
-- Return cust_name, city, and salesman_name.
select c.cust_name,c.city,s.salesman_name
from customer c
join salesman s on c.salesman_id=s.salesman_id
join orders o on s.salesman_id= o.salesman_id
where c.customer_id !=o.o.customer_id;







