
-- Accessioned objects that do not have "Artist" displayed
-- Mostly Dec Arts and Bayou Bend


SELECT o.ObjectID, o.ObjectNumber, o.SortNumber, d.Department, COUNT(cxd.ConXrefDetailID), SUM(cx.Displayed)
FROM Objects AS o
INNER JOIN ConXrefs AS cx ON o.ObjectID = cx.ID AND cx.TableID = 108
INNER JOIN ConXrefDetails AS cxd ON cx.ConXrefID = cxd.ConXrefID
INNER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID
WHERE cxd.UnMasked = 1
AND cx.RoleID = 1
AND o.ObjectStatusID IN (2,27)
GROUP BY o.ObjectID, o.ObjectNumber, o.SortNumber, d.Department
HAVING SUM(cx.Displayed) = 0
ORDER BY d.Department, o.SortNumber













