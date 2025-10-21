

SELECT
oc.o_ObjectID,
oc.o_ObjectNumber,
oc.c_ConstituentID,
oc.c_DisplayName,
oc.Culture,
oc.cxs_ForwardDisplay,
d.Department,
c.Classification


FROM MFAHv_OBJ_Constituent AS oc
LEFT OUTER JOIN Objects AS o ON oc.o_ObjectID = o.ObjectID
LEFT OUTER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID
LEFT OUTER JOIN Classifications AS c ON o.ClassificationID = c.ClassificationID

WHERE oc.cx_RoleTypeID = 1
AND oc.c_ConstituentTypeID = 3
AND oc.c_ConstituentID = 6


