CREATE VIEW [dbo].[vw_MonthlySpendingByCategory] AS
SELECT 
    PrimaryCategory,
    SUM(Amount) as Amount,
    YEAR([Date]) as Year,
    MONTH([Date]) as Month
FROM [Transaction]
GROUP BY 
    PrimaryCategory,
    YEAR([Date]),
    MONTH([Date])
GO
GRANT SELECT
    ON OBJECT::[dbo].[vw_MonthlySpendingByCategory] TO [dr_PennywiseAPI]
    AS [dbo];

