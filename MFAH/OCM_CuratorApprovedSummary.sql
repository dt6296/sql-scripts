

SELECT 
COUNT(*) AS ObjectCount,
CuratorApproved
FROM Objects
WHERE ObjectStatusID IN (2,27)
GROUP BY CuratorApproved

SELECT 
COUNT(*) AS ObjectCount,
CuratorApproved,
Department
FROM Objects AS o
INNER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID
WHERE ObjectStatusID IN (2,27)
AND PublicAccess = 1
GROUP BY CuratorApproved, Department


SELECT COUNT(*)
FROM Objects
WHERE ObjectStatusID IN (2,27)
AND PublicAccess = 1


--------------------------------------------------


SELECT COUNT(*) AS ObjectCount, 
d.DepartmentPublic, 
o.CuratorApproved
FROM Objects AS o
LEFT OUTER JOIN MFAHt_DepartmentPublic AS d ON o.DepartmentID = d.DepartmentID
WHERE o.ObjectStatusID IN (2,27)
AND PublicAccess = 1
GROUP BY d.DepartmentPublic, o.CuratorApproved
ORDER BY DepartmentPublic