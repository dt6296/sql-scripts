






SELECT 
o.ObjectID,
o.ObjectNumber,
r.CreditLineRepro,
r.ObjRightsTypeID,
rt.ObjRightsType

FROM MFAHv_OBJ AS o
LEFT OUTER JOIN ObjRights AS r ON o.ObjectID = r.ObjectID
LEFT OUTER JOIN ObjRightsTypes AS rt ON r.ObjRightsTypeID = rt.ObjRightsTypeID

WHERE o.ObjectStatusID = 27




