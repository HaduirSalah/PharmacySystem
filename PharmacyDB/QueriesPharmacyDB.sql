--------------------------- Views ---------------------------
--Retrieve the total sales for a particular medication 
-- By Medicine_ID
-- Create a View
CREATE VIEW TotalSalesByMedicine_ID AS
SELECT SUM(UnitPrice) AS TotalSales
FROM [dbo].[Medicine]
WHERE ID=10
-- Call View
SELECT * FROM TotalSalesByMedicine_ID
----------------------------------------------
-- By Medicine_Name
-- Create a View
CREATE VIEW TotalSalesByMedicine_Name AS
SELECT SUM(UnitPrice) AS TotalSales
FROM [dbo].[Medicine]
WHERE Name='rapiflam'
-- Call View
SELECT * FROM TotalSalesByMedicine_Name

----------------------------------------------
--Retrieve the top 10 best-selling medications
-- Create a View
CREATE VIEW Top2Best_Selling_Medications AS
SELECT TOP (10) M.ID, M.Name,COUNT(MB.TotalPrice) as Sales_Count
FROM [dbo].[Medicine] M,[dbo].[MedBills] MB
GROUP BY M.ID , M.Name 
ORDER BY Sales_Count DESC

-- Drop View
DROP VIEW Top2Best_Selling_Medications
-- Call View
SELECT * FROM Top2Best_Selling_Medications

----------------------------------------------------------
-- Retrieve all the orders for a particular medication
-- By Medicine_Name
-- Create a View
CREATE VIEW AllOrdersForParticularMedication_Name AS
SELECT  Id,MedicineName,Date,EmployeeName
FROM [dbo].[MedBills] 
WHERE  [dbo].[MedBills].MedicineName='meranda'

-- Call View
SELECT * FROM AllOrdersForParticularMedication_Name
----------------------------------------------------------
-- By Medicine_ID
-- Create a View
CREATE VIEW AllOrdersForParticularMedication_ID AS
SELECT  [dbo].[MedBills].Id,MedicineName,Date,EmployeeName
FROM [dbo].[MedBills], [dbo].[Medicine]
WHERE  [dbo].[Medicine].Id=[dbo].[MedBills].Id

-- Call View
SELECT * FROM AllOrdersForParticularMedication_ID
-----------------------------------------------
-- Create a view that displays the total revenue generated by each company in the MEDBILL table
CREATE VIEW Company_Revenue AS
SELECT C.[Id], C.[Name], SUM(bill.TotalPrice) AS Total_Revenue
FROM [dbo].[Company] C
INNER JOIN MEDICINE M ON C.[Id] = M.[CompID]
INNER JOIN  [dbo].[MedBills] Bill ON M.[ID] = bill.[MedId]
GROUP BY  C.[Id] , C.[Name] 

-- CALL VIEW 
SELECT * FROM Company_Revenue

--------------------- ANOTHER WAY TO JOIN ------------------
ALTER VIEW Company_Revenue AS
SELECT C.[Id], C.[Name], SUM(bill.TotalPrice) AS Total_Revenue
FROM [dbo].[Company] C, MEDICINE M ,[dbo].[MedBills] Bill
WHERE C.[Id] = M.[CompID] AND M.[ID] = bill.[MedId]
GROUP BY  C.[Id] , C.[Name] 

-- CALL VIEW 
SELECT * FROM Company_Revenue
---------------------------------------------------------------------------------------
--Create a view that displays the total AMOUNT of all medical bills for each company
CREATE VIEW Company_Medbill_Total_Amount_View
AS
SELECT C.Name AS Company_Name, SUM(MB.Quantity) AS Total_Amount
FROM [dbo].[Company] C
JOIN [dbo].[MedBills] MB ON c.Id= MB.MedId
GROUP BY c.name

--DROP VIEW
DROP VIEW Company_Medbill_Total_Amount_View
-- CALL VIEW
SELECT * FROM Company_Medbill_Total_Amount_View

-------------------------------------------------------
--Create a view that displays the total Cost of all medical bills for each company
CREATE VIEW Company_Medbill_Total_Cost_View
AS
SELECT C.Name AS Company_Name, SUM(MB.TotalPrice) AS Total_Cost
FROM [dbo].[Company] C
JOIN [dbo].[MedBills] MB ON c.Id= MB.MedId
GROUP BY c.name

--DROP VIEW
DROP VIEW Company_Medbill_Total_Cost_View
-- CALL VIEW
SELECT * FROM Company_Medbill_Total_Cost_View

---------------------------------------------------------------------------------------
-- Create view that display most total profit in table medicine
CREATE VIEW MostTotalProfit 
AS 
SELECT TOP(1) Name , Profit
FROM [dbo].[Medicine]

SELECT * FROM MostTotalProfit
--------------------------------------------------------------------------------------
-- create view that displays medicine data for the medicine who ProductionDate
CREATE VIEW Check_Medicine_ProductionDate
AS
SELECT  Name,ProductionDate
FROM [dbo].[Medicine]
WHERE ProductionDate BETWEEN '2020-01-01' AND '2023-12-31'

-- Before add with check OPTION insert Query is Execute
Update Check_Medicine_ProductionDate set ProductionDate='2024-12-31'  Where ProductionDate='2020-05-26'; -- Execute

-- CALL VIEW
SELECT * FROM Check_Medicine_ProductionDate
--------------------------------------------------------------------------------------
-- Note: tO Prevent the users to run the following query Update 
--VIEW Check_Medicine_ProductionDate set ProductionDate outside '2020-01-01' AND '2023-12-31'
-- After with check OPTION
CREATE VIEW Check_Medicine_ProductionDate_With_Check_OPTION
AS
SELECT  Name,ProductionDate
FROM [dbo].[Medicine]
WHERE ProductionDate BETWEEN '2020-01-01' AND '2023-12-31'
WITH CHECK OPTION

-- After add WITH CHECK OPTION
Update Check_Medicine_ProductionDate_With_Check_OPTION set ProductionDate='2024-12-31'  Where ProductionDate= '2020-03-26'; --NotExecute
-- CALL VIEW
SELECT * FROM Check_Medicine_ProductionDate_With_Check_OPTION
--------------------------------------------------------------------------------------
---------------------- Stored Procedures ---------------------
-- show employee name make a bill
CREATE PROC Employee_Name_bill
(
   @IdBill int
)
As
BEGIN
   SELECT EMP.name
   FROM [dbo].[Employee] EMP , [dbo].[Bill] B
   WHERE EMP.id=B.EmpId AND B.Id =@IdBill
END

Employee_Name_bill 9
--------------------------------------------------------------------------------------
-- Create a stored procedure that adds a new employee to the Employee table
CREATE PROCEDURE Add_Employee
(
    @name VARCHAR(50),
    @email VARCHAR(50),
    @phone VARCHAR(20),
    @salary int,
	@age int,
	@password VARCHAR(100)
)
AS
BEGIN
    INSERT INTO Employee (name, Email,phone, salary,Age,password)
    VALUES (@name, @email, @phone, @salary,@age,@password)
END

-- DROP PROCEDURE
DROP PROCEDURE Add_Employee
--- CALL PROCEDURE
 Add_Employee Talin, Talin@Employee,0109838394,4000,20,4352

-- Table Employee After PROCEDURE

 SELECT * FROM [dbo].[Employee]
-------------------------------------------------------------------------------
--create a stored procedure to add a new medicine to the Medicine table
CREATE PROCEDURE add_medicine
    @medicine_name varchar(50),
    @price MONEY,
    @quantity int,
	@type varchar(50),
	@compID int,
	@expDate Date,
	@productionDate Date,
	--@enteredDate Date,
	@CompanyPrice int
AS
BEGIN
    INSERT INTO Medicine (Name, UnitPrice, quantity,Type,CompID,ExpDate,ProductionDate,EnteredDate,CompanyPrice)
    VALUES (@medicine_name, @price, @quantity,@type,@compID,@expDate,@productionDate,GETDATE(),@CompanyPrice)
END

-- CALL PROCEDURE
add_medicine 'DebovitB12',8.00,50,'injection',6,'2022-05-26 00:00:00.0000000','2020-03-26 00:00:00.0000000',7.50

-- Table Medicine After PROCEDURE
SELECT * FROM [dbo].[Medicine]
-------------------------------------------------------------------------------
--create a stored procedure to add a new COMPANY to the Medicine table
CREATE PROC ADD_NEW_COMPANY 
    @name VARCHAR(40),
	@phone VARCHAR(40),
	@address VARCHAR(40)
AS
BEGIN
	INSERT INTO [dbo].[Company] (Name,Phone,Address)
	VALUES (@name,@phone,@address)
END

-- CALL PROCEDURE
ADD_NEW_COMPANY 'ULT',01063745858,'Cairo'
-- Table Company After PROCEDURE
SELECT * FROM [dbo].[Company]
-------------------------------------------------------------------------------
-- create a stored procedure know who employee entered medicine in data base  
CREATE PROC EmployeeEnteredMedicine
(
   @MedId int
)
As
BEGIN
   select E.[name],M.[Name],C.[Name]
   from [dbo].[Employee] E,[dbo].[Medicine] M,[dbo].[Company] C
   where�C.EmployeeId=E.id and M.CompID=C.Id and M.ID = @MedId
END

EmployeeEnteredMedicine 2

-------------------------------------------------------------------------------
---------------------- Triggers ---------------------
--Create a trigger that logs whenever a new medicine is added to the Medicine table
CREATE TABLE LogTable 
(
	event_type VARCHAR(50),
	event_description VARCHAR(50)
)
CREATE TRIGGER Medicine_Added_Trigger
ON [dbo].[Medicine]
AFTER INSERT
AS
BEGIN
    DECLARE @medicine_name VARCHAR(50)
    SELECT @medicine_name = Name FROM inserted
    INSERT INTO LogTable (event_type, event_description)
    VALUES ('Medicine Added', 'New medicine added: ' + @medicine_name)
END

INSERT INTO [dbo].[Medicine] (Name,UnitPrice,Type,quantity,CompID,ExpDate,ProductionDate,EnteredDate)VALUES('ezacard',23.50,'Tablet',12,3,'2024-02-26 00:00:00.0000000','2020-05-26 00:00:00.0000000',GETDATE())

SELECT * FROM LogTable
-----------------------------------------------------------------------------------
--------------------------- Functions ------------------------
--Create a function that calculates the price of a medicine based on its cost and markup percentage
CREATE FUNCTION Calculate_Medicine_Price
(
    @cost DECIMAL(10, 2),
    @markup_percentage DECIMAL(5, 2)
)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @markup_amount DECIMAL(10, 2)
    SET @markup_amount = @cost * (@markup_percentage / 100.0)
    RETURN @cost + @markup_amount
END

--- CALL FUNCTION
SELECT dbo.Calculate_Medicine_Price (23.50,20.0)
----------------------------------------------------------------
--create a function that returns the average price of all medicines in the Medicine table
CREATE FUNCTION fn_average_medicine_price()
RETURNS MONEY
AS
BEGIN
    DECLARE @avg_price MONEY
    SELECT @avg_price = AVG(UnitPrice) FROM Medicine
    RETURN @avg_price 
END

-- CALL FUNCTION
SELECT dbo.fn_average_medicine_price()
---------------------------------------------------------------------------------
------------------------- Cursors  -----------------------------
--Use a cursor to update the prices of all medicines with a markup percentage of 20%
DECLARE @id INT
DECLARE @name NVARCHAR(50)
DECLARE @price FLOAT
DECLARE @markup FLOAT = 0.2 -- 20% markup

DECLARE Medicine_Cursor CURSOR FOR
SELECT ID, Name, UnitPrice
FROM [dbo].[Medicine]

OPEN medicine_cursor

FETCH NEXT FROM Medicine_Cursor INTO @id, @name, @price

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Update the price with 20% markup
    UPDATE [dbo].[Medicine]
    SET UnitPrice += @price * @markup
    WHERE ID = @id

    FETCH NEXT FROM Medicine_Cursor INTO @id, @name, @price
END

CLOSE Medicine_Cursor
DEALLOCATE Medicine_Cursor

-- Price Medicine After Add Cursor to update the prices of all medicines with a markup percentage of 20%
SELECT * FROM [dbo].[Medicine]

---------------------------------------------------------------------------------------------
--create a cursor to update the quantity of each medicine 
--in the Medicine table by adding 5 to the current quantity

DECLARE @medicine_id int
DECLARE @quantity int
DECLARE cur_medicine CURSOR FOR
SELECT ID , quantity FROM Medicine

OPEN cur_medicine
FETCH NEXT FROM cur_medicine INTO @medicine_id, @quantity

WHILE @@FETCH_STATUS = 0
BEGIN
    UPDATE Medicine SET quantity = @quantity + 10 WHERE ID = @medicine_id
    FETCH NEXT FROM cur_medicine INTO @medicine_id, @quantity
END

CLOSE cur_medicine
DEALLOCATE cur_medicine

-- Quantity of medicines After update the quantity of each medicine by adding 10% to the current quantity

SELECT * FROM [dbo].[Medicine]

----------------------------------------------------------------------------------------------------------
------------------------- Dynamic Query ---------------------------------------
-- Table Employee
select name
from [dbo].[Employee]

declare @colNameEmployee varchar(30) = 'name' , @tabEmployee varchar(30) = '[dbo].[Employee]'

execute ('select ' +@colNameEmployee  + ' from ' + @tabEmployee)

-----------------------------------------------------------------------------------
-- Table Company
select Name
from [dbo].[Company]


declare @colNameCompany varchar(30) = 'Name' , @tabCompany varchar(30) = '[dbo].[Company]'

exec ('select ' +@colNameCompany + ' from ' + @tabCompany) 
------------------------------------------------------------------------------------
-- Table Medicine
select Name
from [dbo].[Medicine]

declare @colNameMedicine varchar(30) = 'Name' , @tabMedicine varchar(30) = '[dbo].[Medicine]'

exec ('select ' +@colNameMedicine + ' from ' + @tabMedicine) 
--------------------------------------------------------------------------------------
--------------------------- DENSE_RANK ----------------------------------------
-- Ranking to find the highst salary in employee table based on salary

select name , age , salary,
	DENSE_RANK() over (order by salary desc) as [dense_rank]
from Employee
order�by�salary
-------------------------------------------------------------------------------
-------------------Each Employee and His sales -----------------------------------
create proc Empsales 
AS
select Sum(TotalPrice) as totalprice,EmployeeName
from MedBills
group by EmployeeName

execute Empsales

-------------------------profit every years---------------------------------
alter proc YearsProfit
as
Declare @startDate Date='2023-03-3'
Declare @EndDate Date=GetDate()
select Year(Date) Year,sum (TotalProfit) as TotalProfit
from MedBills B
where B.Date >= @StartDate and B.Date <= @EndDate
group by Year(Date)

YearsProfit

--------------------------TabaMedical Company-------------------------------------
create view TabaComp (Id,Name,MedName)
as
  select M.CompID,c.Name,M.Name
  from Medicine M , Company C
  where M.CompID = c.Id and M.CompID = 1

select * from TabaComp

--------------------Specific Company And Medicine Comes from it----------------------------
create function CompMed(@CompId Int)
returns table
AS
RETURN
select M.CompID,c.Name as CompanyName,M.Name as MedicineName
from Medicine M,Company C
where M.CompID = C.Id and M.CompID = @CompId

select *from CompMed(8)

----------------profit every month in specific year---------------------------------
create function MonthProfit(@year int)
returns table 
as 
return 
select Month(Date) Month , sum(TotalProfit) as  TotalProfit
from MedBills
where YEAR(Date) = @year
Group by Month(Date)

select * from MonthProfit(2023)
-------------------Best seller Month--------------------------------------
create view BestSellerMonth
as
select top(1) sum(TotalProfit) as TotalProfit ,  Month(Date)  Month
from MedBills
Group by Month(Date) 

select * from BestSellerMonth
---------------------Medicine that entered by employee One-------------------------------------
select *
from Medicine
where EmplId = 1
--------------------------------------------------------------------------------
-- admin and employee view
create view Employee_View
as 
select * from Employee
where Email like '%@Employee%'
-----------------------------------------
create view Admin_View
as 
select * from Employee
where Email like '%@admin%'

select * from Admin_View
----------------------------------------------------
-- RANKING WINDOW

-----------------------order by price-------------------------

select Id ,Name,UnitPrice,quantity,CompID,
	ROW_NUMBER() over (order by UnitPrice desc,Id asc) As [row],
	Rank() over(order by UnitPrice desc) as [Rank],
	DENSE_RANK() over (order by UnitPrice desc) as [D-rank]
from Medicine
Order by UnitPrice desc

------------------------order by profit--------------------------------

select Id ,Name,UnitPrice,Profit,CompID,
	ROW_NUMBER() over (order by Profit desc,Id asc) As [row],
	Rank() over(order by Profit desc) as [Rank],
	DENSE_RANK() over (order by Profit desc) as [D-rank]
from Medicine
Order by UnitPrice desc


-------------------------------order by profit in medBills--------------------------------

select id,MedicineName,TotalPrice,TotalProfit,
	DENSE_RANK() over( order by totalProfit asc) as [rank]
from MedBills 
order by TotalProfit

-----------ranking to find the highst salary in employee table based on age -----------------------
select name , age , salary,
	DENSE_RANK() over (order by salary desc) as [dense_rank]
from Employee
order by age

-----------------------------------------------------------------------------------------------------
-- Create View know number of company we work per city

create view Know_Number_company_Per_City
as
select [Id] , [Name] ,count([Id]) over (PARTITION by [Address]) as [NumOfCompanyPerCity],[Address]
from [dbo].[Company]
where [Address] is not null

select * from Know_Number_company_Per_City

-----------------------------------------------------------------
-- Create View know number of Medicine we work per Company

create view  Know_Number_Medicine_Per_Company
as
select M.[ID] ,M.[Name]as NameofMedicine ,C.[Name] as NameofCompany,count(M.[ID]) over (PARTITION by M.[CompID]) as [NumOfMedicinePerCompany]
from [dbo].[Medicine] M ,[dbo].[Company] C
where M.CompID = C.Id


select * from Know_Number_Medicine_Per_Company
-----------------------------------------------------------------------------------

create view  Number_of_Medicine_Per_Company
as
select c.Id,c.Name as companyName,count(m.Name) as totalnumberofMedicine
from Medicine m,company c
where m.CompID=c.Id
group by c.Name,c.Id

select * from Number_of_Medicine_Per_Company
---------------------------------------------------------------------------------
-----------view to show Employes age under 25 
 create View Employes_Under_25
   as
select [id], [name],[phone],[Email]
from [dbo].[Employee]
where [Age]<25


select * from Employes_Under_25

-----------------------------------------------------------------------------------
-----------view to show Employes age over 25 

create View Employes_over_25
   as
select [id], [name],[phone],[Email]
from [dbo].[Employee]
where�[Age]>25

select * from Employes_over_25

----------------------------------------------------------------
---- know who employee entered medicine in data base 
select E.[name],M.[Name],C.[Name]
from [dbo].[Employee] E,[dbo].[Medicine] M,[dbo].[Company] C
where�C.EmployeeId=E.id and M.CompID=C.Id

-----------------------------------------------------------------
-------create view to show all in bill table  witgout encryption
create view  showallinbilltable
as
select * from [dbo].[Bill]
sp_helptext 'showallinbilltable';

------------create view to show date by EmpId with encryption 

create view showdatebyid
with encryption 
as 
select date from [dbo].[Bill]
where EmpId=1
sp_helptext 'showdatebyid';
------------------------------create view to show idof bill by id of Emp
create view showIdOfBillByIdofEmp
with encryption 
as 
select  id from [dbo].[Bill] 
where EmpId=1;
select * from showIdOfBillByIdofEmp
sp_helpText'showIdOfBillByIdofEmp'
-----------------------------create view to show all in company Table without Encryption-----------------------------------------------
create view showAllInCompanyTable
as 
select * from [dbo].[Company]
sp_helptext 'showAllInCompanyTable'
select * from showAllInCompanyTable
 -----------------------create view show id and name where the address is cairo with encryption-----------

create view showIdandName
with encryption 
as 
select Id,Name 
from [dbo].[Company]
where Address='Cairo'
select * from showIdandName
------------------------------create view to show name where address=assuit and Assiut with encryption------------------------
create view showName
with encryption 
as
select Name from [dbo].[Company]
where Address='Assuit' or Address='Assiut'

------------------------------------create view that show id withcompanynameFarco------------

create view showIdWithCompanyNameFarco
with encryption 
as 
select id from  [dbo].[Company]
where Name ='Farco';
select * from showIdWithCompanyNameFarco
-------------------------------create view that countageofEmployeewithsalary=1000-----------------------------
create view countahgeofEmployeewithsalary1000
with encryption
as 
select  Count(Age)as numberofEmployee 
from Employee
where salary=1000
group by Name;
select * from countahgeofEmployeewithsalary1000

------------------------------------create view that count the number of Employee with age>23---------------------------
create view numberpfEmployeewithAgegreaterthan23
with encryption
as
select Count(Name) as numberofemployee 
from Employee
where Age>23
group by Name

select * from numberpfEmployeewithAgegreaterthan23
union all 
select *from countahgeofEmployeewithsalary1000
---------------------------------------------------
select *from Medicine
------------------------------create view that show name where profit greaterthan 10------------------------
create view viewshownameofmedicine
with encryption
as 
select Name 
from Medicine
where Profit>10
select * from viewshownameofmedicine
------------------------------create view that show name where type isTablet-----------------------
create view viewmedicinename
with encryption
as
select Name 
from Medicine
where Type='Tablet'
select * from viewmedicinename
------------------------------------create view that show name of medicine with type Injection
create view medicineNameWithTypeInjection
with encryption
as
select Name 
from Medicine
where Type='injection'
select * from medicineNameWithTypeInjection
--------------------------------------create view toshow nameof Medicine that not injection and Tablet-----------------
create view viewmwdicineNamewithTypeSyrup
with encryption 
as
select Name 
from Medicine
where Type!='injection' and Type !='Tablet'
select * from viewmwdicineNamewithTypeSyrup
-----------------------------------create view that show nameof medicine with companyprice=85-----------------------
create view shownameofMedicneWithCompanyPrice85
with encryption 
as
select Name
from Medicine
where CompanyPrice=85
select * from shownameofMedicneWithCompanyPrice85
-------------------------create view to show companyprice with typetablet------------------------
create view showCompanyPricewithTypeTablet
with encryption 
as
select Type,CompanyPrice
from Medicine
where Type='Tablet'
select * from showCompanyPricewithTypeTablet
-------------------------create view to show name,ProductionDate andEnteredDate with CompId=3------------------------
create view viewshowname_productData_EnteredDate
with encryption
as
select Name ,ProductionDate,EnteredDate
from Medicine
where CompId=3
select * from viewshowname_productData_EnteredDate
-----------------------------------------------create view to show name with UnitPrice>=100-------------------
create view viewtoshownamewithUnitPrice100
with encryption
as
select Name
from Medicine
where UnitPrice>=100
select * from viewtoshownamewithUnitPrice100
---------------------------------------create view to show Name,ProductionDate,ExpDate with type Tablet-------------------
create view shownName_ProductionDate_ExpDatewithTypeTablet
with encryption 
as
select Name,ProductionDate,ExpDate
from Medicine
where Type='Tablet' 
select * from shownName_ProductionDate_ExpDatewithTypeTablet
-------------------------------------create view to show Name,ProductionDate,ExpDate with type injection---------------
create view shownName_ProductionDate_ExpDatewithTypeinjection
with encryption 
as
select Name,ProductionDate,ExpDate
from Medicine
where Type='injection'
select * from shownName_ProductionDate_ExpDatewithTypeinjection
---------------------------------------create view to count Medicine with type Tablet-------------------------
create view shownameandCountofmedicinewithtypeTablet
with encryption 
as
select Name ,count(*)as numberofMeicine
from Medicine
where Type='Tablet' 
group by Name
select * from shownameandCountofmedicinewithtypeTablet
--------------------------------------crreat view to count Medicine with type injection--------------
create view shownameandCountofmedicinewithtypeinjection
with encryption 
as
select Name ,count(*)as numberofMeicine 
from Medicine
where Type='injection' 
group by Name
select * from shownameandCountofmedicinewithtypeinjection
--------------------------------------create view to count Medicine with type Syrup--------------
create view shownameandCountofmedicinewithtypeSyrup
with encryption 
as
select Name ,count(*)as numberofMeicine 
from Medicine
where Type!='injection'and Type!='Tablet'

group by Name
select * from shownameandCountofmedicinewithtypeSyrup
--------------------------------------------------functions
select *from Medicine
select * from [dbo].[Bill]
select * from [dbo].[Employee]
select * from company
--------------------------make the nameof medicine in upperand lowercase--------------------
select upper(Name) as NameofMedicineInUppercase, lower(Name) asNameofmMedicineInLowercase
from Medicine
-----------------------------get the maxlength of string of medicinename---------------
select max(len(Name)) as maxlengthofMedicineName
from Medicine
-----------------------get the nameof db and userame----------------------
select DB_NAME() , SUSER_NAME()
-----------------------------get the minlength of string of medicinename---------------
select min(len(Name)) as maxlengthofMedicineName
from Medicine
---------------------------make the nameof Employee in upperand lowercase---------------
select upper(name) as NameofEmployeeInUppercase, lower(name) asNameofmEmployeeInLowercase
from Employee
-------------------------get the maxlengthof Employeename----------------------
select max(len(name)) as maxlengthofEmployeeName
from Employee
-------------------------get the minlengthof Employeename----------------------
select min(len(name)) as maxlengthofEmployeeName
from Employee
---------------------------make the nameof company in upperand lowercase---------------
select upper(Name) as NameofCompanyInUppercase, lower(Name) asNameofmCompanyInLowercase
from company
-------------------------get the maxlengthof CompanyName------------------
select max(len(name)) as maxlengthofcompanyName
from company
-------------------------get the minlengthof CompanyName------------------
select min(len(name)) as maxlengthofcompanyName
from company
--------------------------select Top1 of Company With minlengthof name----------------------------
SELECT  TOP 1(name)  FROM company 

WHERE len(name) = (SELECT min(len(name))  FROM company) 
--------------------------select Top1 of Company With maxlengthof name----------------------------
SELECT  TOP 1(name)  FROM company 

WHERE len(name) = (SELECT max(len(name))  FROM company) 
--------------------------select Top1 of Medicine With minlengthof name----------------------------

SELECT  TOP 1(Name)  FROM Medicine

WHERE len(name) = (SELECT min(len(name))  FROM Medicine) 
--------------------------select Top1 of Medicine With maxlengthof name----------------------------
SELECT  TOP 1(name)  FROM Medicine 

WHERE len(name) = (SELECT max(len(name))  FROM Medicine) 

--------------------------select Top1 of employeeWhit minlengthof name----------------------------
SELECT  TOP 1(Name)  FROM Employee

WHERE len(name) = (SELECT min(len(name))  FROM Employee) 
--------------------------select Top1 of employeeWhit maxlengthof name----------------------------
SELECT  TOP 1(name)  FROM Employee 

WHERE len(name) = (SELECT max(len(name))  FROM Employee) 


select Coalesce( age, 1)
from Employee
--------------------------------------try delay for 5 second--------------------------
WAITFOR DELAY '00:00:05';
GO
select * from Employee

-------------------------------Scaler Function that take id of comapmy and get nameof comapy------------------------------

create function GetMedicineName (@id int) 
returns varchar(50) 
begin 
    declare @name varchar(20)
	select @name =Name
	from company 
	where ID= @id

 return @name 
end 

select dbo.GetMedicineName(2)
------------------inline functionthat take the address of comapny and ---------------------
create function GetCompanyNameByAddress(@address varchar(50))
returns table
as
return 
(
  select Name, Phone 
  from  company
  where Address = @address
)

select * from dbo.GetCompanyNameByAddress('Cairo')
-----------------------create temptable-------------------


create table #TempTable
(id int , name varchar(20))

insert into #TempTable values(1 , 'Mayar')
select * from #TempTable
select * from Medicine
--------create table that take the id of medicine and return details-----------------------------------   
create function MedicineInfo(@format int)
returns table
as
return(
   select Name ,UnitPrice ,quantity,convert (varchar(20),Entereddate,@format) as Entereddate
   from Medicine
   

)
select * from MedicineInfo(109)

-------------------------------------------------day4------------------------ 
select * from 
(
select m.Name, 
        Dense_rank() over (partition by m.Name order by m.UnitPrice desc) as RN
from Medicine m,Company c
where m.CompID=c.Id
) as NewTabl
where RN = 2

--------------------------------------select name of highest medicine from price-----------------------------
create proc highestprice
as
select Name,UnitPrice from Medicine
where UnitPrice>100
execute  highestprice
---------------------------------create storedProcedure that calculate totalquantity-----------------------
create proc totalquantity 
as
select sum(quantity)as totalquantity
from Medicine

execute totalquantity 
=========================================
--------------------create stored procedure that returnNameofMedicinewithTypetablet
create proc NameofMedicinewithTypetablet
as
select Name,type
from Medicine
where type='Tablet'

execute NameofMedicinewithTypetablet
===========================================
--------------------------create stored procedure that show average unitprice for GSk company----------------------------
create proc NumberofMedicinewithTypetablet1
as
select count(Name)as numberofmedicinewithtyoeTablet 
from Medicine
where type='Tablet'


execute NumberofMedicinewithTypetablet1
----------------------------------------------------------------
select * from company
select *from Medicine

--------------------------create stored procedure that show average unitprice for Pharma company----------------------------
create proc averageforPharma
as
select c.Name,avg(m.UnitPrice)as averageofUnitprice
from Medicine m,company c
where  CompID=4 and c.Id=m.CompId
group by c.Name
execute averageforPharma
--------------------------------------------------
--------------------------create stored procedure that show average unitprice for Tabamedical company----------------------------
create proc averageforTabamedical
as
select c.Name,avg(m.UnitPrice)as averageofUnitprice
from Medicine m,company c
where  CompID=1 and c.Id=m.CompId
group by c.Name
execute averageforTabamedical
========================================================
--------------------------create stored procedure that show average unitprice for Farco company----------------------------
create proc averageforFarco
as
select c.Name,avg(m.UnitPrice)as averageofUnitprice
from Medicine m,company c
where  CompID=2 and c.Id=m.CompId
group by c.Name
execute averageforFarco
========================================================
--------------------------create stored procedure that show average unitprice for Amanco company----------------------------
create proc averageforAmanco
as
select c.Name,avg(m.UnitPrice)as averageofUnitprice
from Medicine m,company c
where  CompID=3 and c.Id=m.CompId
group by c.Name
execute averageforAmanco
==========================================================
--------------------------create stored procedure that show averageunitpricforSAnoficompany----------------------------
create proc averageforSanofi
as
select c.Name,avg(m.UnitPrice)as averageofUnitprice
from Medicine m,company c
where  CompID=5 and c.Id=m.CompId
group by c.Name
execute averageforSanofi
===========================================================
--------------------------create stored procedure that show average unitprice for GSk company----------------------------
create proc averageforGSK
as
select c.Name,avg(m.UnitPrice)as averageofUnitprice
from Medicine m,company c
where  CompID=6 and c.Id=m.CompId
group by c.Name
execute averageforGSk
==========================================================






