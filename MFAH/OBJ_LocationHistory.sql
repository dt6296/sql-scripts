







SELECT TOP 10000
oc.ComponentID,
oc.ComponentNumber,
ol.TransDate AS Date,
--TransType,
--ol.TransStatusID,
--TransStatus,

l.LocationString,
lp.LocPurpose,
ol.Handler,
ol.RequestedBy,
ol.TempText AS Remarks,
ol.Approver AS ApprovedBy,
ol.LoginID AS EnteredBy,
ol.EnteredDate,
ol.AnticipEndDate,
--ActualEndDate,
s.ReceiptNumber
--ShippingDetails

FROM			ObjComponents	AS oc
LEFT OUTER JOIN ObjLocations	AS ol	ON oc.ComponentID = ol.ComponentID
LEFT OUTER JOIN Locations		AS l	ON ol.ObjLocationID = l.LocationID
LEFT OUTER JOIN LocPurposes		AS lp	ON ol.LocPurposeID = lp.LocPurposeID
LEFT OUTER JOIN Shipments		AS s	ON ol.ShipmentID = s.ShipmentID



WHERE oc.ObjectID IN (10761,77033)

ORDER BY ol.EnteredDate DESC


----------------------------------------------------------------------------------

SELECT TOP 100
--ol.*,
ol.ObjLocationID,
ol.ComponentID,
oc.ComponentNumber,
ol.TransStatusID,
ol.LocationID,
l.LocationString,
ol.LocPurposeID,
lp.LocPurpose,
ol.Handler,
ol.RequestedBy,

ol.Approver,
ol.LoginID AS EnteredBy,
ol.EnteredDate,
ol.AnticipEndDate,
s.ShipmentID,
s.ReceiptNumber

FROM			ObjLocations	AS ol
LEFT OUTER JOIN Locations		AS l	ON ol.LocationID = l.LocationID
LEFT OUTER JOIN ObjComponents	AS oc	ON ol.ComponentID = oc.ComponentID
LEFT OUTER JOIN ShipCompXrefs	AS scx	ON oc.ComponentID = scx.ComponentID
LEFT OUTER JOIN Shipments		AS s	ON scx.ShipmentID = s.ShipmentID

LEFT OUTER JOIN LocPurposes		AS lp	ON ol.LocPurposeID = lp.LocPurposeID

WHERE oc.ObjectID = 10761

ORDER BY ol.EnteredDate DESC