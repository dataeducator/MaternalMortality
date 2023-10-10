--- This script adds a Caricom column to the table and updates it based on CARICOM membership.

-- Add the Caricom column to the table
ALTER TABLE [MaternalMortality].[dbo].[maternal-mortality-vs-births-attended-by-health-staff]
ADD IsCaricom BIT;

-- Update the Caricom column based on CARICOM membership
-- This section sets the Caricom column to 1 for CARICOM member countries and 0 for non-members.
UPDATE [MaternalMortality].[dbo].[maternal-mortality-vs-births-attended-by-health-staff]
SET IsCaricom = CASE
    WHEN Entity IN ('Antigua and Barbuda', 'Bahamas', 'Barbados', 'Belize', 'Dominica',
                     'Grenada', 'Guyana', 'Haiti', 'Jamaica', 'Montserrat', 'Saint Kitts and Nevis',
                     'Saint Lucia', 'Saint Vincent and the Grenadines', 'Suriname', 'Trinidad and Tobago')
    THEN 1 -- 1 represents a CARICOM member
    ELSE 0 -- 0 represents a non-CARICOM member
END;

-- This section retrieves data for CARICOM Members from the table with additional aliases for clarity.
SELECT
    Entity AS Country,
    Year AS Date,
    Maternal_mortality_ratio_modeled_estimate_per_100_000_live_births AS MaternalMortalityRate,
    Births_attended_by_skilled_health_staff_of_total AS BirthsAttendedByHealthStaff,
    IsCaricom
FROM
    MaternalMortality.dbo.[maternal-mortality-vs-births-attended-by-health-staff]
WHERE
    IsCaricom = 1
-- The query filters data for CARICOM member countries.
ORDER BY
    Country, Date DESC;

-- This section retrieves data for CARICOM Members from the table with additional aliases for clarity.
SELECT
    Entity AS Country,
    Year AS Date,
    Maternal_mortality_ratio_modeled_estimate_per_100_000_live_births AS MaternalMortalityRate,
    Births_attended_by_skilled_health_staff_of_total AS BirthsAttendedByHealthStaff,
    IsCaricom
FROM
    MaternalMortality.dbo.[maternal-mortality-vs-births-attended-by-health-staff]
WHERE
    IsCaricom = 0
-- The query filters data for CARICOM member countries.
ORDER BY
    Country, Date DESC;