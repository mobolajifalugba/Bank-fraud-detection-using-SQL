--CASE STUDY: FRAUDULENT TRANSACTIONS IN THE BANK

select * from fraudulent;

--1. How many transactions occurred per transaction type?
select "type", count(*) from fraudulent
group by "type";

--2. Which Transaction Type has the highest number of Fraudulent Transactions?
select "type", count(*) "no of fraud" from fraudulent
where "isfraud" = 1
group by "type"
order by "no of fraud" desc
limit 1;

--3. What is the average fraudulent transaction amount?
--the CEIL function is used to round up the value to the nearest integer
select ceil(avg("amount")) "average fraud amount" from fraudulent
where "isfraud" = 1;

--4. What is the Maximum fraudulent transaction amount?
select "amount" "max fraud amount" from fraudulent
where "isfraud" = 1
order by "amount" desc
limit 1;

--5. What is the Minimum fraudulent transaction amount?
select "amount" "min fraud amount" from fraudulent
where "isfraud" = 1
order by "amount" asc
limit 1;

--6. Who are the Top 10 customers with the highest amount defrauded?
select "nameorig", sum("amount") "amt defrauded" from fraudulent
where "isfraud" = 1
group by "nameorig"
order by "amt defrauded" desc
limit 10;

--7. How effective is the bank in flagging fraud?

--count of transactions flagged fraud correctly
select count(*) from fraudulent
where "isflaggedfraud" = 1 and "amount" >= 200000; -- 16

--count of fraud transactions not flagged
select count(*) from fraudulent
where "isflaggedfraud" = 0 and "amount" >200000;       -- 10026

--Total transactions that should be flagged fraud
select count(*) from fraudulent
where "amount" >=200000;                               -- 10042



-- How effective is the bank in flagging fraud?
select round((select count(*) from fraudulent
where "isflaggedfraud" = 1 and "amount" >= 200000)*100.0/ (select count(*) from fraudulent
where "amount" >=200000),2);   -- 0.16%


--8. Who are the Top 20 Fraudsters
select "namedest", sum("amount") "amt defrauded" from fraudulent
where "isfraud" = 1
group by "namedest"
order by "amt defrauded" desc
limit 20;







/* CREATING TABLE AND LOADING DATA
create table fraudulent(
step int,
type varchar(20),
amount float,
nameorig varchar(50),
oldbalanceorg float,
newbalanceorig float,
namedest varchar(50),
oldbalancedest float,
newbalancedest float,
isfraud int,
isflaggedfraud int
);

copy public.fraudulent
from 'C:\Users\akann\Downloads\Fraudulent Transactions.csv'
delimiter ',' csv header; */