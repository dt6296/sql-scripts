



SELECT
oc.o_ObjectID AS ObjectID,
oc.can_DisplayName,
oc.cxd_Remarks
FROM MFAHv_OBJ_Constituent AS oc 
WHERE oc.o_ObjectID = 110421
AND cx_RoleTypeID = 5
AND cx_Active = 1
AND cx_Displayed = 1



SELECT TOP 100
oc.o_ObjectID AS ObjectID,
STUFF((	SELECT '  ' + oc2.cxd_Remarks
		FROM MFAHv_OBJ_Constituent AS oc2
		WHERE oc2.o_ObjectID = 110421 
		AND oc2.cx_RoleTypeID = 5
		FOR XML PATH ('')),1,2,'') AS Provenance

FROM MFAHv_OBJ_Constituent AS oc

WHERE oc.o_ObjectID = 110421
--AND oc.cx_RoleTypeID = 5
GROUP BY oc.o_ObjectID












