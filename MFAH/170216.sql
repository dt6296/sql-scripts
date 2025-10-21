
SELECT
cx.*
FROM ConXrefs AS cx 
INNER JOIN ObjRights AS ort ON cx.ID = ort.ObjRightsID AND cx.TableID = 126
INNER JOIN PackageList AS pl ON pl.ID = ort.ObjectID AND pl.TableID = 108
WHERE	cx.RoleID = 425
AND		pl.PackageID = 116282
AND		cx.TableID = 126 
AND		cx.RoleTypeID = 19
AND ort.ObjectID NOT IN
(
	SELECT 
	ort.ObjectID
	FROM ConXrefs AS cx 
	INNER JOIN ObjRights AS ort ON cx.ID = ort.ObjRightsID AND cx.TableID = 126
	INNER JOIN PackageList AS pl ON pl.ID = ort.ObjectID AND pl.TableID = 108
	WHERE	cx.RoleID = 425
	AND		pl.PackageID = 116282														--36 ConXref rows already exist
)





