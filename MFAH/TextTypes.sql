





SELECT * FROM DDTables WHERE TableName = 'TextEntries'


SELECT * FROM DDColumns WHERE PhysTableID = 330


SELECT * FROM TextTypes
WHERE TableID = 89




SELECT
tt.TextType,
ts.TextStatus,
te.* 


SELECT
tt.TextType,
te.TextDate,
c.DisplayName,
te.Purpose,
ts.TextStatus,
te.Remarks,
te.TextEntry,
te.LoginID,
te.EnteredDate

FROM TextEntries AS te
LEFT OUTER JOIN TextTypes AS tt ON te.TextTypeID = tt.TextTypeID
LEFT OUTER JOIN TextStatuses AS ts ON te.TextStatusID = ts.TextStatusID
LEFT OUTER JOIN Constituents AS c ON te.AuthorConID = c.ConstituentID

WHERE te.TableID = 89




