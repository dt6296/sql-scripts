

SELECT
te.ID,
te.TextTypeID,
tt.TextType,
te.Purpose,
te.TextStatusID,
ts.TextStatus,
te.TextDate,
te.Remarks,
c.DisplayName

FROM TextEntries AS te
LEFT OUTER JOIN TextTypes AS tt ON te.TextTypeID = tt.TextTypeID
LEFT OUTER JOIN TextStatuses AS ts ON te.TextStatusID = ts.TextStatusID
LEFT OUTER JOIN Constituents AS c ON te.ID = c.ConstituentID

WHERE te.TableID = 23
AND te.TextTypeID IN (213,214,215)
AND te.TextDate > GETDATE()

--SELECT * FROM TextTypes WHERE TextTypeID = 213






