



SELECT
p.PackageID,
p.Name,
p.[Owner],
pl.ID AS ObjectCount,
o.ObjectNumber,
o.CuratorApproved

FROM [Packages] AS p
INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
INNER JOIN Objects AS o ON pl.ID = o.ObjectID AND pl.TableID = 108

WHERE p.PackageID IN (14793,14795)

WHERE p.PackageID = 16986 --(300 objects)


--UPDATE Objects
--SET CuratorApproved = 1
--SELECT o.ObjectNumber, o.CuratorApproved
FROM [Packages] AS p
INNER JOIN PackageList AS pl ON p.PackageID = pl.PackageID
INNER JOIN Objects AS o ON pl.ID = o.ObjectID AND pl.TableID = 108
WHERE p.PackageID = 16986

(300 row(s) affected)
