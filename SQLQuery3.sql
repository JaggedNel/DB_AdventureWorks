--Выбрать покупателей, купивших больше 5 единиц одного и того же продукта 
--Столбцы: Фамилия покупателя | Имя покупателя | Название продукта | Количество купленных экземпляров (за все время) 
--Упорядочить по имени покупателя по возрастанию, затем по количеству купленных экземпляров по убыванию

SELECT LastName, FirstName, Name, COUNT
FROM Person.Person AS PP
JOIN (
	SELECT CustomerID, Name, SUM(OrderQty) AS COUNT
	FROM Sales.SalesOrderHeader AS SSOH
	JOIN (
		SELECT SSOD.ProductID, Name, OrderQty, SalesOrderID
		FROM Sales.SalesOrderDetail AS SSOD
		JOIN (SELECT ProductID, Name FROM Production.Product) AS PP ON SSOD.ProductID = PP.ProductID
	) AS SSOD ON SSOH.SalesOrderID = SSOD.SalesOrderID
	GROUP BY CustomerID, ProductID, Name HAVING SUM(OrderQty) > 5
) AS SSOH ON PP.BusinessEntityID = SSOH.CustomerID
ORDER BY FirstName, COUNT DESC;
