




-- *****


SELECT
o.ObjectID,
o.ObjectNumber,
ot.ArtistMaker,
orr.ObjRightsTypeID,
ort.ObjRightsType

FROM Objects AS o
INNER JOIN MFAHv_OBJ_Tombstone2 AS ot ON o.ObjectID = ot.ObjectID
LEFT OUTER JOIN ObjRights AS orr ON o.ObjectID = orr.ObjectID
LEFT OUTER JOIN ObjRightsTypes AS ort ON orr.ObjRightsTypeID = ort.ObjRightsTypeID

WHERE o.ObjectStatusID IN (2,27)
--AND orr.ObjectID IS NULL			-- No rights record


-- *****


SELECT
o.ObjectID,
o.ObjectNumber,
ot.ArtistMaker

FROM Objects AS o
INNER JOIN MFAHv_OBJ_Tombstone2 AS ot ON o.ObjectID = ot.ObjectID
LEFT OUTER JOIN ObjRights AS ort ON o.ObjectID = ort.ObjectID

WHERE o.ObjectStatusID IN (2,27)
AND ort.ObjRightsTypeID = 0			-- (not entered)


SELECT
o.ObjectID,
o.ObjectNumber,
ot.ArtistMaker

FROM Objects AS o
INNER JOIN MFAHv_OBJ_Tombstone2 AS ot ON o.ObjectID = ot.ObjectID
LEFT OUTER JOIN ObjRights AS ort ON o.ObjectID = ort.ObjectID

WHERE o.ObjectStatusID IN (2,27)
AND ort.ObjRightsTypeID = 0			-- (not entered)



SELECT
o.ObjectID,
o.ObjectNumber,
ot.ArtistMaker

FROM Objects AS o
INNER JOIN MFAHv_OBJ_Tombstone2 AS ot ON o.ObjectID = ot.ObjectID
LEFT OUTER JOIN ObjRights AS ort ON o.ObjectID = ort.ObjectID

WHERE o.ObjectStatusID IN (2,27)
AND ort.ObjRightsTypeID <> 0			-- (not entered)








SELECT * FROM ObjRightsTypes







SELECT
o.ObjectID,
o.ObjectNumber,
ot.ArtistMaker,
CASE WHEN orr.ObjRightsID IS NULL THEN 'No' ELSE 'Yes' END AS HasRightsRecord,
ort.ObjRightsTypeID,
ort.ObjRightsType,
ot.Department,
ot.Classification

FROM Objects AS o
INNER JOIN MFAHv_OBJ_Tombstone2 AS ot ON o.ObjectID = ot.ObjectID
LEFT OUTER JOIN ObjRights AS orr ON o.ObjectID = orr.ObjectID
LEFT OUTER JOIN ObjRightsTypes AS ort ON orr.ObjRightsTypeID = ort.ObjRightsTypeID

WHERE o.ObjectStatusID IN (2,27)









SELECT
o.ObjectID,
o.ObjectNumber,
oc.c_ConstituentID,
oc.c_DisplayArtistMaker,
oc.can_AlphaSort,
oc.c_BeginDate,
oc.c_EndDate,
CASE WHEN orr.ObjRightsID IS NULL THEN 'No' ELSE 'Yes' END AS HasRightsRecord,
ort.ObjRightsTypeID,
CASE WHEN ort.ObjRightsType IS NULL THEN '(not entered)' ELSE ort.ObjRightsType END AS RightsType,
ort.ObjRightsType,
ot.Department,
ot.Classification

FROM Objects AS o
INNER JOIN MFAHv_OBJ_Tombstone2 AS ot ON o.ObjectID = ot.ObjectID
LEFT OUTER JOIN ObjRights AS orr ON o.ObjectID = orr.ObjectID
LEFT OUTER JOIN ObjRightsTypes AS ort ON orr.ObjRightsTypeID = ort.ObjRightsTypeID
LEFT OUTER JOIN MFAHv_OBJ_Constituent AS oc ON o.ObjectID = oc.o_ObjectID

WHERE o.ObjectStatusID IN (2,27)
AND oc.cx_RoleTypeID = 1

ORDER BY o.SortNumber, can_AlphaSort

















