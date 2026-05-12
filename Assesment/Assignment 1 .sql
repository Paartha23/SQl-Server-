
select * from Production.product

---1---
select * from Production.product
---2---
select name,productnumber,color 
from Production.Product

---3---

select name as Productname , listprice as retailprice 
from Production.Product

---4---
select  Distinct color 
from Production.Product
---5---
select Distinct Jobtitle 
from HumanResources.Employee

---6---
select name from Production.Product
where color = 'Black'

---7---
select name from Production.Product 
where ListPrice = 0.00

---8---
select * from HumanResources.Employee

select * from HumanResources.Employee
where SalariedFlag = 1

---9---

select * from Production.Product 
where StandardCost > 500

---10---
SELECT *
FROM Sales.SalesOrderHeader
WHERE TotalDue < 100;

---11---
SELECT *
FROM Production.Product
WHERE Color = 'Black'
AND ListPrice > 1000;

---12---
SELECT *
FROM Production.Product
WHERE Color = 'Red'
OR Color = 'Silver';

---13---
SELECT *
FROM HumanResources.Employee
WHERE Gender = 'F'
AND MaritalStatus = 'S';

---14---
SELECT *
FROM Production.Product
WHERE (Color = 'Blue' OR StandardCost < 50)
AND ListPrice <> 0;

---15---
SELECT *
FROM Sales.SalesOrderHeader
WHERE OnlineOrderFlag = 1
AND Freight > 50;


---16---
SELECT *
FROM Production.Product
WHERE ListPrice BETWEEN 100 AND 500;

---17---
SELECT *
FROM HumanResources.Employee
WHERE HireDate BETWEEN '2010-01-01' AND '2012-12-31';

---18---
SELECT *
FROM Production.Product
WHERE Color IN ('Red', 'Black', 'White');
---19---
SELECT *
FROM Sales.SalesOrderHeader
WHERE Status IN (1, 3, 5);

---20---
SELECT *
FROM Production.Product
WHERE Weight NOT BETWEEN 10 AND 50;

---21---
SELECT *
FROM Person.Person
WHERE FirstName LIKE 'A%';

SELECT *
FROM Production.Product
WHERE Name LIKE '%Bike%';


SELECT *
FROM Person.Person
WHERE LastName LIKE '%son';

SELECT *
FROM Production.Product
WHERE ProductNumber LIKE 'BK-%';

SELECT *
FROM Person.Person
WHERE FirstName LIKE 'J___';

---NULL---
SELECT *
FROM Production.Product
WHERE Color IS NULL;


SELECT *
FROM Production.Product
WHERE Weight IS NOT NULL;


SELECT *
FROM Person.Person
WHERE MiddleName IS NULL;

SELECT *
FROM Production.Product
WHERE Size IS NULL
AND Weight IS NOT NULL;


SELECT *
FROM Sales.SalesOrderHeader
WHERE SalesPersonID IS NULL;

---ORDER BY AND TOP---

SELECT TOP 10 *
FROM Production.Product
ORDER BY ListPrice DESC;

SELECT *
FROM HumanResources.Employee
ORDER BY HireDate ASC;


SELECT *
FROM Production.Product
ORDER BY Color ASC, ListPrice DESC;


SELECT TOP 5 *
FROM Sales.SalesOrderHeader
ORDER BY TotalDue DESC;


SELECT TOP 15 *
FROM Production.Product
WHERE StandardCost > 0
ORDER BY StandardCost ASC;



---AGGREGATION---

SELECT COUNT(*) AS TotalProducts
FROM Production.Product;

SELECT AVG(ListPrice) AS AvgListPrice
FROM Production.Product;

SELECT MAX(VacationHours) AS MaxVacationHours
FROM HumanResources.Employee;


SELECT MIN(StandardCost) AS MinStandardCost
FROM Production.Product
WHERE StandardCost > 0;


SELECT SUM(TotalDue) AS GrandTotalSales
FROM Sales.SalesOrderHeader;

---GROUP BY---

---Pratice---


select * from Production.product

---1---
select * from Production.product
---2---
select name,productnumber,color 
from Production.Product

---3---

select name as Productname , listprice as retailprice 
from Production.Product

---4---
select  Distinct color 
from Production.Product
---5---
select Distinct Jobtitle 
from HumanResources.Employee

---6---
select name from Production.Product
where color = 'Black'

---7---
select name from Production.Product 
where ListPrice = 0.00

---8---
select * from HumanResources.Employee

select * from HumanResources.Employee
where SalariedFlag = 1

---9---

select * from Production.Product 
where StandardCost > 500

---10---
SELECT *
FROM Sales.SalesOrderHeader
WHERE TotalDue < 100;

---11---
SELECT *
FROM Production.Product
WHERE Color = 'Black'
AND ListPrice >1000 ;
---12---
SELECT *
FROM Production.Product
WHERE color = 'red' or color = 'silver'
---13---
SELECT *
FROM HumanResources.Employee
WHERE Gender = 'm'
and MaritalStatus = 's'
---14---
SElECT *
FROM Production.Product
WHERE (Color = 'blue' or StandardCost < 50 )
AND ListPrice <> 0
---15---
SELECT *
FROM Sales.SalesOrderHeader
WHERE onlineorderflag = 1 
AND freight > 50

---16---
SELECT *
FROM Production.Product
WHERE ListPrice Between 100 and 500

---17---
SELECT *
FROM HumanResources.Employee
WHERE HireDate between '2010-01-01' and '2012-12-31'

---18---
SELECT *
FROM Production.Product
WHERE color  in ('red','black','white')

---19---
SELECT *
FROM Sales.SalesOrderHeader
WHERE Status in (1,3,5)

---20---
SELECT *
FROM Production.Product
WHERE Weight not between 10 and 50 

---21---
SELECT *
FROM Person.Person
WHERE FirstName like 'a%'

---22---
SELECT *
FROM Production.Product
WHERE Name like '%bike%'

---23---
SELECT *
FROM Person.Person
Where LastName like '%son'

---24---
Select *
from Production.Product
where ProductNumber like 'bk-%'

SELECT *
FROM Production.Product
WHERE ProductNumber LIKE 'BK-%';

---25---
select *
from Person.Person
where FirstName like '____j%'

---26---
select *
from Production.Product
where color is not null 

select *
from Production.Product
where color is  null 

---27---
Select * 
from Production.Product
where Weight is not null 

---28---

select *
from Person.Person
where MiddleName is  null

select *
from Person.Person
where MiddleName is not null

---29---
select *
from Production.Product
where size is null and Weight is not null 

---30---
select *
from Sales.SalesOrderHeader
where SalesPersonID is null 

---31---
select top 10 *
from Production.Product
order by ListPrice desc

---32---
select *
from HumanResources.Employee
order by HireDate desc

select *
from HumanResources.Employee
order by HireDate 

---33---
select *
from Production.Product
order by color ,listprice desc

---34---
select top 5 *
from Sales.SalesOrderHeader
order by  TotalDue desc

select top 5 *
from Sales.SalesOrderHeader
order by  TotalDue asc

---35---
select top 15*
from Production.Product
where StandardCost > 0
order by StandardCost

---36---
select name,
listprice,standardcost,
(listprice - standardcost) as Profitmargin
from Production.product

---37---
Select  FirstName +' ' +lastname as Fullname from person.person

Select firstname,lastname ,  FirstName +' ' +lastname as Fullname from person.person

---38---
SELECT 
SalesOrderID,ProductID,UnitPrice * OrderQty AS LineValue
FROM Sales.SalesOrderDetail;     ------q------

---39---
Select businessentityid,year(Hiredate)as Hireyear from HumanResources.Employee  ------q-----

Select businessentityid,year(Hiredate)as Hireyear from HumanResources.Employee 

---40---
select upper(name) as productname 
from Production.Product

---41---
select count(*) as Totalnumer 
from Production.Product

select * from Production.Product
---42---
select avg(listprice)as Average from Production.Product

---43---
select max(vacationhours)as maximumnumberofvacations from humanresources.employee;

---44---

SELECT MIN(StandardCost) AS MinStandardCost
FROM Production.Product
WHERE StandardCost > 0;

---45---

SELECT SUM(TotalDue) AS GrandTotalSales
FROM Sales.SalesOrderHeader;

---46---
select color,count(*) as productcount 
from Production.Product
group by Color

---47---
select ProductLine,avg(listprice)as Averagelistprice
from Production.Product
group by ProductLine

---48---
select jobtitle,count(*)as Totalemployees
from HumanResources.Employee
group by JobTitle

---49---
SELECT ProductID, SUM(OrderQty) AS TotalQuantity
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING SUM(OrderQty) > 1000; ----q----



---50---
SELECT SalesPersonID, SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
GROUP BY SalesPersonID
HAVING SUM(TotalDue) > 1000000; ----q----


---Today---

select * from Production.Product

select * from Person.Person

Select * from HumanResources.Employee

select * from Sales.SalesOrderHeader

select * from sales.SalesOrderDetail



select SalesOrderID,datediff(dy,orderdate,shipdate) as result from Sales.SalesOrderHeader
where datediff(dy,orderdate,shipdate) > 7 

select vacationhours,sickleavehours, (vacationhours+sickleavehours) as Holidays from HumanResources.Employee
where (vacationhours+sickleavehours) =  48




