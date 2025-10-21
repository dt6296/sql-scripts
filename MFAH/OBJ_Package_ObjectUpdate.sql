





SELECT
pl.PackageListID,
p.PackageType,
pl.PackageID,
p.Name,
p.Notes,
p.Owner,
p.EnteredDate,
pl.ID,
pl.MainData

FROM PackageList AS pl
INNER JOIN Packages AS p ON pl.PackageID = p.PackageID

WHERE pl.TableID = 108
AND pl.PackageID = 15179		--117 records


SELECT
pl.PackageListID,
p.PackageType,
pl.PackageID,
p.Name,
p.Notes,
p.Owner,
p.EnteredDate,
pl.ID,
pl.MainData,
o.ObjectID,
o.ObjectNumber,
o.CreditLine

FROM PackageList AS pl
INNER JOIN Packages AS p ON pl.PackageID = p.PackageID
LEFT OUTER JOIN Objects AS o ON pl.ID = o.ObjectID

WHERE pl.TableID = 108
AND pl.PackageID = 15179		--117 records



SELECT o.ObjectID
--UPDATE Objects
--SET CreditLine = 'Margo Grant Walsh Twentieth Century Silver and Metalwork Collection, gift of Margo Grant Walsh'

FROM PackageList AS pl
INNER JOIN Packages AS p ON pl.PackageID = p.PackageID
LEFT OUTER JOIN Objects AS o ON pl.ID = o.ObjectID

WHERE pl.TableID = 108
AND pl.PackageID = 15179		--117 records

--(117 row(s) affected)

'Margo Grant Walsh Twentieth Century Silver and Metalwork Collection, gift of Margo Grant Walsh'






SELECT o.ObjectID, p.Name, o.CuratorApproved
--UPDATE Objects
--SET CuratorApproved = 0

FROM PackageList AS pl
INNER JOIN Packages AS p ON pl.PackageID = p.PackageID
LEFT OUTER JOIN Objects AS o ON pl.ID = o.ObjectID

WHERE pl.TableID = 108
AND pl.PackageID = 16293		--87 records

--(87 row(s) affected)





SELECT * FROM Packages WHERE Name LIKE 'Lace and Textile for Dec Arts Designation 2014%'     16293