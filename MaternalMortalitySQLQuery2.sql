-- Query 1: Retrieve the first 10 rows from the table and export to CSV.
SELECT TOP 10 *
FROM MaternalMortality.dbo.[maternal-mortality-vs-births-attended-by-health-staff]

-- Delete Duplicate Column
--ALTER TABLE MaternalMortality.dbo.[maternal-mortality-vs-births-attended-by-health-staff]
--DROP COLUMN Caricom;

-- Query 2: Calculate the average maternal mortality rate for CARICOM member countries.
SELECT AVG(Maternal_mortality_ratio_modeled_estimate_per_100_000_live_births) AS AvgMaternalMortalityRate
FROM MaternalMortality.dbo.[maternal-mortality-vs-births-attended-by-health-staff]
WHERE IsCaricom = 1;

-- Query 3: Retrieve data for a specific year range (e.g., 2010 to 2015).
SELECT *
FROM MaternalMortality.dbo.[maternal-mortality-vs-births-attended-by-health-staff]
WHERE Year BETWEEN 2010 AND 2015;

-- Query 4: Count the number of CARICOM and non-CARICOM countries.
SELECT IsCaricom, COUNT(*) AS CountryCount
FROM MaternalMortality.dbo.[maternal-mortality-vs-births-attended-by-health-staff]
GROUP BY IsCaricom;

-- Query 5: Rank CARICOM countries by maternal mortality rate.
SELECT Entity AS Country,	
       Year, 
	   Maternal_mortality_ratio_modeled_estimate_per_100_000_live_births AS MaternalMortalityRate,
RANK() OVER (PARTITION BY IsCaricom ORDER BY Maternal_mortality_ratio_modeled_estimate_per_100_000_live_births) AS Ranking
FROM MaternalMortality.dbo.[maternal-mortality-vs-births-attended-by-health-staff]
WHERE IsCaricom = 1 AND Year = 2013 AND Maternal_mortality_ratio_modeled_estimate_per_100_000_live_births IS NOT NULL; 

-- Query 6: Show the distribution of births attended by health staff, including Country and IsCaricom columns.
SELECT Entity AS Country, Year, IsCaricom, Births_attended_by_skilled_health_staff_of_total AS BirthsAttendedPercent, COUNT(*) AS Count
FROM MaternalMortality.dbo.[maternal-mortality-vs-births-attended-by-health-staff]
GROUP BY Entity, IsCaricom, Births_attended_by_skilled_health_staff_of_total, Year
ORDER BY Year DESC, Entity, IsCaricom, BirthsAttendedPercent;

-- Query 7: Calculate the year-wise change in maternal mortality rate.
SELECT Year, Maternal_mortality_ratio_modeled_estimate_per_100_000_live_births,
LAG(Maternal_mortality_ratio_modeled_estimate_per_100_000_live_births) OVER (ORDER BY Year) AS PreviousYearRate
FROM MaternalMortality.dbo.[maternal-mortality-vs-births-attended-by-health-staff];

-- Query 8: Find the maximum maternal mortality rate for CARICOM and non-CARICOM countries separately.
SELECT Caricom, MAX(Maternal_mortality_ratio_modeled_estimate_per_100_000_live_births) AS MaxMaternalMortalityRate
FROM MaternalMortality.dbo.[maternal-mortality-vs-births-attended-by-health-staff]
GROUP BY Caricom;

-- Query 9: Compare maternal mortality rates between two specific countries (e.g., Jamaica and Haiti).
SELECT Entity AS Country, Year,
Maternal_mortality_ratio_modeled_estimate_per_100_000_live_births AS MaternalMortalityRate
FROM MaternalMortality.dbo.[maternal-mortality-vs-births-attended-by-health-staff]
WHERE Entity IN ('Bahamas', 'United States');
