-- Goal:
-- Identify the top spending customers within each country to target for VIP loyalty programs.
--
-- Tables Used:
-- customers, invoices, employees
--
-- Window Function:
-- RANK() assigns a ranking to customers within each country based on total spending.
-- A rank of 1 indicates the highest spending customer in that country.

SELECT
    c.Country,
    c.FirstName || ' ' || c.LastName AS CustomerName,
    e.FirstName || ' ' || e.LastName AS SupportRepName,
    SUM(i.Total) AS TotalSpent,
    RANK() OVER (
        PARTITION BY c.Country
        ORDER BY SUM(i.Total) DESC
    ) AS SpendingRank
FROM customers c
JOIN invoices i
    ON c.CustomerId = i.CustomerId
JOIN employees e
    ON c.SupportRepId = e.EmployeeId
WHERE c.Country IS NOT NULL
GROUP BY
    c.CustomerId,
    c.Country,
    e.EmployeeId;