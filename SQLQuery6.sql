--Написать хранимую процедуру, с тремя параметрами
--входной параметр - две даты, с и по
--выходной параметр - количество найденных записей
--Результирующий набор содержит записи всех холостых мужчин-сотрудников, родившихся в диапазон указанных дат

CREATE OR ALTER PROCEDURE Employers (
	@left AS DATE,
	@right AS DATE,
	@count AS INT OUTPUT
)
AS
BEGIN
	SELECT *
	INTO #NewEmployee
	FROM HumanResources.Employee
	WHERE Gender = 'M' AND MaritalStatus = 'S' AND BirthDate BETWEEN @left AND @right
	SELECT @count = COUNT(*)
	FROM #NewEmployee
	SELECT * FROM #NewEmployee
END
GO

DECLARE @Left AS DATE
DECLARE @Right AS DATE
DECLARE @Count AS INT

SET @Left = '1974-12-23'
SET @Right = '1981-08-03'

EXEC Employers @Left, @Right, @Count OUTPUT

PRINT @Count