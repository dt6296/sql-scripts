











SELECT
o.ObjectID,
o.ObjectNumber,
o.SortNumber,
te.TextTypeID,
te.Purpose,
te.TextEntry

FROM Objects AS o
INNER JOIN TextEntries AS te ON o.ObjectID = te.ID AND te.TableID = 108

WHERE o.DepartmentID = 11
AND o.ObjectStatusID = 2
AND te.TextTypeID = 212
AND te.Purpose = 'OCM'
AND te.TextEntry LIKE ('%'+ CHAR(13) + '%')

ORDER BY o.SortNumber


SELECT * FROM Packages WHERE Name LIKE 'Photo OCM%'
/*
PackageID	Name
140533		Photo OCM LabelText with paragraph breaks
*/



--INSERT INTO TMS.dbo.PackageList												--(294 row(s) affected)
(PackageID, ID, MainData, OrderPos, LoginID, EnteredDate, Notes, TableID)

SELECT DISTINCT
140533,
o.ObjectID,
o.ObjectNumber,
ROW_NUMBER() OVER (ORDER BY o.SortNumber) + (SELECT ISNULL(MAX(OrderPOS),0) FROM PackageList WHERE PackageID = 140533),
'dthompson',
GETDATE(),
NULL,
108

FROM Objects AS o
INNER JOIN TextEntries AS te ON o.ObjectID = te.ID AND te.TableID = 108

WHERE o.DepartmentID = 11
AND o.ObjectStatusID = 2
AND te.TextTypeID = 212
AND te.Purpose = 'OCM'
AND te.TextEntry LIKE ('%'+ CHAR(13) + '%')
AND o.ObjectID NOT IN
(
	SELECT ID FROM PackageList WHERE PackageID = 140533
)
