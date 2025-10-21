
SELECT
c.ConstituentID,
c.DisplayName,
c.AlphaSort,
COUNT(*) AS ObjectCount
--,o.ObjectID,o.ObjectNumber,cx.RoleID,r.Role,d.Department

FROM Constituents AS c
INNER JOIN ConXrefDetails AS cxd ON c.ConstituentID = cxd.ConstituentID
INNER JOIN ConXrefs AS cx ON cxd.ConXrefid = cx.ConXrefID
INNER JOIN Objects AS o ON cx.ID = o.ObjectID AND cx.TableID = 108
INNER JOIN Roles AS r ON cx.RoleID = r.RoleID
INNER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID

WHERE cx.RoleTypeID = 1
AND cxd.UnMasked = 1
AND o.ObjectStatusID = 2
AND o.DepartmentID = 11 --	 Photography

GROUP BY
c.ConstituentID,
c.DisplayName,
c.AlphaSort

HAVING COUNT(*) > 10

ORDER BY c.AlphaSort



