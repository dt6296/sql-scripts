
SELECT 
d.Department,
COUNT(o.ObjectID)	AS ObjectCount,
o.IsVirtual 


FROM [Objects] AS o
LEFT OUTER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID
LEFT OUTER JOIN ObjectStatuses AS os ON o.ObjectStatusID = os.ObjectStatusID

WHERE os.ObjectStatusID IN (2,27)

GROUP BY d.Department, o.IsVirtual

ORDER BY d.Department