SELECT TOP 10 City, Count(*) As Count
FROM Sales.Customer AS SC
JOIN Person.BusinessEntityAddress AS PBEA ON PBEA.BusinessEntityID = SC.PersonID
JOIN Person.Address AS PA ON PA.AddressID = PBEA.AddressID
WHERE City NOT IN (
	SELECT City
	FROM Sales.Store AS SS
	JOIN Person.BusinessEntityAddress AS PBEA ON PBEA.BusinessEntityID = SS.BusinessEntityID
	JOIN Person.Address AS PA ON PA.AddressID = PBEA.AddressID
)
GROUP BY City
ORDER BY Count DESC