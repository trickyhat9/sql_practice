-- Okay, so cost isn't explained by defect status.
-- Finance still wants to understand what does drive cost.
-- Can you help me find runs that are outliers on the high end?
-- Pull me the top 10 most expensive production runs, and for each one show me:

-- RecordID
-- ProductionVolume
-- ProductionCost
-- DefectRate
-- EnergyConsumption
-- DefectStatus

-- Sort so the most expensive is at the top.

SELECT TOP 10 RecordID, ProductionVolume, ProductionCost, DefectRate, EnergyConsumption, DefectStatus
FROM dbo.ProductionData
ORDER BY ProductionCost DESC

-- all top 10 runs are defective
-- BUT base rate is 84%, so remember that a pattern may look dramatic until you check base rate
-- expensive runs arent just 'big' 100 - 936
-- DefectRate all over the map 0.6 to 4.4
-- energyconsumption ranges 1300 - 4500 - 3x spread