




SELECT 

te.ID AS ObjectID,
o.ObjectNumber,
CHAR(10),
CAST(te.TextEntry AS NVARCHAR(MAX))		AS TextEntry,
CHAR(10),
'END_OF_RECORD',
CHAR(10)

FROM TextEntries AS te
LEFT OUTER JOIN	TextTypes		AS tt	ON te.TextTypeID = tt.TextTypeID
LEFT OUTER JOIN TextStatuses	AS ts	ON te.TextStatusID = ts.TextStatusID
LEFT OUTER JOIN MFAHv_CON		AS c	ON te.AuthorConID = c.ConstituentID
INNER JOIN Objects				AS o	ON te.ID = o.ObjectID AND te.TableID = 108
INNER JOIN
(
	SELECT TextEntryID,
	ID AS ObjectID,
	te.EnteredDate,
	RANK() OVER(PARTITION BY ID ORDER BY te.EnteredDate DESC) AS RankByEnteredDate
	FROM	TextEntries	AS te
	LEFT OUTER JOIN TextTypes	AS tt	ON	te.TextTypeID = tt.TextTypeID
	WHERE tt.TableID = 108		-- Objects
	AND te.TextTypeID = 212		-- Label Text
	AND Purpose = 'OCM'			--'Online Collection Module'
	--AND te.TextStatusID = 23	-- 23 = Approved
								-- 16 = Submitted
								-- 22 = To Be Reviewed
) 
AS teRank ON te.TextEntryID = teRank.TextEntryID

WHERE teRank.RankByEnteredDate = 1	-- Returns the most recent entry in case there are multiple approved entries.

ORDER BY o.SortNumber
