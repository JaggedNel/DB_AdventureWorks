SELECT *
FROM HumanResources.Employee;
GO

--Вывести содержимое сотрудников, непосредственный руководитель которых младше и меньше работает в компании
--Столбцы: Имя руководителя | Дата приема руководителя на работу| Дата рождения руководителя |
--| Имя сотрудника | Дата приема сотрудника на работу| Дата рождения сотрудника
--Поле имя выводит в формате 'Фамилия И.О.'
--Упорядочить по руководителю от директора вниз к сотрудникам
--Внутри одного уровня иерархии упорядочить по фамилии и имени сотрудника

CREATE OR ALTER VIEW Employeers
AS
	SELECT
		BusinessEntityID,
		CASE
			WHEN OrganizationNode IS NULL
			THEN hierarchyid::GetRoot()
			ELSE OrganizationNode
		END AS OrganizationNode,
		CASE
			WHEN OrganizationLevel IS NULL
			THEN hierarchyid::GetRoot().GetLevel()
			ELSE OrganizationLevel
		END AS OrganizationLevel,
		BirthDate,
		HireDate
	FROM HumanResources.Employee
GO

SELECT *
FROM Employeers;

SELECT 
	BOSS.BusinessEntityID AS BossID,
	CONCAT(PBOSS.LastName, ' ', CAST(PBOSS.FirstName AS NVARCHAR(1)), '.', CAST(PBOSS.MiddleName AS NVARCHAR(1)), '.') AS BossName,
	BOSS.BirthDate AS BossBirthDate,
	BOSS.HireDate AS BossHireDate,
	CONCAT(PEMP.LastName, ' ', CAST(PEMP.FirstName AS NVARCHAR(1)), '.', CAST(PEMP.MiddleName AS NVARCHAR(1)), '.') AS EmpName,
	EMP.BirthDate AS EmpBirthDate,
	EMP.HireDate AS EmpHireDate
FROM Employeers AS EMP
JOIN Employeers AS BOSS ON BOSS.OrganizationNode = EMP.OrganizationNode.GetAncestor(1)
JOIN Person.Person AS PBOSS ON PBOSS.BusinessEntityID = BOSS.BusinessEntityID
JOIN Person.Person AS PEMP ON PEMP.BusinessEntityID = EMP.BusinessEntityID
WHERE BOSS.BirthDate > EMP.BirthDate AND BOSS.HireDate > EMP.HireDate
ORDER BY BOSS.BusinessEntityID, EmpName