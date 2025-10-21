








SELECT
o.ObjectID,
o.ObjectNumber,
od.Element,
od.Height,
od.Width,
od.Height * od.Width AS Area

FROM Objects AS o
LEFT OUTER JOIN MFAHv_OBJ_Dimensions_cm AS od ON o.ObjectID = od.ID AND TableID = 108

WHERE o.DepartmentID = 11
AND o.ObjectStatusID = 2
AND od.Element IS NOT NULL

ORDER BY od.Height * od.Width DESC




SELECT
o.ObjectID,
o.ObjectNumber,
o.BeginISODate,
o.EndISODate

FROM Objects AS o

WHERE o.DepartmentID = 11
AND o.ObjectStatusID = 2

ORDER BY o.BeginISODate DESC





SELECT
o.ObjectID,
o.ObjectNumber,
opv.PageViews

FROM Objects AS o
INNER JOIN MFAHt_TEMP_ObjectPageViews AS opv ON o.ObjectID = opv.ObjectID

WHERE o.DepartmentID = 11
AND o.ObjectStatusID = 2

ORDER BY opv.PageViews DESC








SELECT
o_ObjectID,
o_ObjectNumber,
oc.c_DisplayName,
oc.c_BeginDate,
oc.c_EndDate,
oc.C_DisplayDate


FROM MFAHv_OBJ_Constituent AS oc
INNER JOIN Objects AS o ON oc.o_ObjectID = o.ObjectID

WHERE o.DepartmentID = 11
AND o.ObjectStatusID = 2
AND oc.cx_RoleTypeID = 1
AND oc.c_BeginDate <> 0
AND oc.c_ConstituentTypeID = 1

ORDER BY oc.c_BeginDate DESC




SELECT
o_ObjectID,
o_ObjectNumber,
COUNT(*) AS NumberOfMakers

FROM MFAHv_OBJ_Constituent AS oc
INNER JOIN Objects AS o ON oc.o_ObjectID = o.ObjectID

WHERE o.DepartmentID = 11
AND o.ObjectStatusID = 2
AND oc.cx_RoleTypeID = 1

GROUP BY
o_ObjectID,
o_ObjectNumber

ORDER BY COUNT(*) DESC



SELECT
o.ObjectNumber,
og.*
FROM MFAHv_OBJ_Geography AS og
INNER JOIN Objects AS o ON og.ObjectID = o.ObjectID
WHERE PoliticalGeography LIKE '%Perth%'
AND o.DepartmentID = 11
AND o.ObjectStatusID = 2




SELECT
c_ConstituentID,
c_DisplayName,
COUNT(*) AS NumberOfObjects

FROM MFAHv_OBJ_Constituent AS oc
INNER JOIN Objects AS o ON oc.o_ObjectID = o.ObjectID

WHERE o.DepartmentID = 11
AND o.ObjectStatusID = 2
AND oc.cx_RoleTypeID = 1

GROUP BY
c_ConstituentID,
c_DisplayName

ORDER BY COUNT(*) DESC