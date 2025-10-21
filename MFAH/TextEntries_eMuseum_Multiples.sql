





SELECT te.ID, te.TextStatusID, o.ObjectNumber, COUNT(*) AS Records
FROM TextEntries AS te
INNER JOIN Objects AS o ON o.ObjectID = te.ID AND te.TableID = 108 
WHERE TextTypeID = 212 AND Purpose = 'eMuseum'
AND o.PublicAccess = 1
GROUP BY ID, TextStatusID, o.ObjectNumber
HAVING COUNT(*) > 1











