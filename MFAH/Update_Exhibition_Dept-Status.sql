




SELECT * FROM Departments WHERE MainTableID = 47

SELECT * FROM ExhibitionStatuses



SELECT
e.ExhDepartment,
d.Department,
COUNT(*) AS ExhCount
FROM Exhibitions AS e
INNER JOIN Departments AS d ON e.ExhDepartment = d.DepartmentID
GROUP BY
e.ExhDepartment,
d.Department





SELECT
d.DepartmentID,
d.Department,
es.ExhibitionStatusID,
es.ExhibitionStatus

FROM Departments AS d
INNER JOIN ExhibitionStatuses AS es ON d.Department = es.ExhibitionStatus

WHERE d.MainTableID = 47



--UPDATE Exhibitions SET ExhibitionStatusID = es.ExhibitionStatusID
--SELECT e.ExhibitionID, es.ExhibitionStatusID, es.ExhibitionStatus, e.ExhDepartment, d.DepartmentID, d.Department
FROM Exhibitions AS e
INNER JOIN Departments AS d ON e.ExhDepartment = d.DepartmentID AND d.MainTableID = 47
INNER JOIN ExhibitionStatuses AS es ON es.ExhibitionStatus = d.Department




SELECT * FROM Departments WHERE MainTableID = 47



DepartmentID = 171 -- Closed

--UPDATE Exhibitions SET ExhDepartment = 171
--SELECT e.ExhibitionID, e.ExhDepartment, d.Department, e.ExhTitle, e.BeginISODate, e.EndISODate
FROM Exhibitions AS e
INNER JOIN Departments AS d ON e.ExhDepartment = d.DepartmentID
WHERE e.EndISODate < '2019-04'
ORDER BY e.EndISODate DESC



DepartmentID = 169 -- Current

--UPDATE Exhibitions SET ExhDepartment = 169
--SELECT e.ExhibitionID, e.ExhDepartment, d.Department, e.ExhTitle, e.BeginISODate, e.EndISODate
FROM Exhibitions AS e
INNER JOIN Departments AS d ON e.ExhDepartment = d.DepartmentID
WHERE e.EndISODate >= '2019-04'
AND e.BeginISODate < '2019-04'
ORDER BY e.EndISODate DESC



DepartmentID = 168 -- Planning

--UPDATE Exhibitions SET ExhDepartment = 168
--SELECT e.ExhibitionID, e.ExhDepartment, d.Department, e.ExhTitle, e.BeginISODate, e.EndISODate
FROM Exhibitions AS e
INNER JOIN Departments AS d ON e.ExhDepartment = d.DepartmentID
WHERE e.EndISODate >= '2019-04'
AND e.BeginISODate > '2019-04-01'
ORDER BY e.EndISODate DESC