






SELECT
old.ObjectID,
old.ObjectNumber,
old.Provenance AS CURRENT_Provenance,
new.Provenance AS [191008_Provenance],
d.Department

FROM [TMS_restore20191008].dbo.Objects AS new
INNER JOIN [TMS].dbo.Objects AS old ON new.ObjectID = old.ObjectID
INNER JOIN Departments AS d ON new.DepartmentID = d.DepartmentID

WHERE old.Provenance LIKE '%Ima Hogg%'
AND (old.Provenance <> new.Provenance OR new.Provenance IS NULL)

ORDER BY old.SortNumber, d.Department




