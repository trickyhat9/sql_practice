CREATE DATABASE defect_data;
GO

CREATE TABLE ProductionData (
    RecordID INT IDENTITY(1,1) PRIMARY KEY,
    ProductionVolume INT,
    ProductionCost DECIMAL(12,4),
    SupplierQuality DECIMAL(10,6),
    DeliveryDelay INT,
    DefectRate DECIMAL(10,6),
    QualityScore DECIMAL(10,6),
    MaintenanceHours INT,
    DowntimePercentage DECIMAL(10,6),
    InventoryTurnover DECIMAL(10,6),
    StockoutRate DECIMAL(10,6),
    WorkerProductivity DECIMAL(10,6),
    SafetyIncidents INT,
    EnergyConsumption DECIMAL(12,4),
    EnergyEfficiency DECIMAL(10,6),
    AdditiveProcessTime DECIMAL(10,6),
    AdditiveMaterialCost DECIMAL(12,4),
    DefectStatus BIT
);
GO


USE defect_data;
GO

IF OBJECT_ID('dbo.ProductionData_Staging', 'U') IS NOT NULL
	DROP TABLE dbo.ProductionData_Staging;

CREATE TABLE dbo.ProductionData_Staging (
	ProductionVolume INT,
	ProductionCost FLOAT,
	SupplierQuality FLOAT,
	DeliveryDelay INT,
	DefectRate FLOAT,
	QualityScore FLOAT,
	MaintenanceHours INT,
	DowntimePercentage FLOAT,
	InventoryTurnover FLOAT,
	StockoutRate FLOAT,
	WorkerProductivity FLOAT,
	SafetyIncidents INT,
	EnergyConsumption FLOAT,
	EnergyEfficiency FLOAT,
	AdditiveProcessTime FLOAT,
	AdditiveMaterialCost FLOAT,
	DefectStatus BIT
);
GO

BULK INSERT dbo.ProductionData_Staging
FROM 'D:\sql_stuff\manufacturing_defect_dataset.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '0x0a',
	TABLOCK
);
GO

INSERT INTO dbo.ProductionData
    (ProductionVolume, ProductionCost, SupplierQuality, DeliveryDelay,
     DefectRate, QualityScore, MaintenanceHours, DowntimePercentage,
     InventoryTurnover, StockoutRate, WorkerProductivity, SafetyIncidents,
     EnergyConsumption, EnergyEfficiency, AdditiveProcessTime,
     AdditiveMaterialCost, DefectStatus)
SELECT
     ProductionVolume, ProductionCost, SupplierQuality, DeliveryDelay,
     DefectRate, QualityScore, MaintenanceHours, DowntimePercentage,
     InventoryTurnover, StockoutRate, WorkerProductivity, SafetyIncidents,
     EnergyConsumption, EnergyEfficiency, AdditiveProcessTime,
     AdditiveMaterialCost, DefectStatus
FROM dbo.ProductionData_Staging;
GO

DROP TABLE dbo.ProductionData_Staging;
GO