-- Identify the worst 10% of production runs based on DefectRate.

-- For those runs, return:

-- RecordID
-- DefectRate
-- DowntimePercentage
-- ProductionCost
-- DefectStatus
-- a column called percentile_rank (0 → 1 scale)

-- 📌 Requirements
-- Use a window function to assign a percentile rank
-- Highest DefectRate = worst
-- Return only the top 10% worst runs
-- Sort by DefectRate DESC


WITH RankedRate AS (
    SELECT
    RecordID,
    DefectRate,
    DowntimePercentage,
    ProductionCost,
    DefectStatus,
    PERCENT_RANK() OVER (ORDER BY DefectRate) AS percentile_rank
    FROM dbo.ProductionData
)
SELECT
FROM RankedRate
WHERE percentile_rank >= .9
ORDER BY DefectRate DESC