









SELECT * FROM Packages
WHERE Name LIKE '%GEGO%'
--PackageID = 170625


SELECT 
ID
FROM PackageList
WHERE PackageID = 170625



SELECT
om.ObjectID, om.ObjectNumber, om.FilePathName, om.PhysicalPath, om.FileName
FROM MFAHv_OBJ_Media AS om
INNER JOIN PackageList AS pl ON om.ObjectID = pl.ID AND PackageID = 170625
WHERE om.PrimaryDisplay = 1
AND FilePathName IS NOT NULL






