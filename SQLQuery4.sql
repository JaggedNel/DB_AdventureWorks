--Вывести содержимое первого заказа каждого клиента
--Столбцы: Дата заказа | Фамилия покупателя | Имя покупателя | Содержимое заказа
--Упорядочить по дате заказа от новых к старым
--В столбец содержимого заказа нужно объединить все элементы заказа в следующем формате:
--<Имя товара> Количество: <количество в заказе> шт.
--<Имя товара> Количество: <количество в заказе> шт.
--<Имя товара> Количество: <количество в заказе> шт.
--...

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
GO

 SELECT OrderDate, LastName, FirstName, dbo.mywrite(SalesOrderID)
 FROM Sales.SalesOrderHeader As SSOH
 JOIN Person.Person AS PP ON PP.BusinessEntityID = SSOH.CustomerID
 WHERE SSOH.OrderDate = (
	SELECT MIN(SSOH2.OrderDate) FROM Sales.SalesOrderHeader AS SSOH2 WHERE SSOH.CustomerID = SSOH2.CustomerID
)
ORDER BY OrderDate DESC
