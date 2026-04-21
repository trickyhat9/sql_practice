-- Okay, follow-up question from finance. The VP has a hunch that defective 
-- runs are dragging our cost numbers up. 
-- Can you check whether production runs flagged as defective actually cost 
-- more on average than non-defective ones?
-- I want a breakdown by DefectStatus showing:

-- The defect status (0 or 1)
-- The number of runs in each group
-- The average production cost for each group
-- The average defect rate for each group

-- Two rows total. Round the averages to something readable.


SELECT DefectStatus, COUNT(*) AS Runs, AVG(ProductionCost) AS avg_prod_cost, AVG(DefectRate) AS avg_defect_rate
FROM dbo.ProductionData
GROUP BY DefectStatus

-- Defective runs cost 314$ more on avg
-- 314/12159 = 2.6% higher cost
-- defective runs are costing us 2.6% more, insignifigant