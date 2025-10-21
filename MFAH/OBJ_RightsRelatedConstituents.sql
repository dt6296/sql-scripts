

SELECT
obr.*
FROM ObjRights AS obr
WHERE obr.ObjRightsID IN
(
	SELECT cx.ID
	FROM	ConXrefs	AS cx	
	LEFT OUTER JOIN Roles AS r ON cx.RoleID = r.RoleID
	WHERE cx.TableID = 126
)



SELECT DISTINCT cx.RoleTypeID, rt.RoleType, r.Role, cx.TableID, ddt.TableName FROM ConXrefs AS cx
LEFT OUTER JOIN RoleTypes AS rt ON cx.RoleTypeID = rt.RoleTypeID
LEFT OUTER JOIN Roles AS r ON cx.RoleID = r.RoleID
LEFT OUTER JOIN DDTables AS ddt ON cx.TableID = ddt.TableID
ORDER BY rt.RoleType, r.Role