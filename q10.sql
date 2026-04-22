-- The operations team doesn’t just care about high defect rates — 
-- they care about runs that are getting worse over time.

-- 🧠 Problem

-- For each DefectStatus, analyze how DefectRate changes as 
-- ProductionVolume increases.

-- Write a query that:

-- Orders runs within each DefectStatus by ProductionVolume (ascending)
-- For each row, compares its DefectRate to the previous row’s DefectRate
-- Returns only runs where:
-- the current DefectRate is higher than the previous one
-- 📌 Return:
-- DefectStatus
-- RecordID
-- ProductionVolume
-- DefectRate
-- previous_defect_rate
-- defect_rate_change (current - previous)

-- 📊 Requirements
-- Use a window function to access the previous row
-- Only include rows where defect rate increased
-- Sort by:
-- DefectStatus
-- ProductionVolume



WITH RunsWithPrevious AS (
    SELECT
    DefectStatus,
    RecordID,
    ProductionVolume,
    DefectRate,
    LAG(DefectRate) OVER (
        PARTITION BY DefectStatus
        OVER BY ProductionVolume
    ) AS previous_defect_rate
    FROM dbo.ProductionData
)
SELECT
    DefectStatus,
    RecordID,
    ProductionVolume,
    DefectRate,
    previous_defect_rate,
    ROUND(DefectRate - previous_defect_rate, 2) AS defect_rate_change
FROM RunsWithPrevious
WHERE DefectRate > previous_defect_rate
ORDER BY DefectStatus, ProductionVolume;