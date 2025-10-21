

--Object Location duration, works on paper, for Beatrice Chan



SELECT
--o.ObjectID,
o.ObjectNumber,
--o.ObjectStatusDisplay,
o.Department,
o.Classification,
--ol.ComponentID,
--ol.ComponentNumber,
--ol.CurLocationID,
ol.CurLocation,
ol.CurSite,
ol.CurRoom,
ol.CurUnitType,
ol.CurLevel,
ol.CurSublevel,
ol.TransDate,
ol.ViewStatus AS CurViewStatus,
YEAR(GETDATE()) - YEAR(TransDate) AS YearsAtCurrentLocation,

ol.PrevSite,
ol.PrevRoom,
ol.PrevUnitType,
ol.PrevTransDate,
YEAR(ol.TransDate) - YEAR(ol.PrevTransDate) AS YearsAtPreviousLocation
FROM MFAHv_OBJ AS o
LEFT OUTER JOIN MFAHv_OBJ_Location AS ol ON o.ObjectID = ol.ObjectID

WHERE 
(o.DepartmentID IN (9,155)
OR o.ClassificationID IN (6,7,9,38,714,1121,1122,1129))

AND o.ObjectStatusID IN (2,27)












