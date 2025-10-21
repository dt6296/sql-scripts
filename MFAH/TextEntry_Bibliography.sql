





SELECT * FROM TextTypes
WHERE TableID = 108
AND TextTypeID IN (249,250)


SELECT
te.TextEntryID,
te.TableID,
te.ID,
te.TextStatusID,
te.TextTypeID,
tt.TextType,
te.Remarks,
te.TextEntryHTML,
te.TextEntry
FROM TextEntries AS te
INNER JOIN TextTypes AS tt ON te.TextTypeID = tt.TextTypeID
WHERE te.TableID = 108
AND te.TextTypeID IN (249,250)
