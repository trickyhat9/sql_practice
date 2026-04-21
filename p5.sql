-- One of the shift managers swears that runs with high 
-- maintenance hours are the problem — his theory is that when machines 
-- need a lot of upkeep, everything else goes sideways too: more defects, 
-- more downtime, more safety issues.
-- Help me test his theory. Bucket every production run 
-- into three categories based on MaintenanceHours:

-- Low: less than 8 hours
-- Medium: 8 to 16 hours (inclusive)
-- High: more than 16 hours

-- For each bucket, show me:

-- The bucket name
-- The number of runs in that bucket
-- Average defect rate
-- Average downtime percentage
-- Average safety incidents

-- Sort the output so Low comes first, then Medium, then High.

WITH Buckets AS (
    SELECT
        CASE 
            WHEN MaintenanceHours < 8 THEN 'Low'
            WHEN MaintenanceHours BETWEEN 8 AND 16 THEN 'Medium'
            ELSE 'High'
        END AS MaintenanceBucket,
        DefectRate,
        DowntimePercentage,
        CAST(SafetyIncidents AS DECIMAL(10,2)) AS SafetyIncidents
    FROM dbo.ProductionData
)
SELECT
    MaintenanceBucket,
    COUNT(*) AS runs,
    AVG(DefectRate) AS avg_defect_rate,
    AVG(DowntimePercentage) AS avg_downtime_percent,
    AVG(SafetyIncidents) AS avg_safety_incidents
FROM Buckets
GROUP BY MaintenanceBucket
ORDER BY
    CASE
        WHEN MaintenanceBucket = 'Low' THEN 1
        WHEN MaintenanceBucket = 'Medium' THEN 2
        WHEN MaintenanceBucket = 'High' THEN 3
    END;


-- the final case is attaching invisible row for order by purposes
-- remember to use else for last statement
-- here we use case in SELECT, GROUP BY, and ORDER BY
-- CAST( AS DECIMAL(x, y))

