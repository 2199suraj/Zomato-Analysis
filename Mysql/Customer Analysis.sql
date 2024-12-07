create database customer_analysis;
use customer_analysis;

#1
create table sales_people (snum int, sname varchar(30), city varchar(30), comm int);
desc sales_people;

alter table sales_people modify comm double(2,2);

insert into sales_people values 
(1001, "Peel", "London", 0.12),
(1002, "Serres", "San Jones", 0.13),
(1003, "Axelrod", "New York", 0.10),
(1004, "Motika", "London", 0.11),
(1007, "Rafkin", "Barcelona", 0.15);

select * from sales_people;

#2
create table cust (cnum int, cname varchar(30), city varchar(30), rating int, snum int);
desc cust;

insert into cust values 
(2001, "Hoffman", "London", 100, 1001),
(2002, "Giovanne", "Rome", 200, 1003),
(2003, "Liu", "San Jones", 300, 1002),
(2004, "Grass", "Berlin", 100, 1002),
(2006, "Clemens", "London", 300, 1007),
(2007, "Pereira", "Rome", 100, 1004),
(2008, "James", "London", 200, 1007);

select * from cust;

#3
create table orders (Oname int, amt int, Odate datetime, cnum int, snum int);
desc orders;

alter table orders rename column Oname to Onum;

insert into orders values 
(3001, 18.69, '1994-10-03', 2008, 1007),
(3002, 1900.10, '1994-10-03', 2007, 1004),
(3003, 767.19, '1994-10-03', 2001, 1001),
(3005, 5160.45, '1994-10-03', 2003, 1002),
(3006, 1098.16, '1994-10-04', 2008, 1007),
(3007, 75.75, '1994-10-05', 2004, 1002),
(3008, 4723.00, '1994-10-05', 2006, 1001),
(3009, 1713.23, '1994-10-04', 2002, 1003),
(3010, 1309.95, '1994-10-06', 2004, 1002),
(3011, 9891.88, '1994-10-06', 2006, 1001);

select * from orders;

#4
select sp.snum as Salesperson_ID, sp.sname as Salesperson_Name, cs.cnum as customer_ID, 
cs.cname as Customer_Name, sp.city as Saleperson_City, 
sp.comm as Salesperson_Comm, cs.city as Cusotmer_City, 
cs.rating as Customer_Rating 
from sales_people sp inner join cust cs on sp.snum=cs.snum where sp.city=cs.city;

#5
select  cs.cnum as customer_ID, cs.cname as Customer_Name,
cs.city as Cusotmer_City, cs.rating as Customer_Rating,
sp.sname as Salesperson_Name;

#6
select cs.cnum as customer_num, cs.cname as Cusotmer_Name, sp.sname as Salesperson_Name, cs.city as customer_city, sp.city as Salesperson_city,
od.Onum as Order_Number, od.amt as Order_Amount, od.odate as Order_date from orders od 
RIGHT JOIN cust cs on od.cnum=cs.cnum
RIGHT JOIN sales_people sp on od.snum=sp.snum where cs.city<>sp.city;

#7
select od.Onum as Order_Number, od.amt as Order_Amount, od.odate as Order_date, 
cs.cnum as customer_num, cs.cname as Cusotmer_Name, cs.city as customer_city
from orders od LEFT JOIN cust cs on od.cnum=cs.cnum;

#8
select cs1.cname as Customer1, cs2.cname as customer2, cs1.rating
from cust cs1 INNER JOIN cust cs2 on cs1.rating=cs2.rating where 
cs1.rating=cs2.rating and cs1.cnum<>cs2.cnum order by rating;

select cs1.cname as Customer1, cs2.cname as customer2, cs1.rating
from cust cs1 INNER JOIN cust cs2 on cs1.rating=cs2.rating where 
cs1.rating=cs2.rating and cs1.cnum<>cs2.cnum and 
cs1.cnum<cs2.cnum order by rating;

#9

select cs.cnum, cs.cname, cs.city, cs.rating, cs.snum, sp.sname from cust cs 
Inner join sales_people sp on cs.snum=sp.snum
where cs.snum in (select snum from cust group by snum having count(snum)>1);

#10
select * from sales_people where city
in (select city from sales_people group by city having count(city)>1);

#11
select od.Onum as Order_Number, od.amt as Amount, od.odate as Order_date,
sp.snum as Sales_person_num, sp.sname as Sales_person_name, cs.cname as customer_name
from orders od INNER JOIN sales_people sp on sp.snum=od.snum 
INNER JOIN cust cs on od.cnum=cs.cnum
where od.cnum=2008;

#12
select * from orders where amt > (select avg(amt) from orders where odate = '1994-10-04');

#13
select * from orders od INNER JOIN sales_people sp on od.snum=sp.snum where sp.city='London'; #using join

select * from orders where snum in (select snum from sales_people where city='London'); #using subquery

#14

select * from cust where cnum > (select snum+1000 from sales_people where sname='serres');

#15

select city, avg(rating) from cust group by city;

select count(cnum) from cust where rating > (select avg(rating) from cust where city='San Jones');

#16

select * from cust where snum in (select snum from cust  group by snum having count(snum)>1);
