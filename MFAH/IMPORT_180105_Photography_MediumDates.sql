SELECT * FROM Packages WHERE Name = 'Photo- medium cleanup "printed" '
-- 138432

SELECT ID FROM PackageList WHERE PackageID = 138432






SELECT 
od.ObjectID,
o.ObjectNumber,
od.EventType,
od.DateText,
od.DateBegSearch,
od.DateEndSearch,
od.Remarks,
od.LoginID,
od.EnteredDate

FROM ObjDates AS od
INNER JOIN Objects AS o ON od.ObjectID = o.ObjectID
INNER JOIN PackageList AS pl ON od.ObjectID = pl.ID AND pl.TableID = 108
WHERE pl.PackageID = 138432
ORDER BY o.SortNumber


---------------------------------------------------------------------------------------------------

--DELETE FROM [dbo].[MFAHt_IMPORT_180105_MediumDate]

SELECT * FROM MFAHt_IMPORT_180105_MediumDate



SELECT * FROM MFAHt_IMPORT_180105_MediumDate
WHERE Medium IS NULL
OR Dated IS NULL



--DELETE FROM MFAHt_IMPORT_180105_HistoricalDate

SELECT * FROM MFAHt_IMPORT_180105_HistoricalDate
WHERE EventType IS NULL
OR DateText IS NULL



---------------------------------------------------------------------------------------------------



SELECT
o.ObjectID,
o.ObjectNumber,
o.Medium,
i.Medium,
o.Dated,
i.Dated
FROM Objects AS o
INNER JOIN MFAHt_IMPORT_180105_MediumDate AS i ON o.ObjectID = i.ObjectID



--	UPDATE Objects
SET Medium = i.Medium, Dated = i.Dated
FROM Objects AS o
INNER JOIN MFAHt_IMPORT_180105_MediumDate AS i ON o.ObjectID = i.ObjectID







SELECT
o.ObjectID,
o.ObjectNumber,
i.EventType,
i.DateText
FROM Objects AS o
INNER JOIN MFAHt_IMPORT_180105_HistoricalDate AS i ON o.ObjectID = i.ObjectID


--	INSERT INTO ObjDates (ObjectID,EventType,DateText,LoginID,EnteredDate)
SELECT
o.ObjectID,
i.EventType,
i.DateText,
'dthompson',
GETDATE()
FROM Objects AS o
INNER JOIN MFAHt_IMPORT_180105_HistoricalDate AS i ON o.ObjectID = i.ObjectID





---------------------------------------------------------------------------------------------------




