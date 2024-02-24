create VIEW [dbo].[vw_AverageMonthlySpending] AS
SELECT
  PrimaryCategory as Category,
  SUM(CASE WHEN [Date] >= DATEADD(MONTH,-3,GETDATE()) THEN Amount END)/3 AS Avg3MonthSpending,
  SUM(CASE WHEN [Date] >= DATEADD(MONTH,-6,GETDATE()) THEN Amount END)/6 AS Avg6MonthSpending,
  SUM(CASE WHEN [Date] >= DATEADD(MONTH,-12,GETDATE()) THEN Amount END)/12 AS Avg12MonthSpending
FROM (
  SELECT
    PrimaryCategory,
    CONCAT(YEAR([Date]), '-', MONTH([Date])) AS year_month,
    [Date],
    SUM(amount) AS amount
  FROM [transaction]
  GROUP BY PrimaryCategory, CONCAT(YEAR([Date]), '-', MONTH([Date])), [Date]
) AS monthly_totals
GROUP BY PrimaryCategory;
GO
GRANT SELECT
    ON OBJECT::[dbo].[vw_AverageMonthlySpending] TO [dr_PennywiseAPI]
    AS [dbo];

