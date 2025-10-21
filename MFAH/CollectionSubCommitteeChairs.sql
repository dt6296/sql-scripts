









SELECT
c.DisplayName,
tt.TextType,
ts.TextStatus,
te.*

FROM TextEntries AS te
INNER JOIN TextTypes AS tt ON te.TextTypeID = tt.TextTypeID
INNER JOIN TextStatuses AS ts ON te.TextStatusID = ts.TextStatusID
LEFT OUTER JOIN Constituents AS c ON te.ID = c.ConstituentID AND te.TableID = 23

WHERE te.TextTypeID IN (213,214,215)




SELECT
te.TextTypeID,
tt.TextType,
te.Purpose,
ts.TextStatus,
te.TextDate,
te.Remarks,
c.DisplayName,
c.ConstituentID

FROM TextEntries AS te
INNER JOIN TextTypes AS tt ON te.TextTypeID = tt.TextTypeID
INNER JOIN TextStatuses AS ts ON te.TextStatusID = ts.TextStatusID
LEFT OUTER JOIN Constituents AS c ON te.ID = c.ConstituentID AND te.TableID = 23

WHERE te.TextTypeID IN (213,214,215,233)




