

CREATE OR ALTER FUNCTION dbo.mywrite 
(@order_id int)
RETURNS VARCHAR(1000)
AS
BEGIN
	DECLARE @RES VARCHAR(1000)
	SET @RES = ''
	SELECT @RES = @RES + CONCAT(Name, ' Count: ', OrderQty, ' pcs.')
	FROM Sales.SalesOrderDetail AS SSOD
	JOIN Production.Product AS PP ON PP.ProductID = SSOD.ProductID
	WHERE SSOD.SalesOrderID = @order_id
	RETURN @RES
END

 SELECT OrderDate, LastName, FirstName, dbo.mywrite(SalesOrderID)
 FROM Sales.SalesOrderHeader As SSOH
 JOIN Person.Person AS PP ON PP.BusinessEntityID = SSOH.CustomerID
 WHERE SSOH.OrderDate = (
	SELECT MIN(SSOH2.OrderDate) FROM Sales.SalesOrderHeader AS SSOH2 WHERE SSOH.CustomerID = SSOH2.CustomerID
)
ORDER BY OrderDate DESC