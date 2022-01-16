--use s22188;
--GO

CREATE SCHEMA DWH;
GO

PRINT 'Dropping table DWH.Person'
DROP TABLE IF EXISTS DWH.Person
GO
PRINT 'Dropping table DWH.Age'
DROP TABLE IF EXISTS DWH.Age
GO
PRINT 'Dropping table DWH.Death'
DROP TABLE IF EXISTS DWH.Death
GO
PRINT 'Dropping table DWH.Injury'
DROP TABLE IF EXISTS DWH.Injury
GO
PRINT 'Dropping table DWH.DrugType'
DROP TABLE IF EXISTS DWH.DrugType
GO
PRINT 'Dropping table DWH.Time'
DROP TABLE IF EXISTS DWH.Time
GO
PRINT 'Dropping table DWH.DrugDeaths'
DROP TABLE IF EXISTS DWH.DrugDeaths
GO
PRINT 'Dropping table DWH.Holiday'
DROP TABLE IF EXISTS DWH.Holiday
GO
PRINT 'Dropping procedure InsertDWHTime'
DROP PROCEDURE IF EXISTS InsertDWHTime
GO


PRINT 'Create table DWH.Person'
CREATE TABLE DWH.Person(
   IdPerson int IDENTITY(1,1) NOT NULL PRIMARY KEY,
   ID varchar(50),
   Sex varchar(50),
   Race varchar(50),
   ResidenceCity varchar(100),
   ResidenceCounty varchar(100),
   ResidenceState varchar(100),
   ResidenceCityGeo varchar(255)
)
GO


PRINT 'Create table DWH.Age'
CREATE TABLE DWH.Age(
   IdAge int IDENTITY(1,1) NOT NULL PRIMARY KEY,
   Age  int,
   AgeGroup varchar(20)
)
GO


PRINT 'Create table DWH.Death'
CREATE TABLE DWH.Death(
   IdDeath int IDENTITY(1,1) NOT NULL PRIMARY KEY,
   DeathCity varchar(100),
   DeathCounty varchar(100),
   Location varchar(100),
   COD varchar(200),
   OtherSignifican varchar(200),
   MannerOfDeath varchar(100),
   DeathCityGeo varchar(150)
)
GO


PRINT 'Create table DWH.Injury'
CREATE TABLE DWH.Injury(
   IdInjury int IDENTITY(1,1) NOT NULL PRIMARY KEY,
   DescriptionOfInjury varchar(200),
   InjuryPlace varchar(100),
   InjuryCity varchar(100),
   InjuryCounty varchar(100),
   InjuryState varchar(100),
   InjuryCityGeo varchar(150)
)
GO


PRINT 'Create table DWH.DrugType'
CREATE TABLE DWH.DrugType(
   IdDrugType int IDENTITY(1,1) NOT NULL PRIMARY KEY,
   Heroin bit NOT NULL,
   Cocaine bit NOT NULL,
   Fentanyl varchar(50) NOT NULL,
   Fentanyl_Analogue bit NOT NULL,
   Oxycodone bit NOT NULL,
   Oxymorphone bit NOT NULL,
   Ethanol bit NOT NULL,
   Hydrocodone bit NOT NULL,
   Benzodiazepine bit NOT NULL,
   Methadone bit NOT NULL,
   Amphet bit NOT NULL,
   Tramad bit NOT NULL,
   Morphine_NotHeroin varchar(100) NOT NULL,
   Hydromorphone bit NOT NULL,
   Other varchar(250) NOT NULL,
   OpiateNOS bit NOT NULL,
   AnyOpioid varchar(1) NOT NULL
)
GO


PRINT 'Create table DWH.Time'
CREATE TABLE DWH.Time (
   Data date NOT NULL PRIMARY KEY,
   Year numeric(4) NOT NULL,
   Month numeric(2) NOT NULL,
   Day numeric(2) NOT NULL,
   PreHolidayPeriod bit,
   HolidayPeriod bit
)
GO


PRINT 'Create table DWH.DrugDeaths'
CREATE TABLE DWH.DrugDeaths (
   Time date NOT NULL,
   IdDrugType int NOT NULL,
   IdPerson int NOT NULL,
   IdInjury int NOT NULL,
   IdDeath int NOT NULL,
   IdAge int NOT NULL,
   Count int NOT NULL
 CONSTRAINT [PK_DWH_DrugDeaths] PRIMARY KEY
(
   Time,
   IdDrugType,
   IdPerson,
   IdInjury,
   IdDeath,
   IdAge
))
GO


PRINT 'Create table DWH.Holiday'
CREATE TABLE DWH.Holiday (
   Data date NOT NULL PRIMARY KEY,
   Year numeric(4) NOT NULL,
   Month numeric(2) NOT NULL,
   Day numeric(2) NOT NULL
)
GO


PRINT 'Create procedure InsertDWHTime'
GO
CREATE PROCEDURE InsertDWHTime
AS
	DECLARE @korektor INT
	DECLARE @data DATE, @preData DATE
	DECLARE @pnm VARCHAR(30), @anm VARCHAR(30),  @ant VARCHAR(30), @pnt VARCHAR(30)
	DECLARE @isHoliday BIT, @isPreHoliday BIT
	SELECT @korektor = 0

WHILE @korektor < 2557 -- 7 years
	BEGIN
		SELECT @data = DATEADD(DAY, @korektor, '2012-01-01')
		SELECT @preData = DATEADD(WEEK, 2, @data)

		IF EXISTS (SELECT * FROM DWH.Holiday WHERE data = @data)
		BEGIN
		   SELECT @isHoliday = 1 
		END
		ELSE
		BEGIN
			SELECT @isHoliday = 0
		END
		
		IF EXISTS (SELECT * FROM DWH.Holiday WHERE data > @data AND data <= @preData)
		BEGIN
		   SELECT @isPreHoliday = 1 
		END
		ELSE
		BEGIN
			SELECT @isPreHoliday = 0
		END
	
		INSERT INTO DWH.Time VALUES(@data, DATEPART(YEAR, @data), DATEPART(MM, @data), DATEPART(DAY, @data), @isPreHoliday, @isHoliday)
		SELECT @korektor = @korektor + 1
	END
GO