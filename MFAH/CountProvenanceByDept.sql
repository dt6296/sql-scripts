
SELECT 
d.DepartmentPublic,
CASE WHEN o.Provenance = '' OR o.Provenance IS NULL THEN 0 ELSE 1 END AS Provenance,
COUNT(*)

FROM Objects AS o
INNER JOIN MFAHt_DepartmentPublic AS d ON o.DepartmentID = d.DepartmentID

WHERE o.ObjectStatusID IN (2,27)

GROUP BY
d.DepartmentPublic,
CASE WHEN o.Provenance = '' OR o.Provenance IS NULL THEN 0 ELSE 1 END





