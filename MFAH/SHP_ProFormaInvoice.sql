


--	SHP_ProFormaInvoice


SELECT
s.ShipmentID,
s.ShipmentNumber,
s.SortNumber AS ShipSortNumber,
s.ShipmentTypeID,
s.ShipmentType,
s.ShipmentPurposeID,
s.ShipmentPurpose,
s.ShipmentStatus,
s.RequestDate,
s.EstShipDate,
s.EstArrivalDate,
s.ActShipDate,
s.ActArrivalDate,
s.ShipFromAddress,
s.ShipFromGeo,
s.ShipFromContact,
s.ShipFromPhone,
s.ShipFromComment,
s.ShipToAddress,
s.ShipToGeo,
s.ShipToContact,
s.ShipToPhone,
s.ShipToComment,
s.ShipToLocation,
s.Remarks,
s.International,
s.InternationalDisplay,
s.HighValue,
s.HighValueDisplay,
s.ShipFromName,
s.ShipToName,

scrcx.ObjectID,
scrcx.CrateNumber,
scrcx.CrateHeightCM,
scrcx.CrateWidthCM,
scrcx.CrateDepthCM,

c.CrateWeightKG,

scx.Included


FROM MFAHv_SHIP AS s
LEFT OUTER JOIN ShipCompRootCrateXrefs AS scrcx ON s.ShipmentID = scrcx.ShipmentID
LEFT OUTER JOIN Crates AS c ON scrcx.RootCrateID = c.CrateID
LEFT OUTER JOIN ShipCompXrefs AS scx ON s.ShipmentID = scx.ShipmentID



WHERE ShipmentNumber = 'SH.2018-4'
























