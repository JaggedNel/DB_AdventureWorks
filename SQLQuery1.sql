--Вывести общую сумму продаж с разбивкой по месяцам, за все время работы компании

SELECT DATEADD(MONTH, DATEDIFF(MONTH, 0, s.OrderDate), 0) AS Month, SUM(s.SubTotal) AS Total
FROM Sales.SalesOrderHeader AS s
GROUP BY DATEADD(MONTH, DATEDIFF(MONTH, 0, s.OrderDate), 0)
ORDER BY Month;
