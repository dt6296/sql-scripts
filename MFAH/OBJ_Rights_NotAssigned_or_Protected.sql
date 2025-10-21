









SELECT DISTINCT
o_ObjectID,
o.ObjectNumber,
o.SortNumber,
c_ConstituentID,
c.DisplayName,
c.AlphaSort,
oc.cx_Role,
ort.ObjRightsType

FROM MFAHv_OBJ_Constituent AS oc
INNER JOIN Constituents AS c ON oc.c_ConstituentID = c.ConstituentID
INNER JOIN Objects AS o ON o_ObjectID = o.ObjectID
LEFT OUTER JOIN MFAHv_OBJ_Rights AS ort ON o_ObjectID = ort.ObjectID

WHERE 
o.ObjectStatusID IN (2,27)	-- Accessioned Object, Blaffer Foundation Accession
AND oc.cx_RoleTypeID IN (0,1)	-- not all objects have rights records, so (not assigned) doesn't appear.  :(
AND ort.ObjRightsTypeID = 1	-- Copyright Protected

ORDER BY c.AlphaSort, o.SortNumber


--AND oc.ObjectID = 110421






/*

ObjRightsTypeID	ObjRightsType
0	(not entered)
1	Copyright Protected
2	Public Domain
3	Orphan
4	Needs Research
5	Unknown

*/





