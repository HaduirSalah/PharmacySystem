USE [master]
GO
/****** Object:  Database [PharmacyDB]    Script Date: 5/03/2023 1:04:24 PM ******/
CREATE DATABASE [PharmacyDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PharmacyDB_Data', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQL19\MSSQL\DATA\PharmacyDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'PharmacyDB_Log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQL19\MSSQL\DATA\PharmacyDB.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [PharmacyDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PharmacyDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PharmacyDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PharmacyDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PharmacyDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PharmacyDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PharmacyDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [PharmacyDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PharmacyDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PharmacyDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PharmacyDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PharmacyDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PharmacyDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PharmacyDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PharmacyDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PharmacyDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PharmacyDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [PharmacyDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PharmacyDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PharmacyDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PharmacyDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PharmacyDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PharmacyDB] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [PharmacyDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PharmacyDB] SET RECOVERY FULL 
GO
ALTER DATABASE [PharmacyDB] SET  MULTI_USER 
GO
ALTER DATABASE [PharmacyDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PharmacyDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PharmacyDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PharmacyDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PharmacyDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PharmacyDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'PharmacyDB', N'ON'
GO
ALTER DATABASE [PharmacyDB] SET QUERY_STORE = OFF
GO
USE [PharmacyDB]
GO
/****** Object:  UserDefinedFunction [dbo].[Calculate_Medicine_Price]    Script Date: 5/03/2023 1:04:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Calculate_Medicine_Price]
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
GO
/****** Object:  Table [dbo].[MedBills]    Script Date: 5/03/2023 1:04:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MedBills](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MedicineName] [nvarchar](max) NOT NULL,
	[UnitPrice] [float] NOT NULL,
	[TotalProfit] [float] NOT NULL,
	[TotalPrice] [float] NOT NULL,
	[exist] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Date] [datetime2](7) NOT NULL,
	[EmployeeName] [nvarchar](max) NOT NULL,
	[MedId] [int] NOT NULL,
	[BillId] [int] NOT NULL,
 CONSTRAINT [PK_MedBills] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[BestSellerMonth]    Script Date: 5/03/2023 1:04:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[BestSellerMonth]
as
select top(1) sum(TotalProfit) as TotalProfit ,  Month(Date)  Month
from MedBills
Group by Month(Date)
GO
/****** Object:  Table [dbo].[Company]    Script Date: 5/03/2023 1:04:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Company](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Address] [nvarchar](max) NOT NULL,
	[Phone] [nvarchar](max) NOT NULL,
	[exist] [int] NOT NULL,
	[EmpName] [nvarchar](max) NOT NULL,
	[EmployeeId] [int] NOT NULL,
 CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Medicine]    Script Date: 5/03/2023 1:04:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Medicine](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[UnitPrice] [float] NOT NULL,
	[CompanyPrice] [float] NOT NULL,
	[Profit] [float] NOT NULL,
	[Type] [nvarchar](max) NOT NULL,
	[quantity] [int] NOT NULL,
	[exist] [int] NOT NULL,
	[CompID] [int] NOT NULL,
	[EmplId] [int] NOT NULL,
	[EmplName] [nvarchar](max) NOT NULL,
	[ExpDate] [datetime2](7) NOT NULL,
	[ProductionDate] [datetime2](7) NOT NULL,
	[EnteredDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Medicine] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[TabaComp]    Script Date: 5/03/2023 1:04:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[TabaComp] (Id,Name,MedName)
as
  select M.CompID,c.Name,M.Name
  from Medicine M , Company C
  where M.CompID = c.Id and M.CompID = 1
GO
/****** Object:  UserDefinedFunction [dbo].[CompMed]    Script Date: 5/03/2023 1:04:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[CompMed](@CompId Int)
returns table
AS
RETURN
select M.CompID,c.Name as CompanyName,M.Name as MedicineName
from Medicine M,Company C
where M.CompID = C.Id and M.CompID = @CompId
GO
/****** Object:  UserDefinedFunction [dbo].[MonthProfit]    Script Date: 5/03/2023 1:04:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[MonthProfit](@year int)
returns table 
as 
return 
select Month(Date) Month , sum(TotalProfit) as  TotalProfit
from MedBills
where YEAR(Date) = @year
Group by Month(Date)
GO
/****** Object:  View [dbo].[TotalSalesByMedicine_ID]    Script Date: 5/03/2023 1:04:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[TotalSalesByMedicine_ID] AS
SELECT SUM(UnitPrice) AS TotalSales
FROM [dbo].[Medicine]
WHERE ID=10
GO
/****** Object:  View [dbo].[TotalSalesByMedicine_Name]    Script Date: 5/03/2023 1:04:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[TotalSalesByMedicine_Name] AS
SELECT SUM(UnitPrice) AS TotalSales
FROM [dbo].[Medicine]
WHERE Name='rapiflam'
GO
/****** Object:  View [dbo].[Know_Number_company_Per_City]    Script Date: 5/03/2023 1:04:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[Know_Number_company_Per_City]
as
select [Id] , [Name] ,count([Id]) over (PARTITION by [Address]) as [NumOfCompanyPerCity],[Address]
from [dbo].[Company]
where [Address] is not null
GO
/****** Object:  View [dbo].[Know_Number_Medicine_Per_Company]    Script Date: 5/03/2023 1:04:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view  [dbo].[Know_Number_Medicine_Per_Company]
as
select M.[ID] ,M.[Name]as NameofMedicine ,C.[Name] as NameofCompany,count(M.[ID]) over (PARTITION by M.[CompID]) as [NumOfMedicinePerCompany]
from [dbo].[Medicine] M ,[dbo].[Company] C
where M.CompID = C.Id
GO
/****** Object:  View [dbo].[Number_of_Medicine_Per_Company]    Script Date: 5/03/2023 1:04:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view  [dbo].[Number_of_Medicine_Per_Company]
as
select c.Id,c.Name as companyName,count(m.Name) as totalnumberofMedicine
from Medicine m,company c
where m.CompID=c.Id
group by c.Name,c.Id
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 5/03/2023 1:04:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](max) NOT NULL,
	[salary] [int] NOT NULL,
	[Age] [int] NOT NULL,
	[phone] [nvarchar](max) NOT NULL,
	[password] [nvarchar](max) NOT NULL,
	[Email] [nvarchar](max) NOT NULL,
	[exist] [int] NOT NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[Employes_Under_25]    Script Date: 5/03/2023 1:04:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create View [dbo].[Employes_Under_25]
   as
select [id], [name],[phone],[Email]
from [dbo].[Employee]
where [Age]<25
GO
/****** Object:  View [dbo].[Employes_over_25]    Script Date: 5/03/2023 1:04:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create View [dbo].[Employes_over_25]
   as
select [id], [name],[phone],[Email]
from [dbo].[Employee]
where [Age]>25
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 5/03/2023 1:04:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bill]    Script Date: 5/03/2023 1:04:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime2](7) NOT NULL,
	[exist] [int] NOT NULL,
	[EmpId] [int] NOT NULL,
 CONSTRAINT [PK_Bill] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IX_Bill_EmpId]    Script Date: 5/03/2023 1:04:25 PM ******/
CREATE NONCLUSTERED INDEX [IX_Bill_EmpId] ON [dbo].[Bill]
(
	[EmpId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Company_EmployeeId]    Script Date: 5/03/2023 1:04:25 PM ******/
CREATE NONCLUSTERED INDEX [IX_Company_EmployeeId] ON [dbo].[Company]
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_MedBills_BillId]    Script Date: 5/03/2023 1:04:25 PM ******/
CREATE NONCLUSTERED INDEX [IX_MedBills_BillId] ON [dbo].[MedBills]
(
	[BillId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_MedBills_MedId]    Script Date: 5/03/2023 1:04:25 PM ******/
CREATE NONCLUSTERED INDEX [IX_MedBills_MedId] ON [dbo].[MedBills]
(
	[MedId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Medicine_CompID]    Script Date: 5/03/2023 1:04:25 PM ******/
CREATE NONCLUSTERED INDEX [IX_Medicine_CompID] ON [dbo].[Medicine]
(
	[CompID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Medicine_EmplId]    Script Date: 5/03/2023 1:04:25 PM ******/
CREATE NONCLUSTERED INDEX [IX_Medicine_EmplId] ON [dbo].[Medicine]
(
	[EmplId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD  CONSTRAINT [FK_Bill_Employee_EmpId] FOREIGN KEY([EmpId])
REFERENCES [dbo].[Employee] ([id])
GO
ALTER TABLE [dbo].[Bill] CHECK CONSTRAINT [FK_Bill_Employee_EmpId]
GO
ALTER TABLE [dbo].[Company]  WITH CHECK ADD  CONSTRAINT [FK_Company_Employee_EmployeeId] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employee] ([id])
GO
ALTER TABLE [dbo].[Company] CHECK CONSTRAINT [FK_Company_Employee_EmployeeId]
GO
ALTER TABLE [dbo].[MedBills]  WITH CHECK ADD  CONSTRAINT [FK_MedBills_Bill_BillId] FOREIGN KEY([BillId])
REFERENCES [dbo].[Bill] ([Id])
GO
ALTER TABLE [dbo].[MedBills] CHECK CONSTRAINT [FK_MedBills_Bill_BillId]
GO
ALTER TABLE [dbo].[MedBills]  WITH CHECK ADD  CONSTRAINT [FK_MedBills_Medicine_MedId] FOREIGN KEY([MedId])
REFERENCES [dbo].[Medicine] ([ID])
GO
ALTER TABLE [dbo].[MedBills] CHECK CONSTRAINT [FK_MedBills_Medicine_MedId]
GO
ALTER TABLE [dbo].[Medicine]  WITH CHECK ADD  CONSTRAINT [FK_Medicine_Company_CompID] FOREIGN KEY([CompID])
REFERENCES [dbo].[Company] ([Id])
GO
ALTER TABLE [dbo].[Medicine] CHECK CONSTRAINT [FK_Medicine_Company_CompID]
GO
ALTER TABLE [dbo].[Medicine]  WITH CHECK ADD  CONSTRAINT [FK_Medicine_Employee_EmplId] FOREIGN KEY([EmplId])
REFERENCES [dbo].[Employee] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Medicine] CHECK CONSTRAINT [FK_Medicine_Employee_EmplId]
GO
/****** Object:  StoredProcedure [dbo].[averageforGSK]    Script Date: 5/03/2023 1:04:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[averageforGSK]
as
select c.Name,avg(m.UnitPrice)as averageofUnitprice
from Medicine m,company c
where  CompID=6 and c.Id=m.CompId
group by c.Name
GO
/****** Object:  StoredProcedure [dbo].[averageforSanofi]    Script Date: 5/03/2023 1:04:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[averageforSanofi]
as
select c.Name,avg(m.UnitPrice)as averageofUnitprice
from Medicine m,company c
where  CompID=5 and c.Id=m.CompId
group by c.Name
GO
/****** Object:  StoredProcedure [dbo].[EmployeeEnteredMedicine]    Script Date: 5/03/2023 1:04:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[EmployeeEnteredMedicine]
(
   @MedId int
)
As
BEGIN
   select E.[name],M.[Name],C.[Name]
   from [dbo].[Employee] E,[dbo].[Medicine] M,[dbo].[Company] C
   where C.EmployeeId=E.id and M.CompID=C.Id and M.ID = @MedId
END
GO
/****** Object:  StoredProcedure [dbo].[Empsales]    Script Date: 5/03/2023 1:04:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Empsales] 
AS
select Sum(TotalPrice) as totalprice,EmployeeName
from MedBills
group by EmployeeName
GO
/****** Object:  StoredProcedure [dbo].[YearsProfit]    Script Date: 5/03/2023 1:04:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[YearsProfit]
as
Declare @startDate Date='2023-03-3'
Declare @EndDate Date=GetDate()
select Year(Date) Year,sum (TotalProfit) as TotalProfit
from MedBills B
where B.Date >= @StartDate and B.Date <= @EndDate
group by Year(Date)
GO
USE [master]
GO
ALTER DATABASE [PharmacyDB] SET  READ_WRITE 
GO
