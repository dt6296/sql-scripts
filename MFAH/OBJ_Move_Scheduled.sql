



--SELECT TOP 10 * FROM ObjLocations ORDER BY EnteredDate DESC



SELECT
ol.ObjLocationID,
ol.ComponentID,
o.ObjectID,
o.ObjectNumber,
ol.LocationID,
ol.LocLevel,
ol.Sublevel,
ol.TransCodeID,
ol.TransDate,
ol.TransStatusID,
ol.LocPurposeID,
ol.TempText,
ol.LoginID,
ol.EnteredDate,
ol.RequestedBy,
ol.GSRowVersion

FROM ObjLocations AS ol
INNER JOIN ObjComponents AS oc ON ol.ComponentID = oc.ComponentID
INNER JOIN Objects AS o ON oc.ObjectID = o.ObjectID

WHERE ol.TransCodeID = 8
AND TransStatusID = 0

ORDER BY ol.EnteredDate DESC