-- Finance is breathing down my neck about production costs. 
-- Before I go back to them, I need to understand the spread — can you pull me the 
-- minimum, maximum, and average ProductionCost across all our runs? 
-- Also throw in the total number of records so I know what we're averaging over.
-- I want it all in a single row with four columns.


SELECT MIN(ProductionCost) AS lowest_cost, MAX(ProductionCost) AS highest_cost, AVG(ProductionCost) AS avg_cost, COUNT(*) AS total_records
FROM dbo.ProductionData


-- 3240 total production runs
-- costs range from 5-20k per run - 4x spread is large
-- avg is 12.4k