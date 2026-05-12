USE [16-02-2026 (Table creations task)]
GO

/****** Object:  Table [dbo].[ChargingStationsData]    Script Date: 17-02-2026 10:47:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ChargingStationsData](
	[SessionID] [int] NOT NULL,
	[StationName] [varchar](120) NOT NULL,
	[CityArea] [varchar](80) NOT NULL,
	[VehicleType] [char](15) NOT NULL,
	[BatterystartPercentage] [tinyint] NOT NULL,
	[BatteryEndPercentage] [tinyint] NOT NULL,
	[EnergyConsumedKWH] [decimal](8, 2) NOT NULL,
	[ChargingDurationminutes] [smallint] NOT NULL,
	[ChargistCost] [decimal](10, 2) NOT NULL,
	[FastChargingUsed] [bit] NOT NULL,
	[ChargeDate] [date] NOT NULL
) ON [PRIMARY]
GO

Select * from dbo.ChargingStationsData;



USE [16-02-2026 (Table creations task)];
GO

INSERT INTO dbo.ChargingStationsData
(SessionID, StationName, CityArea, VehicleType,
 BatterystartPercentage, BatteryEndPercentage,
 EnergyConsumedKWH, ChargingDurationminutes,
 ChargistCost, FastChargingUsed, ChargeDate)
VALUES
(3001,'ChargeGrid Hub','Whitefield','Electric Car',21,86,31.40,54,505.00,1,'2026-02-22'),
(3002,'VoltPoint Station','Indiranagar','Electric Bike',42,94,4.20,36,108.00,0,'2026-02-22'),
(3003,'GreenCharge Zone','Electronic City','E-Scooter',37,90,3.00,30,82.00,0,'2026-02-23'),
(3004,'ElectroFast','Koramangala','Electric Car',11,77,40.10,68,640.00,1,'2026-02-23'),
(3005,'SparkCharge','BTM Layout','Electric Bike',33,88,4.60,39,120.00,0,'2026-02-23'),
(3006,'EV Power Hub','Marathahalli','Electric Car',28,91,29.70,50,480.00,1,'2026-02-24'),
(3007,'ChargeGrid Hub','Whitefield','E-Scooter',49,98,2.80,26,75.00,0,'2026-02-24'),
(3008,'VoltPoint Station','Indiranagar','Electric Car',17,82,35.60,60,565.00,1,'2026-02-24'),
(3009,'GreenCharge Zone','Electronic City','Electric Bike',45,96,4.40,37,115.00,0,'2026-02-25'),
(3010,'ElectroFast','Koramangala','Electric Car',13,79,38.20,63,605.00,1,'2026-02-25'),

(3011,'SparkCharge','BTM Layout','E-Scooter',51,100,2.65,25,72.00,0,'2026-02-25'),
(3012,'EV Power Hub','Marathahalli','Electric Bike',39,93,4.15,34,104.00,0,'2026-02-26'),
(3013,'ChargeGrid Hub','Whitefield','Electric Car',23,87,30.80,52,495.00,1,'2026-02-26'),
(3014,'VoltPoint Station','Indiranagar','Electric Car',19,84,33.90,57,535.00,1,'2026-02-26'),
(3015,'GreenCharge Zone','Electronic City','E-Scooter',44,92,2.95,29,80.00,0,'2026-02-27'),
(3016,'ElectroFast','Koramangala','Electric Car',8,73,42.00,72,660.00,1,'2026-02-27'),
(3017,'SparkCharge','BTM Layout','Electric Bike',31,86,4.05,35,102.00,0,'2026-02-27'),
(3018,'EV Power Hub','Marathahalli','Electric Car',26,90,28.50,48,455.00,1,'2026-02-28'),
(3019,'ChargeGrid Hub','Whitefield','Electric Bike',47,97,4.70,38,122.00,0,'2026-02-28'),
(3020,'VoltPoint Station','Indiranagar','E-Scooter',52,99,2.60,24,70.00,0,'2026-02-28'),

(3021,'GreenCharge Zone','Electronic City','Electric Car',20,85,32.90,55,520.00,1,'2026-03-01'),
(3022,'ElectroFast','Koramangala','Electric Car',14,78,37.40,62,595.00,1,'2026-03-01'),
(3023,'SparkCharge','BTM Layout','Electric Bike',36,91,4.25,36,110.00,0,'2026-03-01'),
(3024,'EV Power Hub','Marathahalli','E-Scooter',41,89,3.10,31,86.00,0,'2026-03-02'),
(3025,'ChargeGrid Hub','Whitefield','Electric Car',24,88,31.60,53,505.00,1,'2026-03-02'),
(3026,'VoltPoint Station','Indiranagar','Electric Bike',46,98,4.80,40,130.00,0,'2026-03-02'),
(3027,'GreenCharge Zone','Electronic City','Electric Car',18,83,34.20,58,545.00,1,'2026-03-03'),
(3028,'ElectroFast','Koramangala','E-Scooter',55,100,2.75,27,74.00,0,'2026-03-03'),
(3029,'SparkCharge','BTM Layout','Electric Car',29,92,30.10,51,485.00,1,'2026-03-03'),
(3030,'EV Power Hub','Marathahalli','Electric Bike',34,90,4.30,37,112.00,0,'2026-03-04'),

(3031,'ChargeGrid Hub','Whitefield','Electric Car',16,81,36.80,61,580.00,1,'2026-03-04'),
(3032,'VoltPoint Station','Indiranagar','E-Scooter',48,95,3.00,28,83.00,0,'2026-03-04'),
(3033,'GreenCharge Zone','Electronic City','Electric Bike',40,94,4.45,38,118.00,0,'2026-03-05'),
(3034,'ElectroFast','Koramangala','Electric Car',9,75,41.50,69,650.00,1,'2026-03-05'),
(3035,'SparkCharge','BTM Layout','Electric Car',27,89,29.30,49,470.00,1,'2026-03-05'),
(3036,'EV Power Hub','Marathahalli','E-Scooter',53,100,2.55,23,69.00,0,'2026-03-06'),
(3037,'ChargeGrid Hub','Whitefield','Electric Bike',43,96,4.65,39,121.00,0,'2026-03-06'),
(3038,'VoltPoint Station','Indiranagar','Electric Car',22,86,32.70,54,515.00,1,'2026-03-06'),
(3039,'GreenCharge Zone','Electronic City','Electric Car',15,80,35.10,59,560.00,1,'2026-03-07'),
(3040,'ElectroFast','Koramangala','Electric Bike',37,92,4.35,36,109.00,0,'2026-03-07'),

(3041,'SparkCharge','BTM Layout','E-Scooter',45,97,2.85,27,76.00,0,'2026-03-07'),
(3042,'EV Power Hub','Marathahalli','Electric Car',30,93,28.90,50,460.00,1,'2026-03-08'),
(3043,'ChargeGrid Hub','Whitefield','Electric Car',19,84,34.80,58,550.00,1,'2026-03-08'),
(3044,'VoltPoint Station','Indiranagar','Electric Bike',41,95,4.50,37,116.00,0,'2026-03-08'),
(3045,'GreenCharge Zone','Electronic City','E-Scooter',50,99,2.70,25,73.00,0,'2026-03-09'),
(3046,'ElectroFast','Koramangala','Electric Car',12,76,39.60,65,620.00,1,'2026-03-09'),
(3047,'SparkCharge','BTM Layout','Electric Bike',35,90,4.10,35,105.00,0,'2026-03-09'),
(3048,'EV Power Hub','Marathahalli','Electric Car',26,88,30.50,52,495.00,1,'2026-03-10'),
(3049,'ChargeGrid Hub','Whitefield','E-Scooter',47,96,2.95,29,81.00,0,'2026-03-10'),
(3050,'VoltPoint Station','Indiranagar','Electric Car',18,82,36.40,60,570.00,1,'2026-03-10'),

(3051,'GreenCharge Zone','Electronic City','Electric Bike',44,97,4.55,38,119.00,0,'2026-03-11'),
(3052,'ElectroFast','Koramangala','Electric Car',10,74,42.30,71,665.00,1,'2026-03-11'),
(3053,'SparkCharge','BTM Layout','E-Scooter',52,100,2.60,24,71.00,0,'2026-03-11');






Select * from Dbo.ChargingStationsData;

Select StationName,Cityarea from dbo.ChargingStationsData;

Select * from dbo.ChargingStationsData
where BatterystartPercentage>45;

Select * from dbo.ChargingStationsData
where Batteryendpercentage = 100 And ChargistCost>200;

select * from dbo.ChargingStationsData
where StationName = 'rajajinagar-02' or StationName= 'whitefield';

select * from dbo.ChargingStationsData
where StationName = 'rajajinagar-02' or CityArea	= 'whitefield';

select * from dbo.ChargingStationsData
where not VehicleType = 'bike';

select * from dbo.ChargingStationsData
order by ChargistCost;

select * from dbo.ChargingStationsData
order by ChargistCost Desc;

select distinct  chargistcost from dbo.ChargingStationsData;

Select top 2  chargedate from  dbo.ChargingStationsData;

select top 50 percent* from dbo.ChargingStationsData order by SESSIONID Desc;


select * from dbo.ChargingStationsData  where BatteryEndPercentage between 50 and 100 ;

Select * from dbo.ChargingStationsData where StationName between 'r' and 'z';

Select *  from dbo.ChargingStationsData where BatteryEndPercentage in (100,90);

Select * from dbo.ChargingStationsData where stationname like 'r%2%';

Select * from dbo.ChargingStationsData where stationname like 'g%e%';

Select * from dbo.ChargingStationsData where stationname like '%r%';

select VehicleType,chargistcost, chargistcost * 12 as totalcostinyear from dbo.ChargingStationsData;

select Avg(chargistcost)as Averagecost from dbo.ChargingStationsData;

select max(chargistcost)as Maximumcost from dbo.ChargingStationsData;

select min(chargistcost)as minimumcost from dbo.ChargingStationsData;


---distinct---
select distinct stationname from dbo.ChargingStationsData;

select distinct Cityarea from dbo.ChargingStationsData;  

Select distinct Vehicletype from dbo.ChargingStationsData;


---1---
Select *from dbo.ChargingStationsData;

---2---
select stationname,cityarea,chargistcost from dbo.ChargingStationsData;

---3---
select * from dbo.ChargingStationsData where FastChargingUsed=1;

---4---
select * from dbo.ChargingStationsData where BatterystartPercentage <20;

---5---
select * from dbo.ChargingStationsData where chargedate>'2026-01-01';

---6---
select *from dbo.ChargingStationsData ORDER BY ChargistCost desc;

---7---
select top 5 *from dbo.ChargingStationsData  order by ChargistCost desc;

---8---
select *from dbo.ChargingStationsData where FastChargingUsed=1 and ChargingDurationminutes<60;

---9---
select *from dbo.ChargingStationsData where VehicleType='Electric car';

---10---
select *from dbo.ChargingStationsData where Cityarea in('Whitefield','Btm layout','Rajajinagar');

---11---
Select * from dbo.ChargingStationsData where EnergyConsumedKWH between 10 and 30;

---12---
select * from dbo.ChargingStationsData where StationName like 'super%';

---13---
select sum(ChargistCost)as TotalRevenueGenerated from dbo.ChargingStationsData;

---14---
select avg(ChargingDurationminutes)as AverageChargingDuration from dbo.ChargingStationsData;

---15---
select max(chargistcost)as HighestChargingCost from dbo.ChargingStationsData;

---16---
select count(sessionid)as TotalChargingSessions from dbo.ChargingStationsData;

---17---
select count(sessionid)as TotalFastchargingused from dbo.ChargingStationsData where FastChargingUsed=1;

---18---
select Cityarea,sum(ChargistCost)as TotalrevenueperCityArea from dbo.chargingstationsdata group by Cityarea; 

---19---
select vehicletype,avg(Energyconsumedkwh)as AverageEnergyConsumedPerVehicleType from dbo.ChargingStationsData group by vehicletype;

---20---
Select stationname ,count(Sessionid)as TotalsessionsPerstationname from dbo.ChargingStationsData group by StationName;

---21---
select cityarea,avg(ChargingDurationminutes)as AverageChargingTimePerCityArea from dbo.chargingStationsData group by Cityarea;

---22---
select cityarea,sum(Chargistcost)as TotalRevenue from dbo.ChargingStationsData group by cityarea having sum(ChargistCost)>5000; 

---And---
select * from dbo.ChargingStationsData where BatteryEndPercentage >40  and  ChargistCost >230 ;

select * from dbo.ChargingStationsData where FastChargingUsed <> 1 and ChargeDate = '2025-12-25'

select top 1 * from dbo.ChargingStationsData where ChargistCost>200 and  FastChargingUsed <> 1 and ChargeDate = '2025-12-25' 

---OR---
select * from dbo.ChargingStationsData where VehicleType = 'scotter' or VehicleType = 'electric car' order by chargistcost desc;

---Not---
select * from dbo.ChargingStationsData where not VehicleType = 'Bike' and BatterystartPercentage = 9 ;

---where---
select * from dbo.ChargingStationsData where StationName= 'ElectroFast'

select * from dbo.ChargingStationsData where StationName= 'GreenCharge Zone' 

select * from dbo.ChargingStationsData where ChargeDate <> '2026-02-05'

---Order by---

Select * from dbo.ChargingStationsData order by ChargistCost desc;

select * from dbo.ChargingStationsData order by ChargingDurationminutes ;

select * from dbo.ChargingStationsData order by cityarea , chargistcost desc;

select top 10  * from dbo.ChargingStationsData where chargedate = '2025'order by  ChargistCost 

select top 5 * from dbo.ChargingStationsData where FastChargingUsed = 1 order by ChargingDurationminutes

Select top 7 * from dbo.ChargingStationsData where  EnergyConsumedKWH > 15 order by EnergyConsumedKWH;

select *from dbo.ChargingStationsData order by  (BatteryEndPercentage - BatteryEndPercentage ) Desc;

select * from dbo.ChargingStationsData order by (Chargistcost/EnergyConsumedKWH)desc;

---18 02 2026---

select * from dbo.ChargingStationsData order by ChargistCost 

---distinct---

select distinct CityArea  from dbo.ChargingStationsData 

select distinct vehicletype from dbo.ChargingStationsData

select distinct Stationname from dbo.ChargingStationsData

select distinct chargedate from dbo.ChargingStationsData

select distinct cityarea from dbo.ChargingStationsData where FastChargingUsed =1 ;

select distinct vehicletype from dbo.ChargingStationsData where year(ChargeDate) = '2026';

select distinct cityarea from dbo.ChargingStationsData where ChargistCost > 800;

select distinct cityarea from dbo.ChargingStationsData order by	CityArea

select distinct chargedate from dbo.ChargingStationsData order by ChargeDate Desc;

select distinct vehicletype from dbo.ChargingStationsData order by VehicleType

select distinct cityarea,vehicletype from dbo.ChargingStationsData 

select distinct stationname,cityarea from dbo.ChargingStationsData

select distinct vehicletype,fastchargingused from dbo.ChargingStationsData

---distinct Hard level---

SELECT COUNT(DISTINCT CityArea) AS TotalCityAreas FROM dbo.ChargingStationsData;

select count(distinct vehicletype)as TotalUniqueVehicleTypesusedStations from dbo.ChargingStationsData


---Top---
Select * from dbo.ChargingStationsData 

select top 5 *from dbo.ChargingStationsData
order by ChargistCost desc;

select top 3 * from dbo.ChargingStationsData 
order by ChargingDurationminutes

select top 10 * from dbo.ChargingStationsData 
order by chargedate desc

select top 5*from dbo.ChargingStationsData
where FastChargingUsed = 1
order by ChargistCost desc;

select top 7*from dbo.ChargingStationsData
where EnergyConsumedKWH > 20
order by sessionid ;

SELECT TOP 5 *,
       (BatteryEndPercentage - BatterystartPercentage) AS BatteryIncrease
FROM dbo.ChargingStationsData
WHERE CityArea = 'Whitefield'
ORDER BY BatteryIncrease DESC;


select top 5 *,(chargistcost / energyconsumedkwh) as Highestcost 
from dbo.ChargingStationsData
order by Highestcost desc;

Select top 5*,(batteryendpercentage-batterystartpercentage) as BiggestBatteryGain 
from dbo.ChargingStationsData 
order by BiggestBatteryGain desc;

---Null and Not Null---

Select StationName,Cityarea 
from dbo.ChargingStationsData
where cityarea is null;

Select StationName,Cityarea 
from dbo.ChargingStationsData
where cityarea is not null;


---calculations---
select SessionID,vehicletype,(batteryEndPercentage-batterystartpercentage)as TotalBatterPercentageChargedbyaVehicletype 
from dbo.ChargingStationsData;

Select Sessionid,Vehicletype,Cityarea,(chargistcost/chargingdurationminutes)as Totalchargecostperminute 
from dbo.ChargingStationsData;

select Stationname,cityarea,vehicletype,(Chargistcost*12)as TotalCostOfVehicleTypeInaYear 
from dbo.ChargingStationsData;

select sessionid,(Stationname+cityarea)as PlaceWhereTheVehicleCharged 
from dbo.ChargingStationsData;




---modulo---
select * from dbo.ChargingStationsData
where SessionID%2=0;

select * from dbo.ChargingStationsData
where SessionID%2!=0; 

---in And not in ---
select *from dbo.ChargingStationsData
where Cityarea not in('Whitefield')

select *from dbo.ChargingStationsData
where Cityarea  in('Whitefield')

---String Functions---
---Upper(converts all to Uppercase letters)--- 

SELECT UPPER(CityArea) AS CityUpper
FROM dbo.ChargingStationsData;

---Lower(converts all to lowercase letters)---
select Lower(Stationname)as CityLower
from dbo.ChargingStationsData;

---len(returns the length of that each row)---
Select len(batteryendpercentage)as TotalsessionsofBatteryCharge
from dbo.ChargingStationsData

Select stationname,len(Stationname )as TotalsessionsofBatteryCharge
from dbo.ChargingStationsData

---left(returns left letters in a specified string in a column)---
select stationname,left(Stationname,5)as Firstfiveletters
from dbo.ChargingStationsData

---right(returns right in a specified string in a column)---
select stationname,right(stationname,6)as LastFiveLetters
from dbo.ChargingStationsData

---SubString(by using this function  we can specify how many strings want ---)
SELECT SUBSTRING(StationName, 0, 4) AS ShortName
FROM dbo.ChargingStationsData;

SELECT SUBSTRING(StationName, 1, 4) AS ShortName
FROM dbo.ChargingStationsData;


SELECT SUBSTRING(StationName, 2, 4) AS ShortName
FROM dbo.ChargingStationsData;



---Having(select,from,where,group by,having,order by)---
select  stationname,sum(Chargistcost)
as TotalRevenueForThatDayGenerated 
from dbo.ChargingStationsData 
where EnergyConsumedKWH > 30 
Group by StationName 
having sum(chargistcost) > 2000
order by TotalRevenueForThatDayGenerated desc;


select Stationname,Energyconsumedkwh,avg(energyconsumedkwh)
as AverageenergyConsumedPerStataion 
from dbo.ChargingStationsData
where CityArea = 'Rajajinagar'
group by EnergyConsumedKWH,StationName
Having AVG(energyconsumedkwh) > 1.0
order by AverageenergyConsumedPerStataion desc;


---19-02-2026---

select user_name();

---ASCII(returns the ascii value of specified)---
select ASCII(StationName)as ASCIIVALUEOFSTATIONNAMES
from dbo.ChargingStationsData

