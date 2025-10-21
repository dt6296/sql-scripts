


/*
SELECT
l.LoanID,
l.LoanNumber,
l.PrimaryLoanConstituent,
l.BeginDate,
l.EndDate,
e.ExhibitionID,
e.ExhTitle
FROM MFAHv_LOAN AS l
LEFT OUTER JOIN ExhLoanXrefs AS elx ON l.LoanID = elx.LoanID
LEFT OUTER JOIN MFAHv_EXH AS e ON elx.ExhibitionID = e.ExhibitionID
WHERE l.LoanID = 11300


SELECT DISTINCT
l.LoanID,
l.LoanNumber,
l.SortNumber,
l.LoanIn,
l.LoanStatusID,
l.LoanStatus,
l.LoanPurposeID,
l.LoanPurpose,
ev.ExhibitionID,
ev.ConstituentID,
ev.DisplayName AS Venue,
ev.Mnemonic,
ev.VenueBeginDate,
ev.VenueEndDate,
slx.ShipmentID

FROM ShipLoanXrefs AS slx
LEFT OUTER JOIN MFAHv_LOAN AS l ON slx.LoanID = l.LoanID
LEFT OUTER JOIN MFAHv_LOAN_EXH AS le ON slx.LoanID = le.LoanID
LEFT OUTER JOIN MFAHv_EXH_VENUE AS ev ON le.ExhibitionID = ev.ExhibitionID


WHERE l.LoanIn = 0
AND l.LoanStatusID IN (5,6) -- Approved, Current
AND l.LoanPurposeID NOT IN (11,14,15,16,17,18,19) -- PISD-related loans
AND le.LoanID = 11300
*/







SELECT * FROM ShipLoanXrefs WHERE LoanID = 11300
--SELECT * FROM LoanPurposes


SELECT
slx.LoanID,
s.ShipmentID,
s.ShipmentNumber,
st.ShipmentType,
s.EstShipDate,
s.EstArrivalDate,
canf.DisplayName AS ShipFrom,
cant.DisplayName AS ShipTo,
cant.ConstituentID AS ShipToConstituentID,
dbo.MFAHfx_ConcatShipmentCouriers(s.ShipmentID) AS Courier

FROM			ShipLoanXrefs AS slx
LEFT OUTER JOIN	MFAHv_SHIP	AS s	ON slx.ShipmentID = s.ShipmentID
LEFT OUTER JOIN ShipmentTypes AS st ON s.ShipmentTypeID = st.ShipmentTypeID
LEFT OUTER JOIN ConAltNames AS canf ON s.ShipFromNameID = canf.AltNameId
LEFT OUTER JOIN ConAltNames AS cant ON s.ShipToNameID = cant.AltNameId 

WHERE slx.LoanID = 11300



SELECT
sox.ShipmentID,
COUNT(sox.ObjectID) AS Objects,
d.Department

FROM ShipObjXrefs AS sox
INNER JOIN ObjComponents AS oc ON sox.ObjectID = oc.ObjectID
INNER JOIN ShipCompXrefs AS scx ON sox.ShipmentID = scx.ShipmentID AND oc.ComponentID = scx.ComponentID
LEFT OUTER JOIN Objects AS o ON sox.ObjectID = o.ObjectID
LEFT OUTER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID

WHERE scx.Included = 1
AND	sox.ShipmentID = 1479

GROUP BY
sox.ShipmentID,
d.Department


SELECT Remarks FROM ShipLoanXrefs WHERE ShipmentID = 1479

--SELECT * FROM LoanObjXrefs WHERE LoanID = 11300
--SELECT * FROM ShipCompXrefs WHERE ShipmentID = 1479
--SELECT * FROM ShipObjXrefs WHERE ShipmentID = 1479
--SELECT * FROM DDColumns WHERE ColumnName LIKE 'Included'
--SELECT * FROM DDTables WHERE TableID = 348
--SELECT * FROM DDColumns WHERE ColumnName LIKE 'Remarks'
--SELECT * FROM DDTables WHERE TableID = 352
--SELECT * FROM ShipLoanXrefs WHERE ShipmentID = 1479

SELECT
ss.ShipmentID,
ss.StepNumber,
ss.Carrier,
ss.ShippingMethod,
ss.FlightNumber,
ss.DepartureDate,
ss.DepartureCity,
ss.ArrivalDate,
ss.ArrivalCity,
ss.Instructions

FROM MFAHv_SHIP_STEP AS ss

WHERE ss.ShipmentID = 1479




SELECT dbo.MFAHfx_ConcatShipmentCouriers(1479)



---------------------------------------------------------------------------------

SELECT
l.LoanID,
l.LoanNumber,
l.PrimaryLoanConstituent,
l.BeginDate,
l.EndDate,
e.ExhibitionID,
e.ExhTitle
FROM MFAHv_LOAN AS l
LEFT OUTER JOIN ExhLoanXrefs AS elx ON l.LoanID = elx.LoanID
LEFT OUTER JOIN MFAHv_EXH AS e ON elx.ExhibitionID = e.ExhibitionID
WHERE l.LoanIn = 0
AND l.LoanStatusID IN (5,6) -- Approved, Current
AND l.LoanPurposeID NOT IN (11,14,15,16,17,18,19) -- PISD-related loans
AND l.LoanID = 11300





