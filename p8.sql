-- Finance now wants to know the most expensive runs within each defect group, 
-- not just overall.

-- Write a query that returns the top 3 most expensive production runs for each
--  DefectStatus.

-- For each row, show:

-- DefectStatus
-- RecordID
-- ProductionCost
-- ProductionVolume
-- DefectRate
-- DowntimePercentage
-- a ranking column called cost_rank
-- Requirements
-- Ranking should restart for each DefectStatus
-- Highest ProductionCost gets rank 1
-- Return only ranks 1 through 3 for each defect group
-- Sort by:
-- DefectStatus
-- cost_rank


WITH RankedRuns AS(
    SELECT DefectStatus, 
    RecordID, 
    ProductionCost, 
    ProductionVolume, 
    DefectRate, 
    DowntimePercentage,
    ROW_NUMBER()
        OVER (PARTITION BY DefectStatus ORDER BY ProductionCost DESC) AS cost_rank
    FROM dbo.ProductionData
)
SELECT *
FROM RankedRuns
WHERE cost_rank <= 3
ORDER BY DefectStatus, cost_rank

