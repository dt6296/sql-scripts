







SELECT * FROM Packages WHERE Name = 'Deacc dept BB with website approved'
-- 281589

SELECT
o.ObjectID,
o.ObjectNumber,
o.PublicAccess,
p.Name

FROM Objects AS o
INNER JOIN PackageList AS pl ON o.ObjectID = pl.ID AND pl.TableID = 108
INNER JOIN Packages AS p ON pl.PackageID = p.PackageID

WHERE pl.PackageID = 281589



UPDATE Objects
SET PublicAccess = 0

FROM Objects AS o
INNER JOIN PackageList AS pl ON o.ObjectID = pl.ID AND pl.TableID = 108
INNER JOIN Packages AS p ON pl.PackageID = p.PackageID

WHERE pl.PackageID = 281589




