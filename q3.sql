SELECT
    State,
    COUNT(DISTINCT CustomerId) AS TotalUniqueCustomers
FROM customers
WHERE State IS NOT NULL
GROUP BY State
ORDER BY State;