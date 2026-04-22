-- The plant director now wants to understand:

-- “What factors are most different between bad runs and normal runs?”

-- Define:

-- Bad runs = runs where BOTH:
-- DefectRate > average
-- DowntimePercentage > average
-- Normal runs = everything else
-- Your task

-- Return a comparison table with 2 rows:

-- Bad Runs
-- Normal Runs

-- For each group, show:

-- number of runs
-- average production cost
-- average supplier quality
-- average maintenance hours
-- average worker productivity
-- average energy consumption

WITH Averages AS (
    SELECT
        AVG(DefectRate) AS avg_defect_rate,
        AVG(DowntimePercentage) AS avg_downtime_percent
    FROM dbo.ProductionData
)
SELECT
    CASE
        WHEN p.defectRate > a.avg_defect_rate
        AND p.DowntimePercentage > a.avg_downtime_percent
        THEN 'Bad Runs'
        ELSE 'Normal Runs'
    END AS RunType,

    COUNT(*) AS runs,
    AVG(p.ProductionCost) AS avg_cost,
    AVG(p.SupplierQuality) AS avg_supplier_quality,
    AVG(p.MaintenanceHours) AS avg_maintenance,
    AVG(p.WorkerProductivity) AS avg_productivity,
    AVG(p.EnergyConsumption) AS avg_energy

FROM dbo.ProductionData p
CROSS JOIN Averages a
GROUP BY
    CASE
        WHEN p.DefectRate > a.avg_defect_rate
        AND p.DowntimePercentage > a.avg_downtime_percent
        THEN 'Bad Runs'
        ELSE 'Normal Runs'
    END


-- nothing notable here