
SELECT TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Sales.Customer' 
  AND COLUMN_NAME = 'PersonID';


SELECT TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Customer'
AND TABLE_SCHEMA = 'Sales'
AND COLUMN_NAME = 'PersonID';

SELECT TABLE_NAME, COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE COLUMN_NAME LIKE '%name%';

SELECT TABLE_NAME, COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE COLUMN_NAME LIKE '%order%' OR COLUMN_NAME LIKE '%id%';

---Assignment 2 ---
select*from person.person;
select * from sales.SalesOrderDetail;	
select*from sales.SalesOrderHeader;
---1.	Display customer full name, SalesOrderID, OrderDate, and TotalDue for all orders.---

select CONCAT_WS(' ', P.FirstName , P.MiddleName , P.LastName) as Fullname ,
Q.SalesOrderID,Q.OrderDate,Q.TotalDue
from Person.Person P
join Sales.Customer C
on P.BusinessEntityID = C.PersonID
Join Sales.SalesOrderHeader Q
on C.CustomerID = Q.CustomerID

---2.	Display customer full name and total number of orders placed---

select * from sales.SalesOrderDetail

Select * from Sales.SalesOrderHeader

Select CONCAT_WS(' ', P.FirstName , P.MiddleName , P.LastName) As FullName,
Count(Z.SalesOrderID) as TotalNumberOfOrders
from Person.Person P
join Sales.Customer C
on P.BusinessEntityID = C.PersonID
Join Sales.SalesOrderHeader Z
on Z.CustomerID = C.CustomerID
Group by P.FirstName , P.MiddleName , P.LastName

---3.	Display customers and their cities along with the total amount they spent---

select * from Sales.SalesOrderDetail
Select * from Sales.SalesOrderHeader
select * from Person.Person

Select CONCAT_WS(' ', P.FirstName , P.MiddleName , P.LastName) As FullName,
A.City,
SUM(Q.TotalDue) as TotalAmountSpent 
From Sales.Customer S
Join sales.SalesOrderHeader Q
On S.CustomerID = Q.CustomerID
Join Person.Person P 
on S.PersonID = P.BusinessEntityID
Join Person.Address A
on Q.BillToAddressID = A.AddressID
Group by P.FirstName,P.MiddleName,P.LastName,A.City


---4.	Show customers who placed orders in 2014 with order details---
Select CONCAT_WS(' ', PP.FirstName , PP.MiddleName , PP.LastName) As FullName,
SOH.*
From Sales.Customer SC
Join sales.SalesOrderHeader SOH
On SC.CustomerID = SOH.CustomerID
Join Person.Person PP
on PP.BusinessEntityID = SC.PersonID
Where Year(OrderDate) = 2014


---5.	Display customers who have never placed any orders---
Select CONCAT_WS(' ', PP.FirstName , PP.MiddleName , PP.LastName) As FullName,
SOH.SalesOrderID
From Sales.Customer SC
left join sales.SalesOrderHeader SOH
on SC.CustomerID = SOH.CustomerID
Join Person.Person PP 
On PP.BusinessEntityID = SC.PersonID
Where SOH.SalesOrderID is NUll -----q----

---6.	Show customer name, order ID, and total quantity of products in each order---
select CONCAT_WS(' ',PP.FirstName , PP.MiddleName , PP.LastName) as CustomerName,
SOD.SalesOrderID,SOD.OrderQty
From Person.Person PP /*person.person*/
Join Sales.Customer SC  /*Sales.customer*/
on SC.PersonID = PP.BusinessEntityID
Join Sales.SalesOrderHeader SOH
on SOH.CustomerID  = SC.CustomerID 
join Sales.SalesOrderDetail SOD
on SOD.SalesOrderID = SOH.SalesOrderID


---7.	Display top 10 customers based on total purchase amount.---
select * from Sales.SalesOrderHeader
select * from Person.Person
select * from sales.Customer

Select top 10 Sales.Customer.CustomerID, concat (Person.Person.FirstName,Person.Person.LastName) as Fullname,
sum(Sales.SalesOrderHeader.TotalDue) as TotalPurchaseAmount
From Sales.SalesOrderHeader 
join Sales.Customer 
on Sales.SalesOrderHeader.CustomerID = Sales.Customer.CustomerID
join Person.Person
on Sales.Customer.PersonID = Person.BusinessEntityID
group by Sales.Customer.CustomerID,Person.FirstName,Person.LastName
order by TotalPurchaseAmount Desc 

---8.	Show customers and the number of different products they purchased.---

select * from sales.Customer
select * from sales.SalesOrderDetail
select * from sales.SalesOrderHeader
select * from Person.Person

SELECT 
CONCAT(Person.Person.FirstName, Person.Person.MiddleName, Person.Person.LastName) AS FullName,
Sales.Customer.CustomerID,
COUNT(DISTINCT Sales.SalesOrderDetail.ProductID) AS DifferentProductsPurchased
FROM Sales.Customer
JOIN Sales.SalesOrderHeader
ON Sales.Customer.CustomerID = Sales.SalesOrderHeader.CustomerID
JOIN Sales.SalesOrderDetail
ON Sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID
JOIN Person.Person
ON Sales.Customer.PersonID = Person.Person.BusinessEntityID
GROUP BY 
Person.Person.FirstName,Person.Person.MiddleName,Person.Person.LastName,Sales.Customer.CustomerID
ORDER BY DifferentProductsPurchased DESC;

---9.	Display customer full name, city, and number of orders placed---

select * from Person.Person
select * from Person.Address
select * from sales.SalesOrderDetail
select * from Person.BusinessEntityAddress


SELECT 
CONCAT(Person.Person.FirstName,' ',Person.Person.MiddleName,' ',Person.Person.LastName) AS FullName,
Person.Address.City,
COUNT(Sales.SalesOrderHeader.SalesOrderID) AS NumberOfOrders
FROM Sales.Customer
JOIN Person.Person
ON Sales.Customer.PersonID = Person.Person.BusinessEntityID
JOIN Sales.SalesOrderHeader
ON Sales.Customer.CustomerID = Sales.SalesOrderHeader.CustomerID
JOIN Person.BusinessEntityAddress
ON Person.Person.BusinessEntityID = Person.BusinessEntityAddress.BusinessEntityID
JOIN Person.Address
ON Person.BusinessEntityAddress.AddressID = Person.Address.AddressID
GROUP BY 
Person.Person.FirstName,
Person.Person.MiddleName,
Person.Person.LastName,
Person.Address.City
ORDER BY NumberOfOrders DESC;


---10.	Identify customers whose total purchase amount exceeds 50,000.---

select * from Sales.Customer
select * from Person.Person
select * from Sales.SalesOrderHeader

SELECT 
CONCAT(Person.Person.FirstName,' ',Person.Person.MiddleName,' ',Person.Person.LastName) AS FullName,
SUM(Sales.SalesOrderHeader.TotalDue) AS TotalPurchaseAmount
FROM Sales.Customer
JOIN Person.Person
ON Sales.Customer.PersonID = Person.Person.BusinessEntityID
JOIN Sales.SalesOrderHeader
ON Sales.Customer.CustomerID = Sales.SalesOrderHeader.CustomerID
GROUP BY 
Person.Person.FirstName,
Person.Person.MiddleName,
Person.Person.LastName
HAVING SUM(Sales.SalesOrderHeader.TotalDue) > 50000
ORDER BY TotalPurchaseAmount DESC;


---Product Analysis ---
---11.	Display product name, order ID, and quantity sold.---

select * from Production.Product ---product name---
select * from sales.SalesOrderDetail


select Production.Product.Name,sales.SalesOrderDetail.OrderQty,Sales.SalesOrderDetail.SalesOrderID
from Production.Product
join Sales.SalesOrderDetail
on Product.ProductID = SalesOrderDetail.ProductID

---12.	Display product name and total quantity sold across all orders.---
select * from Production.Product
select * from Sales.SalesOrderDetail

select Production.Product.Name,sum (Sales.SalesOrderDetail.OrderQty) as TotalQuantiySold
from Production.Product
join Sales.SalesOrderDetail
on Product.ProductID = SalesOrderDetail.ProductID
group by Production.Product.Name

---13.	Identify top 10 products based on total sales revenue.
select * from Production.Product
select * from Sales.SalesOrderDetail
/*select * from Sales.SalesOrderHeader*/

select  top 10 Production.Product.Name,
sum(sales.SalesOrderDetail.OrderQty * Sales.SalesOrderDetail.LineTotal) as TotalsalesRevenue
from Production.Product
join Sales.SalesOrderDetail
on Production.Product.ProductID = Sales.SalesOrderDetail.ProductID
group by Production.Product.Name
order by TotalsalesRevenue Desc

---14.	Display products that have never been sold.---

select * from Production.Product
select * from Sales.SalesOrderDetail

select Production.Product.Name
from Production.Product
left join Sales.SalesOrderDetail
on Production.Product.ProductID = Sales.SalesOrderDetail.ProductID
where Sales.SalesOrderDetail.ProductID is null



---15.	Display product name, number of orders it appears in, and total revenue generated---
select * from Production.Product
select * from Sales.SalesOrderDetail

select Production.Product.Name,
COUNT(Sales.SalesOrderDetail.SalesOrderID) as  NumberOforders,
SUM(Sales.SalesOrderDetail.OrderQty * Sales.SalesOrderDetail.UnitPrice)as Totalrevenue
FROM Production.Product
JOIN Sales.SalesOrderDetail
ON Production.Product.ProductID = Sales.SalesOrderDetail.ProductID
GROUP BY Production.Product.Name;

---16.	Show products with 'Bike' in their name and the total quantity sold.---

select * from Production.Product
where Name = '%Bike%'
select * from Sales.SalesOrderDetail

select Production.Product.name,
sum(Sales.SalesOrderDetail.OrderQty)as TotalQuantitySold
From Production.Product
join Sales.SalesOrderDetail
on Product.ProductID = SalesOrderDetail.ProductID
where Production.Product.Name Like '%Bike%'
group by Production.Product.Name

---17.	Display product name, order date, and quantity sold.---
select * from Production.Product
select * from Sales.SalesOrderDetail
select * from Sales.SalesOrderHeader

select Production.Product.name,Sales.SalesOrderHeader.OrderDate,Sales.SalesOrderDetail.OrderQty
from Production.Product
join Sales.SalesOrderDetail
on Production.Product.ProductID = Sales.SalesOrderDetail.ProductID
Join Sales.SalesOrderHeader
on Sales.SalesOrderDetail.SalesOrderID = Sales.SalesOrderHeader.SalesOrderID


---18.	Show products whose total quantity sold exceeds 100 units.---
select * from Production.Product
select * from Sales.SalesOrderDetail
/*select * from Sales.SalesOrderHeader*/

select Production.Product.Name, Sales.SalesOrderDetail.UnitPrice
from Production.Product
join Sales.SalesOrderDetail
on Product.ProductID = SalesOrderDetail.ProductID
where UnitPrice > 100


select Production.Product.Name,sum(sales.SalesOrderDetail.OrderQty) as TotalQuantitySold
from Production.Product
join Sales.SalesOrderDetail
on Product.ProductID = SalesOrderDetail.ProductID
Group by Production.Product.Name
Having SUM(Sales.SalesOrderDetail.OrderQty)>100


---19.	Display product name and average order quantity---
select * from Production.Product
select * from Sales.SalesOrderDetail

select Production.Product.name,AVG( Sales.SalesOrderDetail.OrderQty) as AverageOrderQuantity
from Production.Product
join Sales.SalesOrderDetail
on  Production.Product.ProductID = Sales.SalesOrderDetail.ProductID
Group by Product.Name

---20.	Identify products whose total revenue exceeds 100,000.---
select * from Production.Product
select * from Sales.SalesOrderDetail
select * from Sales.SalesOrderHeader

select Production.Product.name,
Sum(Sales.SalesOrderDetail.OrderQty * Sales.SalesOrderDetail.UnitPrice) as TotalRevenue
from Production.Product
join Sales.SalesOrderDetail
on Production.Product.ProductID = Sales.SalesOrderDetail.ProductID
Group by Production.Product.Name


select Production.Product.name,Sum(Sales.SalesOrderDetail.OrderQty * Sales.SalesOrderDetail.UnitPrice)as TotalRevenue
from Production.Product
join Sales.SalesOrderDetail
on Production.Product.ProductID = Sales.SalesOrderDetail.ProductID
Group by Production.Product.Name
having Sum(Sales.SalesOrderDetail.OrderQty * Sales.SalesOrderDetail.UnitPrice) > 100000

---Order & Revenue analysis ---
---21.	Display order ID, customer name, and total number of products in each order.---

select * from Person.Person
select * from Sales.SalesOrderDetail
select * from Sales.SalesOrderHeader
/*select * from Production.Product*/
select * from Sales.Customer

/*select Sales.SalesOrderHeader.SalesOrderID, 
concat (Person.Person.FirstName, ' ', Person.Person.MiddleName, ' ',Person.Person.LastName) as CustomerFullName,
Count(Sales.SalesOrderDetail.OrderQty) as Totalnumberofproductsineachorder
from Person.Person
join Sales.SalesOrderHeader
on Person.BusinessEntityID = Sales.SalesOrderHeader.CustomerID
Join Sales.SalesOrderDetail
on Sales.SalesOrderDetail.ProductID = Person.BusinessEntityID
group by Sales.SalesOrderDetail.SalesOrderID*/

SELECT 
Sales.SalesOrderHeader.SalesOrderID,
CONCAT(Person.Person.FirstName,' ',Person.Person.MiddleName,' ',Person.Person.LastName) AS CustomerFullName,
COUNT(Sales.SalesOrderDetail.ProductID) AS TotalNumberOfProductsInEachOrder
FROM Sales.SalesOrderHeader
JOIN Sales.Customer
ON Sales.SalesOrderHeader.CustomerID = Sales.Customer.CustomerID
JOIN Person.Person
ON Sales.Customer.PersonID = Person.Person.BusinessEntityID
JOIN Sales.SalesOrderDetail
ON Sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID
GROUP BY 
Sales.SalesOrderHeader.SalesOrderID,
Person.Person.FirstName,
Person.Person.MiddleName,
Person.Person.LastName;

---22.	Show orders where the total order amount exceeds 10,000.---
select * from Sales.SalesOrderHeader
where TotalDue > 10000

select Sales.SalesOrderHeader.SalesOrderID,Sales.SalesOrderHeader.CustomerID,TotalDue
from Sales.SalesOrderHeader
where TotalDue > 10000

---23.	Display total revenue generated per year.---
select * from Sales.SalesOrderHeader

select Year(Sales.SalesOrderHeader.OrderDate)as Orderyear,
Sum(Sales.SalesOrderHeader.TotalDue)as totalRevenue 
from Sales.SalesOrderHeader
group by YEAR(Sales.SalesOrderHeader.OrderDate)

---24.	Display monthly order count along with total sales revenue.---
select * from Sales.SalesOrderHeader

select 
month(Sales.SalesOrderHeader.OrderDate)as MonthlyOrder,
Count(Sales.SalesOrderHeader.SalesOrderID) as TotalOrdersInMonth,
SUM(Sales.SalesOrderHeader.TotalDue) AS TotalRevenue
from Sales.SalesOrderHeader
group by MONTH(Sales.SalesOrderHeader.OrderDate)
Order by MonthlyOrder---q---

---25.	Identify orders containing more than 5 different products.---
select * from Sales.SalesOrderHeader
select * from Sales.SalesOrderDetail

select Sales.SalesOrderDetail.SalesOrderID
from Sales.SalesOrderDetail
Group by SalesOrderID
Having Count(ProductID) > 5---q---

---26.	Display order ID, customer name, and number of products purchased in that order.---
select * from Sales.SalesOrderHeader
select * from Sales.SalesOrderDetail
select * from Person.Person
select * from Sales.Customer

select Sales.SalesOrderDetail.SalesOrderDetailID,Sales.SalesOrderDetail.SalesOrderID,
Concat(Person.Person.FirstName, ' ' ,Person.Person.MiddleName, ' ' ,Person.Person.LastName)as CustomerName
From Sales.SalesOrderDetail
join Sales.SalesOrderHeader
on Sales.SalesOrderDetail.SalesOrderID = Sales.SalesOrderHeader.SalesOrderID
Join Sales.Customer
on sales.SalesOrderHeader.CustomerID = Sales.Customer.CustomerID
join Person.Person
on Sales.Customer.PersonID = Person.BusinessEntityID

SELECT 
Sales.SalesOrderHeader.SalesOrderID,
CONCAT(Person.Person.FirstName,' ',Person.Person.MiddleName,' ',Person.Person.LastName) AS CustomerName,
COUNT(Sales.SalesOrderDetail.ProductID) AS NumberOfProducts
FROM Sales.SalesOrderHeader
JOIN Sales.Customer
ON Sales.SalesOrderHeader.CustomerID = Sales.Customer.CustomerID
JOIN Person.Person
ON Sales.Customer.PersonID = Person.Person.BusinessEntityID
JOIN Sales.SalesOrderDetail
ON Sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID
GROUP BY 
Sales.SalesOrderHeader.SalesOrderID,
Person.Person.FirstName,
Person.Person.MiddleName,
Person.Person.LastName;

---27.	Show orders where the total quantity of products exceeds 20.---
select * from Sales.SalesOrderDetail

SELECT Sales.SalesOrderDetail.SalesOrderID
FROM Sales.SalesOrderDetail
WHERE OrderQty > 20

select SalesOrderID 
from Sales.SalesOrderDetail
Group by SalesOrderID
having sum(OrderQty) > 20

---28.	Display top 10 highest value orders with customer names.---

select * from Sales.SalesOrderHeader
select * from Person.Person
select * from Sales.Customer

select  top 10 Sales.SalesOrderHeader.SalesOrderID,Sales.SalesOrderHeader.TotalDue,
Concat (Person.Person.FirstName, ' ', Person.Person.MiddleName, ' ',Person.Person.LastName)as CustomerFullName 
from Person.Person
Join Sales.Customer
on Person.BusinessEntityID = Sales.Customer.CustomerID
join Sales.SalesOrderHeader
on Sales.Customer.CustomerID = Sales.SalesOrderHeader.CustomerID
group by Sales.SalesOrderHeader.SalesOrderID,Person.FirstName,Person.MiddleName,Person.LastName,Sales.SalesOrderHeader.TotalDue
order by Sales.SalesOrderHeader.TotalDue desc

select  top 10 Sales.SalesOrderHeader.SalesOrderID,Sales.SalesOrderHeader.TotalDue,
Concat (Person.Person.FirstName, ' ', Person.Person.MiddleName, ' ',Person.Person.LastName)as CustomerFullName 
from Person.Person
Join Sales.Customer
on Person.BusinessEntityID = Sales.Customer.PersonID
join Sales.SalesOrderHeader
on Sales.Customer.CustomerID = Sales.SalesOrderHeader.CustomerID
order by Sales.SalesOrderHeader.TotalDue desc

---29.	Show average order value per customer.---
select * from Person.Person
select * from Sales.SalesOrderDetail
Select * from Sales.SalesOrderHeader

select Concat (Person.Person.FirstName,' ' ,Person.Person.MiddleName, ' ' , Person.Person.LastName)As CustomerName,
 avg (Sales.SalesOrderHeader.TotalDue) as AvergaeOrderValurPerCustomer
 From Sales.SalesOrderDetail
 join Sales.SalesOrderHeader
 on Sales.SalesOrderDetail.SalesOrderID = Sales.SalesOrderHeader.SalesOrderID
 Join Person.Person
 on Sales.SalesOrderHeader.CustomerID = Person.BusinessEntityID
 group by Person.FirstName,Person.MiddleName,Person.LastName

SELECT 
CONCAT(Person.Person.FirstName,' ',Person.Person.MiddleName,' ',Person.Person.LastName) AS CustomerName,
AVG(Sales.SalesOrderHeader.TotalDue) AS AverageOrderValuePerCustomer
FROM Sales.SalesOrderHeader
JOIN Sales.Customer
ON Sales.SalesOrderHeader.CustomerID = Sales.Customer.CustomerID
JOIN Person.Person
ON Sales.Customer.PersonID = Person.Person.BusinessEntityID
GROUP BY 
Person.Person.FirstName,
Person.Person.MiddleName,
Person.Person.LastName;


---30.	Identify customers whose average order value exceeds 2000---
select * from Sales.SalesOrderHeader
select * from Sales.Customer
select * from Person.Person

select CONCAT_WS(' ' , Person.Person.FirstName,Person.Person.MiddleName,Person.Person.LastName) as CustomerName,
AVG(Sales.SalesOrderHeader.TotalDue) as AverageOrderValue
from Sales.SalesOrderHeader
join Sales.Customer
on Sales.SalesOrderHeader.CustomerID = Sales.Customer.CustomerID
Join Person.Person
on Sales.Customer.PersonID = Person.Person.BusinessEntityID
group by Person.FirstName,Person.MiddleName,Person.LastName
Having AVG(Sales.SalesOrderHeader.TotalDue) > 2000


---Employees & Department Reporting---
---31.	Display employee full name, job title, and department name.---
select * from HumanResources.Employee
Select * from Person.Person
select * from HumanResources.EmployeeDepartmentHistory
select * from HumanResources.Department

Select concat(Person.Person.FirstName, ' ',Person.Person.MiddleName,' ' ,Person.Person.LastName)as EmployeeFullName,
HumanResources.Employee.JobTitle,HumanResources.Department.Name
From HumanResources.Employee
join Person.Person
on HumanResources.Employee.BusinessEntityID = Person.BusinessEntityID
join  HumanResources.Department
on HumanResources.Department.DepartmentID = Person.BusinessEntityID
join HumanResources.EmployeeDepartmentHistory
on HumanResources.EmployeeDepartmentHistory.DepartmentID = HumanResources.Department.DepartmentID

SELECT CONCAT(Person.Person.FirstName,' ',Person.Person.MiddleName,' ',Person.Person.LastName) AS EmployeeFullName,
HumanResources.Employee.JobTitle,
HumanResources.Department.Name AS DepartmentName
FROM HumanResources.Employee
JOIN Person.Person
ON HumanResources.Employee.BusinessEntityID = Person.Person.BusinessEntityID
JOIN HumanResources.EmployeeDepartmentHistory
ON HumanResources.Employee.BusinessEntityID = HumanResources.EmployeeDepartmentHistory.BusinessEntityID
JOIN HumanResources.Department
ON HumanResources.EmployeeDepartmentHistory.DepartmentID = HumanResources.Department.DepartmentID;

---32.	Show department name and number of employees in each department.---
select * from HumanResources.Department
Select * from HumanResources.EmployeeDepartmentHistory

select HumanResources.Department.Name,
COUNT(*) as TotalNumberOfEmployees
from HumanResources.Department
join HumanResources.EmployeeDepartmentHistory
on HumanResources.Department.DepartmentID = HumanResources.EmployeeDepartmentHistory.DepartmentID
group by HumanResources.Department.Name

SELECT HumanResources.Department.Name, ---null(for active )---
COUNT(*) AS TotalNumberOfEmployees
FROM HumanResources.Department
JOIN HumanResources.EmployeeDepartmentHistory
ON HumanResources.Department.DepartmentID = HumanResources.EmployeeDepartmentHistory.DepartmentID
WHERE HumanResources.EmployeeDepartmentHistory.EndDate IS NULL
GROUP BY HumanResources.Department.Name;

---33.	Identify departments with more than 10 employees.---
select * from HumanResources.Department
Select * from HumanResources.EmployeeDepartmentHistory


select HumanResources.Department.Name As DepertmentName,
Count(HumanResources.EmployeeDepartmentHistory.BusinessEntityID)as NumberOfEmployees
from HumanResources.Department
join HumanResources.EmployeeDepartmentHistory
on HumanResources.Department.DepartmentID = HumanResources.EmployeeDepartmentHistory.DepartmentID
where HumanResources.EmployeeDepartmentHistory.EndDate is  null
group by HumanResources.Department.Name
Having COUNT(HumanResources.EmployeeDepartmentHistory.BusinessEntityID) > 10

select HumanResources.Department.Name As DepertmentName,
Count(HumanResources.EmployeeDepartmentHistory.BusinessEntityID)as NumberOfEmployees
from HumanResources.Department
join HumanResources.EmployeeDepartmentHistory---not active also---
on HumanResources.Department.DepartmentID = HumanResources.EmployeeDepartmentHistory.DepartmentID
group by HumanResources.Department.Name
Having COUNT(HumanResources.EmployeeDepartmentHistory.BusinessEntityID) > 10

---34.	Display employees hired after 2012 with their department names.---
select * from HumanResources.Employee
Select * from Person.Person
Select * from HumanResources.EmployeeDepartmentHistory
select * from HumanResources.Department

Select concat(Person.Person.FirstName, ' ',Person.Person.MiddleName,' ' ,Person.Person.LastName)as EmployeeFullName,
HumanResources.Department.Name as DepartmentName,HumanResources.EmployeeDepartmentHistory.StartDate
from Person.Person
join HumanResources.Employee
on Person.BusinessEntityID = HumanResources.Employee.BusinessEntityID
join HumanResources.EmployeeDepartmentHistory 
on HumanResources.EmployeeDepartmentHistory.BusinessEntityID = Person.BusinessEntityID
join HumanResources.Department
on HumanResources.Department.DepartmentID = HumanResources.EmployeeDepartmentHistory.DepartmentID
where HumanResources.Employee.HireDate> '2012-12-31'

---35.	Show employees working in the Sales department.---
select * from HumanResources.Employee
Select * from Person.Person
Select * from HumanResources.EmployeeDepartmentHistory
select * from HumanResources.Department

select HumanResources.Department.Name,
COUNT(*) as TotalNumberOfEmployees
from HumanResources.Department
join HumanResources.EmployeeDepartmentHistory
on HumanResources.Department.DepartmentID = HumanResources.EmployeeDepartmentHistory.DepartmentID
Where HumanResources.Department.Name = 'Sales'
group by HumanResources.Department.Name


---36.	Display employee name and number of years they have worked in the company.---

select * from HumanResources.Employee
select * from Person.Person

select  concat_ws ( ' ' ,Person.Person.FirstName,Person.Person.MiddleName,Person.Person.LastName) as EmployeeName,
DATEDIFF(YEAR, HumanResources.Employee.HireDate, GETDATE()) AS TotalYearsWorked
from Person.Person
join HumanResources.Employee
on Person.BusinessEntityID = HumanResources.Employee.BusinessEntityID


---37.	Show department names and average employee tenure.---
select * from HumanResources.Employee
select * from HumanResources.EmployeeDepartmentHistory
select * from HumanResources.Department


SELECT HumanResources.Department.Name AS DepartmentName,
AVG(DATEDIFF(YEAR, HumanResources.Employee.HireDate, GETDATE())) AS AverageEmployeeTenure
FROM HumanResources.Employee
JOIN HumanResources.EmployeeDepartmentHistory
ON HumanResources.Employee.BusinessEntityID = HumanResources.EmployeeDepartmentHistory.BusinessEntityID
JOIN HumanResources.Department
ON HumanResources.EmployeeDepartmentHistory.DepartmentID = HumanResources.Department.DepartmentID
WHERE HumanResources.EmployeeDepartmentHistory.EndDate IS NULL
GROUP BY HumanResources.Department.Name;

---38.	Identify departments with no employees assigned.---

select * from HumanResources.Department
select * from HumanResources.EmployeeDepartmentHistory

select HumanResources.Department.Name as DepartmentName
from HumanResources.Department
join HumanResources.EmployeeDepartmentHistory
on HumanResources.EmployeeDepartmentHistory.DepartmentID = HumanResources.Department.DepartmentID
where HumanResources.EmployeeDepartmentHistory.BusinessEntityID is null

select HumanResources.Department.Name as DepartmentName
from HumanResources.Department
left join HumanResources.EmployeeDepartmentHistory
on HumanResources.EmployeeDepartmentHistory.DepartmentID = HumanResources.Department.DepartmentID
where HumanResources.EmployeeDepartmentHistory.BusinessEntityID is null

---39.	Display employees and their department names ordered by hire date.---
select * from HumanResources.Employee
select * from Person.Person
select * from HumanResources.EmployeeDepartmentHistory
select * from HumanResources.Department

SELECT 
CONCAT(Person.Person.FirstName,' ',Person.Person.MiddleName,' ',Person.Person.LastName) AS EmployeeName,
HumanResources.Department.Name AS DepartmentName,
HumanResources.Employee.HireDate
FROM HumanResources.Employee
JOIN Person.Person
ON HumanResources.Employee.BusinessEntityID = Person.Person.BusinessEntityID
JOIN HumanResources.EmployeeDepartmentHistory
ON HumanResources.Employee.BusinessEntityID = HumanResources.EmployeeDepartmentHistory.BusinessEntityID
JOIN HumanResources.Department
ON HumanResources.EmployeeDepartmentHistory.DepartmentID = HumanResources.Department.DepartmentID
WHERE HumanResources.EmployeeDepartmentHistory.EndDate IS NULL
ORDER BY HumanResources.Employee.HireDate;

---40.	Show top 5 departments with the highest number of employees.---
SELECT TOP 5
HumanResources.Department.Name AS DepartmentName,
COUNT(HumanResources.EmployeeDepartmentHistory.BusinessEntityID) AS NumberOfEmployees
FROM HumanResources.Department
JOIN HumanResources.EmployeeDepartmentHistory
ON HumanResources.Department.DepartmentID = HumanResources.EmployeeDepartmentHistory.DepartmentID
WHERE HumanResources.EmployeeDepartmentHistory.EndDate IS NULL
GROUP BY HumanResources.Department.Name
ORDER BY NumberOfEmployees DESC;

---41.	Display customer name, product name, order date, and quantity purchased.---
select * from  Sales.SalesOrderHeader
select * from Sales.SalesOrderDetail
select * from Sales.Customer
select * from Person.Person
select * from Production.Product

select CONCAT_WS (' ' ,Person.Person.FirstName,Person.Person.MiddleName,Person.Person.LastName)as Customername,
Production.Product.Name as ProductName,
Sales.SalesOrderHeader.OrderDate as OrderDate,
sales.SalesOrderDetail.OrderQty as OrderQuantity
from Sales.SalesOrderHeader
join Sales.SalesOrderDetail
on Sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID
Join Sales.Customer
on Sales.SalesOrderHeader.CustomerID = Sales.Customer.CustomerID
join Person.Person
on Sales.Customer.PersonID = Person.BusinessEntityID
join Production.Product
on Sales.SalesOrderDetail.ProductID = Production.Product.ProductID

---42.	Identify customers who purchased more than 3 different products in a single order.---
select * from Sales.SalesOrderDetail
select * from Sales.SalesOrderHeader
select * from Sales.Customer
select * from Person.Person


---q---
SELECT 
    Production.Product.Name AS ProductName,
    SUM(Sales.SalesOrderDetail.OrderQty) AS TotalQuantitySold,
    SUM(Sales.SalesOrderDetail.LineTotal) AS TotalRevenue
FROM 
    Production.Product
INNER JOIN 
    Sales.SalesOrderDetail
ON 
    Production.Product.ProductID = Sales.SalesOrderDetail.ProductID
GROUP BY 
    Production.Product.Name
ORDER BY 
    TotalRevenue DESC;


---q---
SELECT DISTINCT
    Sales.Customer.CustomerID,
    Person.Person.FirstName,
    Person.Person.LastName
FROM 
    Sales.Customer
INNER JOIN 
    Sales.SalesOrderHeader
ON 
    Sales.Customer.CustomerID = Sales.SalesOrderHeader.CustomerID
INNER JOIN 
    Sales.SalesOrderDetail
ON 
    Sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID
INNER JOIN 
    Production.Product
ON 
    Sales.SalesOrderDetail.ProductID = Production.Product.ProductID
INNER JOIN 
    Person.Person
ON 
    Sales.Customer.PersonID = Person.Person.BusinessEntityID
WHERE 
    Production.Product.ListPrice = 
    (
        SELECT MAX(Production.Product.ListPrice)
        FROM Production.Product
    );

---q---
SELECT 
    Person.Address.City,
    SUM(Sales.SalesOrderHeader.TotalDue) AS TotalRevenue
FROM 
    Sales.SalesOrderHeader
INNER JOIN 
    Person.Address
ON 
    Sales.SalesOrderHeader.BillToAddressID = Person.Address.AddressID
GROUP BY 
    Person.Address.City
ORDER BY 
    TotalRevenue DESC;

---q---
SELECT 
    Sales.Customer.CustomerID,
    Person.Person.FirstName,
    Person.Person.LastName,
    MAX(Sales.SalesOrderHeader.OrderDate) AS MostRecentOrderDate
FROM 
    Sales.Customer
INNER JOIN 
    Person.Person
ON 
    Sales.Customer.PersonID = Person.Person.BusinessEntityID
INNER JOIN 
    Sales.SalesOrderHeader
ON 
    Sales.Customer.CustomerID = Sales.SalesOrderHeader.CustomerID
GROUP BY 
    Sales.Customer.CustomerID,
    Person.Person.FirstName,
    Person.Person.LastName
ORDER BY 
    MostRecentOrderDate DESC;

---q---
SELECT 
    Production.Product.Name AS ProductName,
    SUM(Sales.SalesOrderDetail.LineTotal) AS TotalRevenue
FROM 
    Production.Product
INNER JOIN 
    Sales.SalesOrderDetail
ON 
    Production.Product.ProductID = Sales.SalesOrderDetail.ProductID
GROUP BY 
    Production.Product.Name
HAVING 
    SUM(Sales.SalesOrderDetail.LineTotal) >
    (
        SELECT 
            AVG(ProductRevenue.TotalRevenue)
        FROM
        (
            SELECT 
                SUM(Sales.SalesOrderDetail.LineTotal) AS TotalRevenue
            FROM 
                Sales.SalesOrderDetail
            GROUP BY 
                Sales.SalesOrderDetail.ProductID
        ) AS ProductRevenue
    );

---q---
SELECT TOP 5
    Person.Address.City,
    SUM(Sales.SalesOrderHeader.TotalDue) AS TotalRevenue
FROM 
    Sales.SalesOrderHeader
INNER JOIN 
    Person.Address
ON 
    Sales.SalesOrderHeader.BillToAddressID = Person.Address.AddressID
GROUP BY 
    Person.Address.City
ORDER BY 
    TotalRevenue DESC;


---q---
SELECT 
    Sales.Customer.CustomerID,
    Person.Person.FirstName,
    Person.Person.LastName,
    COUNT(DISTINCT Production.ProductSubcategory.ProductCategoryID) AS CategoryCount
FROM 
    Sales.Customer
INNER JOIN 
    Person.Person
ON 
    Sales.Customer.PersonID = Person.Person.BusinessEntityID
INNER JOIN 
    Sales.SalesOrderHeader
ON 
    Sales.Customer.CustomerID = Sales.SalesOrderHeader.CustomerID
INNER JOIN 
    Sales.SalesOrderDetail
ON 
    Sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID
INNER JOIN 
    Production.Product
ON 
    Sales.SalesOrderDetail.ProductID = Production.Product.ProductID
INNER JOIN 
    Production.ProductSubcategory
ON 
    Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductSubcategoryID
GROUP BY 
    Sales.Customer.CustomerID,
    Person.Person.FirstName,
    Person.Person.LastName
HAVING 
    COUNT(DISTINCT Production.ProductSubcategory.ProductCategoryID) > 5;

---q---
SELECT 
    Sales.Customer.CustomerID,
    Person.Person.FirstName,
    Person.Person.LastName
FROM 
    Sales.Customer
INNER JOIN 
    Person.Person
ON 
    Sales.Customer.PersonID = Person.Person.BusinessEntityID
INNER JOIN 
    Sales.SalesOrderHeader
ON 
    Sales.Customer.CustomerID = Sales.SalesOrderHeader.CustomerID
GROUP BY 
    Sales.Customer.CustomerID,
    Person.Person.FirstName,
    Person.Person.LastName
HAVING 
    COUNT(DISTINCT YEAR(Sales.SalesOrderHeader.OrderDate)) =
    (
        SELECT 
            COUNT(DISTINCT YEAR(Sales.SalesOrderHeader.OrderDate))
        FROM 
            Sales.SalesOrderHeader
    );
