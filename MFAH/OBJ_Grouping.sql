
/*
Object

*/


SELECT 
d.Department,
c.Classification,
sc.Classification AS SubClass,
o.[Type],
ot.ObjectType,
os.ObjectStatus,
ol.ObjectLevel,
o.IsVirtual,
o.ObjectID,
o.ObjectNumber,
o.ObjectCount,
o.Dated,
o.Medium,
o.Dimensions,
o.Title,
o.Cataloguer,
o.CatalogueISODate,
o.Curator,
o.CuratorRevISODate,
o.CuratorApproved

FROM [Objects] AS o
LEFT OUTER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID
LEFT OUTER JOIN Classifications AS c ON o.ClassificationID = c.ClassificationID
LEFT OUTER JOIN Classifications AS sc ON o.SubClassID = sc.ClassificationID
LEFT OUTER JOIN ObjectTypes AS ot ON o.ObjectTypeID = ot.ObjectTypeID
LEFT OUTER JOIN ObjectStatuses AS os ON o.ObjectStatusID = os.ObjectStatusID
LEFT OUTER JOIN ObjectLevels AS ol ON o.ObjectLevelID = ol.ObjectLevelID

--WHERE ObjectID = 60082