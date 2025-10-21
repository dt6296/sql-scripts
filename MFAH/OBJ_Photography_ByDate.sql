





SELECT
o.ObjectID,
o.ObjectNumber,
o.SortNumber,
o.ObjectCount,
o.DepartmentID,
o.Department,
o.DepartmentPublic,
o.ObjectStatusID,
o.ObjectStatus,
o.ClassificationID,
o.Classification,
o.ObjectLevelID,
o.ObjectLevel,
o.ObjectTypeID,
o.ObjectType,
o.Dated,
o.DateBegin,
o.DateEnd,
(o.DateBegin + o.DateEnd)/2 AS DateAvg,
o.ObjRightstype,
o.AccessionMethodID,
o.AccessionMethod,
o.AccessionMethodDisplay,
o.CY,
o.FY,
o.AccessionDate

FROM MFAHv_OBJ AS o

WHERE o.DepartmentID = 11	--	Photography
AND o.ObjectStatusID = 2	--	Accessioned Objects




SELECT
(o.DateBegin + o.DateEnd)/2 AS Photographed,
YEAR(o.AccessionDate) AS Accessioned,
COUNT(o.ObjectID) AS OBJ_Count

FROM MFAHv_OBJ AS o

WHERE o.DepartmentID = 11	--	Photography
AND o.ObjectStatusID = 2	--	Accessioned Objects
AND o.AccessionDate IS NOT NULL

GROUP BY
(o.DateBegin + o.DateEnd)/2,
YEAR(o.AccessionDate)