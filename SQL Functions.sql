USE [16-02-2026 (Table creations task)]
GO

/****** Object:  Table [dbo].[Student details]    Script Date: 19-02-2026 14:32:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Student details](
	[USN] [varchar](15) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Branch] [char](10) NOT NULL,
	[Section] [char](10) NOT NULL,
	[Year] [varchar](15) NOT NULL,
	[Grade] [varchar](50) NOT NULL,
	[TotalPercentage] [tinyint] NOT NULL,
	[Email] [char](100) NOT NULL,
	[Phonenumber] [int] NOT NULL
) ON [PRIMARY]
GO


INSERT INTO [dbo].[Student details]
(USN, Name, Branch, Section, Year, Grade, TotalPercentage, Email, Phonenumber)
VALUES
('1RV21CS001','Aarav Sharma','CSE','A','3rd','A',88,'aarav01@gmail.com',987654321),
('1RV21CS002','Diya Patel','CSE','A','3rd','A+',92,'diya02@gmail.com',912345678),
('1RV21CS003','Rohan Gupta','CSE','B','2nd','B+',81,'rohan03@gmail.com',901234567),
('1RV21CS004','Meera Nair','ISE','A','4th','A',86,'meera04@gmail.com',923456781),
('1RV21CS005','Kiran Kumar','ECE','C','1st','B',74,'kiran05@gmail.com',934567812),
('1RV21CS006','Sneha Reddy','EEE','A','2nd','A',87,'sneha06@gmail.com',945678123),
('1RV21CS007','Aditya Singh','MECH','B','3rd','B+',79,'aditya07@gmail.com',956781234),
('1RV21CS008','Pooja Das','CIVIL','A','4th','A+',91,'pooja08@gmail.com',967812345),
('1RV21CS009','Rahul Verma','CSE','C','1st','B',72,'rahul09@gmail.com',978123456),
('1RV21CS010','Ananya Iyer','ISE','B','2nd','A',85,'ananya10@gmail.com',989234567),

('1RV21CS011','Vikram Rao','ECE','A','3rd','A+',90,'vikram11@gmail.com',901345678),
('1RV21CS012','Nisha Khan','EEE','C','4th','A',88,'nisha12@gmail.com',912456789),
('1RV21CS013','Harsh Jain','MECH','A','2nd','B+',80,'harsh13@gmail.com',923567890),
('1RV21CS014','Kavya Shetty','CSE','B','1st','A',84,'kavya14@gmail.com',934678901),
('1RV21CS015','Manoj Pillai','CIVIL','C','3rd','B',75,'manoj15@gmail.com',945789012),
('1RV21CS016','Ritika Sen','ISE','A','4th','A+',93,'ritika16@gmail.com',956890123),
('1RV21CS017','Arjun Menon','ECE','B','2nd','A',86,'arjun17@gmail.com',967901234),
('1RV21CS018','Priya Kapoor','EEE','A','1st','B+',78,'priya18@gmail.com',978012345),
('1RV21CS019','Sahil Mehta','MECH','C','3rd','B',73,'sahil19@gmail.com',989123456),
('1RV21CS020','Neha Joshi','CSE','A','4th','A+',94,'neha20@gmail.com',901234578),

('1RV21CS021','Amit Kulkarni','ISE','B','2nd','A',85,'amit21@gmail.com',912345679),
('1RV21CS022','Shreya Bose','ECE','A','3rd','A',87,'shreya22@gmail.com',923456780),
('1RV21CS023','Deepak Yadav','EEE','C','1st','B+',77,'deepak23@gmail.com',934567891),
('1RV21CS024','Tanvi Gupta','MECH','B','4th','A',89,'tanvi24@gmail.com',945678902),
('1RV21CS025','Ritesh Pandey','CIVIL','A','2nd','B',74,'ritesh25@gmail.com',956789013),
('1RV21CS026','Ishita Roy','CSE','C','3rd','A+',91,'ishita26@gmail.com',967890124),
('1RV21CS027','Naveen Gowda','ISE','A','1st','B+',79,'naveen27@gmail.com',978901235),
('1RV21CS028','Varun Bhat','ECE','B','2nd','A',83,'varun28@gmail.com',989012346),
('1RV21CS029','Lakshmi Devi','EEE','A','4th','A+',92,'lakshmi29@gmail.com',901123457),
('1RV21CS030','Yash Agarwal','MECH','C','3rd','B',76,'yash30@gmail.com',912234568),

('1RV21CS031','Sanjana Rao','CSE','A','2nd','A',85,'sanjana31@gmail.com',923345679),
('1RV21CS032','Akash Mishra','ISE','B','3rd','B+',81,'akash32@gmail.com',934456780),
('1RV21CS033','Divya Menon','ECE','C','1st','A',84,'divya33@gmail.com',945567891),
('1RV21CS034','Gaurav Shah','EEE','A','4th','A+',90,'gaurav34@gmail.com',956678902),
('1RV21CS035','Preeti Sharma','CIVIL','B','2nd','B+',78,'preeti35@gmail.com',967789013),
('1RV21CS036','Rohit Das','MECH','A','3rd','B',75,'rohit36@gmail.com',978890124),
('1RV21CS037','Aishwarya Hegde','CSE','C','4th','A+',93,'aishwarya37@gmail.com',989901235),
('1RV21CS038','Mohit Arora','ISE','A','1st','B+',77,'mohit38@gmail.com',901012346),
('1RV21CS039','Keerthi Pai','ECE','B','2nd','A',86,'keerthi39@gmail.com',912123457),
('1RV21CS040','Suresh Naik','EEE','C','3rd','B+',80,'suresh40@gmail.com',923234568);


Select * from dbo.[Student details]

---ASCII---
select ASCII('A') as result

select Name, ASCII(Name) as ASciicodeoffirstchar
from dbo.[Student details]

SELECT ASCII('Zebra') AS Result;
SELECT ASCII('Eremika') AS Result;

---CHAR---

select char(64)as result

select char(84)as result

select 'Hello' +char(84)+char(64)+'Man' as Message

SELECT 'Name' + CHAR(9) + 'Age';
---Above char(9) acts as a space ---

Select Name + char(84)+char(90)from dbo.[Student details]

---CHAR INDEX(this function searches for a substring in a string and returns the position)---
---Syntac CHARINDEX ( search_expression , target_expression [, start_location ] )----


Select CHARINDEX('r','Eremika')as IndexvalueofR
---below it cant find in that case it returns as 0 as null value ---
SELECT CHARINDEX('z', 'Paartha');


SELECT CHARINDEX('mer', 'Customer', 4) AS MatchPosition;

SELECT CHARINDEX('a', 'banana', 5);

SELECT CHARINDEX('a', 'banana', 3);

---CONCAT(used to add strings together)---
---syntax = CONCAT(string1, string2, ...., string_n)---

select CONCAT('Eren','Yeager')as Fullname

Select concat('Eren' ,' ' , ' ', 'yeager')as Fullname 

select Name,Branch,  concat (name ,branch) as BranchWithUsn from dbo.[Student details]

select  concat (name ,branch) as BranchWithUsn from dbo.[Student details]

select concat(Usn, ' '  ,Name, ' ' , Email)as studentsPersonalInfo from dbo.[Student details]

---handles null automitaclly by treating it as a empty string ---
SELECT CONCAT('Hello', NULL, 'World');

---Concat with + ---
select  'Eren'+'yeager';

select CONCAT_WS('@','Eren','Yeager')as Fullname
select CONCAT_WS(' ','Eren','Yeager')as Fullname

---Data Length  (returns the number of bytes used to store an expression.)---
---syntax = DATALENGTH ( expression )---

select DATALENGTH('Eremika')	

Select Name,DATALENGTH(Name)as BytesUsedByName
from dbo.[Student details]

---To combine both datalength and concat use below format---
SELECT CONCAT('Storage Used: ', DATALENGTH('Hello'), ' bytes') AS Result;

select * from dbo.[Student details]

select DATALENGTH('    Eremika      ')

select DATALENGTH('Eremika')

---Difference---
---syntax(DIFFERENCE(expression, expression)----
---Compares and gives score form 0-4 based on the given expressions by how similar they are ---

Select Difference('Eremika','Ere')

Select difference('Zyzzeria','z')

SELECT DIFFERENCE('Smith', 'Smyth');

SELECT DIFFERENCE('Car', 'Bike');

Select name,DIFFERENCE(name,'Qwerty')as Similarityscore 
from dbo.[Student details]

---Format---after see again
SELECT FORMAT(123456789, '##-##-#####');

---Left---
---Syntax = LEFT(string, number_of_chars)---
Select left('This is called',5) 

select Email,left(email,5) from dbo.[Student details]

select Email,left(email,50) from dbo.[Student details]

---LEN---
---Syntax = LEN(string)---

select len('Zyzzeria')

select Email,len(email)as LengthOfEmailCharacters from dbo.[Student details]

---Lower---
---Syntax = LOWER(text)---

select lower('QWERTY') as LoweredVersion 

Select Email,lower(email) as EmailsInLowerLetters from dbo.[Student details]

---Ltrim And Rtrim---
--Removes leading spaces from a string 
select LTRIM('      who are you       ') 

select LTRIM('      who are you')   

select RTRIM('      who are you')   

---nchar---
---Returns the value of unicode---

SELECT nCHAR(65) AS NumberCodeToUnicode;

SELECT nCHAR(65555) AS NumberCodeToUnicode;

SELECT DATALENGTH(CHAR(65));
---size = 1 bytes for char---

SELECT DATALENGTH(NCHAR(65));
---size= 2 bytes for nchar---
---Char supports english,numbers,symbols---
---Nchar supports Chinese,japanese,arabic,hindi,emojis,other symbols---

Select char(84)

SELECT NCHAR(20013);

select nchar(23000)

---PatIndex---
---syntax = PATINDEX(%pattern%, string)---
---returns the position of a pattern in a string ----
---the pattern must be surrounded by % % to search in a string or else it returns null---

select * from dbo.[Student details]

select patindex('@','Eremika@gmail.com')

select patindex('%@%','Eremika@gmail.com')

select email,patindex ('[a-d]%',email)from dbo.[Student details]

select USN,name,patindex ('[a-d]%',name)from dbo.[Student details]

select email,patindex ('[]%',email)from dbo.[Student details]


---Substring----
SELECT SUBSTRING('SQL Tutorial', 1, 3) AS ExtractString;

SELECT SUBSTRING('SQL Tutorial', 2, 3) AS ExtractString;

SELECT SUBSTRING('SQL Tutorial', 2, 8) AS ExtractString;

---LEN---
Select len('Eremika') 

select * from dbo.[Student details]

Select len(Name) as TotalcharactersinName from dbo.[Student details]

---Datalength---
---also counts and returns spaces---

select datalength('Eremika')

select datalength('Eremik      a')

select DATALENGTH(Email)as totalbytesinemail from dbo.[Student details]

SELECT 
    Branch,
    SUM(DATALENGTH(Email)) AS totalbytesinemail
FROM dbo.[Student details]
GROUP BY Branch;

SELECT 
    Branch,
    avg(DATALENGTH(Email)) AS averagebytesinemail
FROM dbo.[Student details]
GROUP BY Branch;

---Lower---

select LOWER('EREMIKA')

select lower(name) as Lowercasenames from dbo.[Student details]


---upper---

select Upper('eremika')

select upper(name) as Lowercasenames from dbo.[Student details]

---TRim---

SELECT TRIM('   SQL   ');

SELECT LTRIM('   SQL   ');

SELECT RTRIM('   SQL   ');

---replace---
---Syntax(string,old_string,new_string)---
---works only for string---

select replace ('i love java','java','sql')

---replicate---
---Repeats the sting how many times we specify---

SELECT REPLICATE('SQL Tutorial', 5);

---Reverse(returns the string)---
select reverse('Sql')

---space---
---gives space---
---Syntax-space(number)---
SELECT SPACE(10);

SELECT 'SQL' + SPACE(5) + 'Server';

---str---

SELECT STR(185);

SELECT STR(185.5);

SELECT STR(185.476, 6, 2);

---stuff---
---deletes a part of string and then inserts another part into the sting---
---Delete 3 characters from a string, starting in position 1, and then insert "HTML" in position---
SELECT STUFF('SQL Tutorial', 1, 3, 'HTML');

select * from dbo.[Student details]

select stuff(email,1,4,'****') as ProtectedViewOfEmail 
from dbo.[Student details]

---Math functions---

---abs---
---returns the absolute value of a number---
---syntax = abs(number)---

select ABS(23)

select ABS(-23)

SELECT Abs(-243.5) AS AbsNum;

---Acos--
---gives the arc cosine of a number---

SELECT ACOS(0.25);

select acos(-0.8)

---Asin---
---gives the sin value---

select asin(0.23)

---Atan---
---gives arc tangent of a number---

select atan(23)

select * from dbo.[Student details]

select atan(Phonenumber) from dbo.[Student details]

--atn2---
---gives arc tangent for two values---

select atn2(25,1)

---ceiling---
---Return the smallest integer value that is greater than or equal to a number---

SELECT CEILING(25.75) AS CeilValue;

SELECT CEILING(-25.75) AS CeilValue;

select * from dbo.[Student details]

select ceiling(phonenumber) from dbo.[Student details]

---cos---
---Return the cosine of a number:----

select cos(2)

---cot---
--- gives the cotangent of a number ---

Select cot(2)

Select cot(-2)

select   cot(totalpercentage) from dbo.[Student details]

select  (totalpercentage - 70) ,cot(totalpercentage-70) as valueforcotintotalpercentage from dbo.[Student details]

---Degreees---
---Converts a value in radians to degrees---

select DEGREES(23)

Select degrees(-2)

Select degrees(2)

---exp---
-----a mathematical function that calculates the exponential value of the natural logarithm base e (approximately 2.71828)
--raised to a specified power
---syntax = exp(number)

select exp(1)

select exp(-16)

select exp(100)

---Floor---

SELECT FLOOR(25.75) AS FloorValue;

SELECT FLOOR(25.05) AS FloorValue;

SELECT FLOOR(+5.05) AS FloorValue;

SELECT FLOOR(-5.05) AS FloorValue;

SELECT FLOOR(10.9);

---log---

---max and min ---

select max(phonenumber) from dbo.[Student details]

select min(phonenumber) from dbo.[Student details]

select max(age) as maxage
from (values(21),(25),(19)) as A(age)

Select min(age) as Minage
from (values(23),(233),(45),(12),(81),(65)) as B(age)

---pi---
---gives the value of pi---

select pi();

---Power---
--- syntax = POWER(a, b)---
---Returns the value of a number raised to the power of another number---

select power(2,2)

select power(4,2)

select power(-2,2)

---Radians---
---syntax = RADIANS(number)---
---The RADIANS() function converts a degree value into radians---

select RADIANS(180)

select RADIANS(-18)

select RADIANS(18)

---Rand---
---syntax = RAND(seed)---
---returns a random between 0 - 1 ---

select rand()

select rand(6)

select * from dbo.[Student details]

select rand(TotalPercentage) from dbo.[Student details]

---Round---
--- rounds a number to a specified number of decimal places---
---syntax = ROUND(number, decimals, operation)---

select round (235.415,2)

select round (235.415,1)

select round (235.415,2,1)

---
---sql server date functions---

---Current Timestamp---
---return the current date and time---

select CURRENT_TIMESTAMP

---dateadd---
---Syntax = DATEADD(interval, number, date)---

---adds a time/date  interval to a date and then returns the date---
---syntax = DATEADD(interval,number,date)---
---  	Required. The time/date interval to add. Can be one of the following values:
--year, yyyy, yy = Year
--quarter, qq, q = Quarter
--month, mm, m = month
--dayofyear, dy, y = Day of the year
--day, dd, d = Day
--week, ww, wk = Week
--weekday, dw, w = Weekday
--hour, hh = hour
--minute, mi, n = Minute
--second, ss, s = Second
--millisecond, ms = Millisecond

--number	Required. The number of interval to add to date. Can be positive (to get dates in the future) or negative (to get dates in the past)
--date	Required. The date that will be modified

SELECT DATEADD(year, 1, '2017/08/25') AS DateAdd;

select * from dbo.[Daily Weather Analysis]

select Dateadd(year,2,ObservationDate) as UpdatedDate from dbo.[Daily Weather Analysis]
  
select dateadd(month,1,observationdate) as UpdatedDate from dbo.[Daily Weather Analysis]

---Datediff---


 
