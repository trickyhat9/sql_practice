-- The plant director wants to identify production runs that are performing 
-- worse than average on both quality and downtime.

-- Write a query to return all runs where:

-- DefectRate is greater than the overall average DefectRate
-- and
-- DowntimePercentage is greater than the overall average DowntimePercentage

-- For each matching run, show:

-- RecordID
-- ProductionVolume
-- DefectRate
-- DowntimePercentage
-- MaintenanceHours
-- DefectStatus

-- Also include two extra calculated columns:

-- DefectRateDifference = run’s DefectRate minus the overall average DefectRate
-- DowntimeDifference = run’s DowntimePercentage minus the overall average 
-- DowntimePercentage

-- Sort by:

-- highest DefectRateDifference first
-- then highest DowntimeDifference

-- Round the two difference columns to 2 decimals.


WITH Averages AS (
    SELECT
        AVG(DefectRate) AS avg_defect_rate,
        AVG(DowntimePercentage) AS avg_downtime_percent
    FROM dbo.ProductionData
)
SELECT
    p.RecordID,
    p.ProductionVolume,
    p.DefectRate,
    p.DowntimePercentage,
    p.MaintenanceHours,
    p.DefectStatus,
    ROUND(p.DefectRate - a.avg_defect_rate, 2) AS DefectRateDifference,
    ROUND(p.DowntimePercentage - a.avg_downtime_percent, 2) AS DowntimeDifference
FROM dbo.ProductionData p
CROSS JOIN Averages a
WHERE p.DefectRate > a.avg_defect_rate
AND p.DowntimePercentage > a.avg_downtime_percent
ORDER BY DefectRateDifference DESC, DowntimeDifference DESC


-- The worst-performing runs are not driven by maintenance hours alone.
-- “What actually drives bad runs?”