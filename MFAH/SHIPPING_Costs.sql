


/*
SELECT * FROM MFAHv_LOAN AS l
WHERE LoanNumber = 'IL.TEST'
--WHERE LoanID = 9704

SELECT * FROM MFAHv_SHIP AS s
WHERE ShipmentNumber = 'SH.TEST'
--WHERE ShipmentID = 1161


SELECT * FROM DDTables ORDER BY TableName
345  Shipments
355	 ShipmentSteps






SELECT DISTINCT
l.LoanID,
l.LoanNumber,
s.ShipmentID,
s.ShipmentNumber,
ss.StepID,
ss.StepNumber,
te.TextDate,
te.TextTypeID,
tt.TextType,
te.Purpose,
ISNULL(CAST(te.TextEntry AS NUMERIC(15,2)),0) AS Amount_TextEntry,

cx.RoleID,
r.Role,
cxd.ConstituentID,
c.DisplayName,
ISNULL(cxd.Remarks,'') AS Remarks,
ISNULL(cxd.Amount,0) AS Amount_CXD

FROM MFAHv_LOAN AS l
LEFT OUTER JOIN ShipLoanXrefs AS slx ON l.LoanID = slx.LoanID
LEFT OUTER JOIN MFAHv_SHIP AS s ON slx.ShipmentID = s.ShipmentID

--------------------------------------------------------------------------	Using Shipment Step Text Entry Remarks
LEFT OUTER JOIN ShipmentSteps AS ss ON s.ShipmentID = ss.ShipmentID
LEFT OUTER JOIN MFAHv_TextEntry AS te ON ss.StepID = te.ID AND te.TableID = 355
LEFT OUTER JOIN TextTypes AS tt ON te.TextTypeID = tt.TextTypeID

--------------------------------------------------------------------------	Using Shipment Step ConXrefDetails Amount
LEFT OUTER JOIN ConXrefs AS cx ON ss.StepID = cx.ID AND cx.TableID = 355
LEFT OUTER JOIN Roles AS r ON cx.RoleID = r.RoleID
LEFT OUTER JOIN ConXrefDetails AS cxd ON cx.ConXrefID = cxd.ConXrefID
LEFT OUTER JOIN MFAHv_CON AS c ON cxd.ConstituentID = c.ConstituentID

WHERE l.LoanNumber = 'IL.TEST'


*/
---------------------------------------------------------------------------------------------------


SELECT DISTINCT
l.LoanID,
l.LoanNumber,
s.ShipmentID,
s.ShipmentNumber,
ss.StepID,
ss.StepNumber,
ss.Instructions,
c.DisplayName AS Vendor,
te.TextDate,
te.TextTypeID,
tt.TextType,
te.Purpose,
ISNULL(CAST(te.TextEntry AS NUMERIC(15,2)),0) AS Amount_TextEntry,
te.TextStatus

FROM MFAHv_LOAN AS l
LEFT OUTER JOIN ShipLoanXrefs AS slx ON l.LoanID = slx.LoanID
LEFT OUTER JOIN MFAHv_SHIP AS s ON slx.ShipmentID = s.ShipmentID

--------------------------------------------------------------------------	Using Shipment Step Text Entry Remarks
LEFT OUTER JOIN ShipmentSteps AS ss ON s.ShipmentID = ss.ShipmentID
LEFT OUTER JOIN MFAHv_TextEntry AS te ON ss.StepID = te.ID AND te.TableID = 355
LEFT OUTER JOIN TextTypes AS tt ON te.TextTypeID = tt.TextTypeID

LEFT OUTER JOIN MFAHv_CON AS c ON te.AuthorConID = c.ConstituentID


WHERE l.LoanNumber = 'IL.TEST'






