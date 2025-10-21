





SELECT * FROM Packages WHERE Name LIKE 'Maquettes for Craft in New Building'

--	PackageID	Name
--	135986		Maquettes for Craft in New Building



SELECT DISTINCT
pl.ID AS ObjectID,
o.SortNumber,
om.ObjectNumber,
o.ArtistMaker,
o.TitleDateDisplay,
REPLACE(REPLACE(o.Dimensions,CHAR(10),''),CHAR(13),'') AS Dimensions,
--om.MediaTypeID,
om.MediaType,
om.RenditionNumber,
--om.PhysicalPath,
om.FileName,
--om.FilePathName,
om.PrimaryDisplay--,
--om.ThumbBLOB

FROM PackageList AS pl
LEFT OUTER JOIN MFAHv_OBJ_Media AS om ON pl.ID = om.ObjectID
LEFT OUTER JOIN MFAHv_OBJ_Tombstone2 AS o ON om.ObjectID = o.ObjectID

WHERE pl.PackageID = 135986
AND om.MediaTypeID = 1
AND om.FileName IS NOT NULL

ORDER BY o.SortNumber, om.PrimaryDisplay DESC, om.RenditionNumber




















