-- Hey, I'm prepping for the quarterly review next week and I need a quick headline number. 
-- Can you tell me what percentage of our production runs ended up defective? 
-- I just want a single number — the overall defect rate across all records.
-- Show me your result as a percentage (e.g., 42.35%), not a decimal.

-- Manager wants to know the percent of production runs defective.
-- Can use DefectStatus to calculate
-- Rounded 2 decimals?

SELECT ROUND(SUM(CASE WHEN DefectStatus = 1 THEN 1 ELSE 0 END) * 100.00 / COUNT(*), 2) AS defect_percent
FROM dbo.ProductionData;


-- 84.04% defect rate