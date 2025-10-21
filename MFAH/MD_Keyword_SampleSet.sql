


SELECT * FROM Packages WHERE Name = 'Copy of MD Keyword Sample Set'		--	220763

SELECT ID FROM PackageList WHERE PackageID = 220763 ORDER BY OrderPos



SELECT
pl.ID AS ObjectID,
o.ObjectNumber,
o.ArtistMaker,
o.TitleFirstActiveDisplayed,
o.Dated,
o.Medium,
i.FileName

FROM MFAHv_OBJ_Tombstone2 AS o
INNER JOIN PackageList AS pl ON o.ObjectID = pl.ID AND pl.PackageID = 220763
INNER JOIN MFAHv_OBJ_Image_Primary AS i ON o.ObjectID = i.ObjectID
