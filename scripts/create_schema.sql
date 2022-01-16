--use sXXXXX;

PRINT 'Dropping table PersonSt'
DROP TABLE IF EXISTS PersonSt
GO
PRINT 'Dropping table AgeSt'
DROP TABLE IF EXISTS AgeSt
GO
PRINT 'Dropping table DeathSt'
DROP TABLE IF EXISTS DeathSt
GO
PRINT 'Dropping table InjurySt'
DROP TABLE IF EXISTS InjurySt
GO
PRINT 'Dropping table DrugTypeSt'
DROP TABLE IF EXISTS DrugTypeSt
GO
PRINT 'Dropping table TimeSt'
DROP TABLE IF EXISTS TimeSt
GO
PRINT 'Dropping table DrugDeathsSt'
DROP TABLE IF EXISTS DrugDeathsSt
GO
PRINT 'Dropping table Holiday'
DROP TABLE IF EXISTS Holiday
GO
PRINT 'Dropping procedure InsertTime'
DROP PROCEDURE IF EXISTS InsertTime
GO


PRINT 'Create table PersonSt'
CREATE TABLE PersonSt(
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


PRINT 'Create table AgeSt'
CREATE TABLE AgeSt(
   IdAge int IDENTITY(1,1) NOT NULL PRIMARY KEY,
   Age  int,
   AgeGroup varchar(20)
)
GO


PRINT 'Create table DeathSt'
CREATE TABLE DeathSt(
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


PRINT 'Create table InjurySt'
CREATE TABLE InjurySt(
   IdInjury int IDENTITY(1,1) NOT NULL PRIMARY KEY,
   DescriptionOfInjury varchar(200),
   InjuryPlace varchar(100),
   InjuryCity varchar(100),
   InjuryCounty varchar(100),
   InjuryState varchar(100),
   InjuryCityGeo varchar(150)
)
GO


PRINT 'Create table DrugTypeSt'
CREATE TABLE DrugTypeSt(
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


PRINT 'Create table TimeSt'
CREATE TABLE TimeSt (
   Data date NOT NULL PRIMARY KEY,
   Year numeric(4) NOT NULL,
   Month numeric(2) NOT NULL,
   Day numeric(2) NOT NULL,
   PreHolidayPeriod bit,
   HolidayPeriod bit
)
GO


PRINT 'Create table DrugDeathsSt'
CREATE TABLE DrugDeathsSt (
   Time date NOT NULL,
   IdDrugType int NOT NULL,
   IdPerson int NOT NULL,
   IdInjury int NOT NULL,
   IdDeath int NOT NULL,
   IdAge int NOT NULL,
   Count int NOT NULL
 CONSTRAINT [PK_DrugDeathsSt] PRIMARY KEY 
(
   Time,
   IdDrugType,
   IdPerson,
   IdInjury,
   IdDeath,
   IdAge
))
GO


PRINT 'Create table Holiday'
CREATE TABLE Holiday (
   Data date NOT NULL PRIMARY KEY,
   Year numeric(4) NOT NULL,
   Month numeric(2) NOT NULL,
   Day numeric(2) NOT NULL
)
GO


PRINT 'Create procedure InsertTime'
GO
CREATE PROCEDURE InsertTime
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

		IF EXISTS (SELECT * FROM Holiday WHERE data = @data) 
		BEGIN
		   SELECT @isHoliday = 1 
		END
		ELSE
		BEGIN
			SELECT @isHoliday = 0
		END
		
		IF EXISTS (SELECT * FROM Holiday WHERE data > @data AND data <= @preData) 
		BEGIN
		   SELECT @isPreHoliday = 1 
		END
		ELSE
		BEGIN
			SELECT @isPreHoliday = 0
		END
	
		INSERT INTO TimeSt VALUES(@data, DATEPART(YEAR, @data), DATEPART(MM, @data), DATEPART(DAY, @data), @isPreHoliday, @isHoliday)
		SELECT @korektor = @korektor + 1
	END
GO