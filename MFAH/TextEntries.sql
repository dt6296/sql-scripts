

SELECT * FROM MFAHv_TextEntry

WHERE TableID = 89



SELECT * FROM TextTypes WHERE TableID = 89 ORDER BY TextType

SELECT * FROM TextStatuses


SELECT * FROM DDColumns 
WHERE ColumnName LIKE '%Purpose%' 

ORDER BY ColumnName


SELECT * FROM DDTables WHERE PhysTableID = 330


SELECT DISTINCT PhysTableID FROM DDTables WHERE TableName = 'TextEntries'
SELECT * FROM DDTables
--23 = Constituents
/*
SELECT DISTINCT	
tt.TableID,
ddt.TableName
FROM TextTypes	AS tt
LEFT OUTER JOIN DDTables	AS ddt	ON tt.TableID = ddt.TableID

TableID	TableName		PhysTableID
0		NULL			NULL
23		Constituents	23
47		Exhibitions		47
79		LoanObjXrefs	79
81		Loans			81
89		ObjAccession	89
94		ObjComponents	94
99		ObjContext		99				Object > Registration > Handling Notes
102		ObjDeaccession	102
108		Objects			108
143		ReferenceMaster	143
187		HistEvents		187
318		MediaMaster		318
345		Shipments		345
355		ShipmentSteps	355

Data Date:	5/6/2014

*/
--_____________________________________________________________________________ Form 8283



SELECT
dbo.MFAHfx_FiscalYear(te.TextDate) AS FiscalYear,
COUNT(*) AS FormCount

FROM			TextEntries	AS te
LEFT OUTER JOIN TextTypes	AS tt	ON	te.TextTypeID = tt.TextTypeID
LEFT OUTER JOIN DDTables	AS ddt	ON	tt.TableID = ddt.TableID

WHERE tt.TableID = 89--23--89 --99
AND te.TextTypeID = 211		--Form 8283

GROUP BY dbo.MFAHfx_FiscalYear(te.TextDate)



--_____________________________________________________________________________	OCM Label Text

SELECT
te.ID,
te.TextTypeID,
tt.TextType,
tt.TableID,
ddt.TableName,
te.TextEntryID,
RANK() OVER (PARTITION BY ID ORDER BY te.EnteredDate DESC) AS teRank,
te.TextStatusID,
ts.TextStatus,
te.Purpose,
te.TextDate,
te.EnteredDate,
te.LoginID,
te.AuthorConID,
te.Remarks,
te.TextEntryHTML,
CAST(te.TextEntry AS NVARCHAR(4000)) AS TextEntry

FROM			TextEntries	AS te
LEFT OUTER JOIN TextTypes	AS tt	ON	te.TextTypeID = tt.TextTypeID
LEFT OUTER JOIN TextStatuses	AS ts	ON te.TextStatusID = ts.TextStatusID
LEFT OUTER JOIN DDTables	AS ddt	ON	tt.TableID = ddt.TableID

WHERE tt.TableID = 108--23--89 --99
AND te.TextTypeID = 212	-- Label Text
AND te.Purpose = 'OCM'--'Online Collection Module'






SELECT 
te.TextEntryID,
te.TableID,
te.ID,
te.TextTypeID,
tt.TextType,
te.TextStatusID,
ts.TextStatus,
te.Purpose,
te.TextDate,
te.LoginID,
te.EnteredDate,
te.AuthorConID,
c.DisplayName	AS Author,
te.Remarks,
CAST(te.TextEntry AS NVARCHAR(MAX))		AS TextEntry,
CAST(te.TextEntryHTML AS NVARCHAR(MAX))	AS TextEntryHTML

FROM TextEntries AS te
LEFT OUTER JOIN	TextTypes		AS tt	ON te.TextTypeID = tt.TextTypeID
LEFT OUTER JOIN TextStatuses	AS ts	ON te.TextStatusID = ts.TextStatusID
LEFT OUTER JOIN MFAHv_CON		AS c	ON te.AuthorConID = c.ConstituentID
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
	AND te.TextStatusID = 23	-- 23 = Approved
								-- 16 = Submitted
								-- 22 = To Be Reviewed
) 
AS teRank ON te.TextEntryID = teRank.TextEntryID

WHERE teRank.RankByEnteredDate = 1	-- Returns the most recent entry in case there are multiple approved entries.


