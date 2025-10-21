










SELECT
te.TextTypeID,
tt.TextType,
COUNT(te.TextEntryID) AS RecordCount,
MAX(te.EnteredDate) AS LastUsed,
te.TableID,
ddt.TableName

FROM TextEntries AS te
INNER JOIN TextTypes AS tt ON te.TextTypeID = tt.TextTypeID
INNER JOIN DDTables AS ddt ON te.TableID = ddt.TableID

GROUP BY
te.TextTypeID,
tt.TextType,
te.TableID,
ddt.TableName



---**************************************



SELECT 
te.TableID,
ddt.TableName,
te.TextTypeID,
tt.TextType,
dbo.MFAHfx_CalendarYear(dbo.MFAHfx_DATETIMEtoISO(te.EnteredDate)) AS [Year],
dbo.MFAHfx_CalendarQuarter(dbo.MFAHfx_DATETIMEtoISO(te.EnteredDate)) AS QTR,
COUNT(te.TextEntryID) AS Occurence

FROM TextTypes AS tt
LEFT OUTER JOIN TextEntries AS te ON tt.TextTypeID = te.TextTypeID
LEFT OUTER JOIN DDTables AS ddt ON te.TableID = ddt.TableID

WHERE te.TableID = 108

GROUP BY
dbo.MFAHfx_CalendarYear(dbo.MFAHfx_DATETIMEtoISO(te.EnteredDate)),
dbo.MFAHfx_CalendarQuarter(dbo.MFAHfx_DATETIMEtoISO(te.EnteredDate)),
te.TableID,
ddt.TableName,
te.TextTypeID,
tt.TextType

ORDER BY
te.TableID,
ddt.TableName,
te.TextTypeID,
tt.TextType,
dbo.MFAHfx_CalendarYear(dbo.MFAHfx_DATETIMEtoISO(te.EnteredDate)),
dbo.MFAHfx_CalendarQuarter(dbo.MFAHfx_DATETIMEtoISO(te.EnteredDate))



---**************************************























SELECT te.ID, te.EnteredDate, o.ObjectNumber
FROM TextEntries AS te
INNER JOIN Objects AS o ON te.ID = o.ObjectID AND te.TableID = 108
WHERE te.TextTypeID = 6
ORDER BY te.EnteredDate DESC






SELECT te.ID,
CONVERT(DATE,te.EnteredDate) AS EnteredDate,
o.ObjectNumber
FROM TextEntries AS te
INNER JOIN Objects AS o ON te.ID = o.ObjectID AND te.TableID = 108
WHERE te.TextTypeID = 6
ORDER BY te.EnteredDate DESC






SELECT COUNT(te.TextEntryID) AS Occurences,
CONVERT(DATE,te.EnteredDate) AS EnteredDate
FROM TextEntries AS te
WHERE te.TextTypeID = 6
GROUP BY CONVERT(DATE,te.EnteredDate)
ORDER BY CONVERT(DATE,te.EnteredDate) DESC






SELECT COUNT(te.TextEntryID) AS Occurences,
CONVERT(DATE,te.EnteredDate) AS EnteredDate
FROM TextEntries AS te
WHERE te.TextTypeID = 6
GROUP BY CONVERT(DATE,te.EnteredDate)
ORDER BY CONVERT(DATE,te.EnteredDate) DESC







SELECT * FROM TextEntries WHERE TableID = 108

SELECT * FROM TextTypes WHERE TableID = 108



--------------------------------------------------------------------------------------------	6/7/2018


SELECT
tt.TextTypeID,
tt.TableID,
tt.TextType,
ISNULL(DATEPART(yyyy,te.EnteredDate),1900) AS TextYear,
COUNT(*) AS CountTextEntries

FROM TextTypes AS tt
LEFT OUTER JOIN TextEntries AS te ON tt.TextTypeID = te.TextTypeID

WHERE tt.TableID = 108

GROUP BY
tt.TextTypeID,
tt.TableID,
tt.TextType,
ISNULL(DATEPART(yyyy,te.EnteredDate),1900)