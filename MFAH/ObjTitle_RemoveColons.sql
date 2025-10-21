






--SELECT * FROM Packages WHERE Name = 'P&D TMS COLONS'	-- 135269


SELECT
sq.ObjectID,
sq.ObjectNumber,
sq.Title,
sq.TitleTypeID,
REPLACE(sq.t1,': ',' ') AS tFinal

FROM

(
	SELECT DISTINCT --TitleTypeID,
	o.ObjectID,
	o.ObjectNumber,
	ot.Title,
	ot.TitleTypeID,
	REPLACE(ot.Title,':  ',' ') AS t1

	FROM Objects AS o
	INNER JOIN ObjTitles AS ot ON o.ObjectID = ot.ObjectID
	INNER JOIN PackageList AS pl ON o.ObjectID = pl.ID AND pl.TableID = 108

	WHERE PackageID = 135269		--	970
	AND ot.Title LIKE '%:%'			--	505
	--AND ot.TitleTypeID IN (24,26)	--	483
) AS sq



-- Need Lauren's verification before running this. 6/22/17 9:30 AM


--UPDATE ObjTitles SET Title = REPLACE(ot.Title,':  ',' ')
SELECT o.ObjectID,o.ObjectNumber,ot.Title,ot.TitleTypeID,REPLACE(ot.title,':  ',' ') AS tFinal
FROM Objects AS o
INNER JOIN ObjTitles AS ot ON o.ObjectID = ot.ObjectID
INNER JOIN PackageList AS pl ON o.ObjectID = pl.ID AND pl.TableID = 108
WHERE PackageID = 135269
AND ot.Title LIKE '%:%'
AND ot.TitleTypeID <> 1

--	483 RECORDS



SELECT * FROM TitleTypes




SELECT
o.ObjectID,
o.ObjectNumber,
ot.Title,
ot.TitleTypeID,
tt.TitleType

FROM Objects AS o
INNER JOIN ObjTitles AS ot ON o.ObjectID = ot.ObjectID
INNER JOIN TitleTypes AS tt ON ot.TitleTypeID = tt.TitleTypeID


WHERE o.DepartmentID = 9
AND ot.TitleTypeID IN (24,26)
AND ot.Title LIKE '%:%'








SELECT
o.ObjectID,
o.ObjectNumber,
ot.Title,
ot.TitleTypeID,
tt.TitleType

FROM Objects AS o
INNER JOIN ObjTitles AS ot ON o.ObjectID = ot.ObjectID
INNER JOIN TitleTypes AS tt ON ot.TitleTypeID = tt.TitleTypeID
INNER JOIN PackageList AS pl ON o.ObjectID = pl.ID AND pl.TableID = 108

WHERE o.DepartmentID = 9
AND ot.TitleTypeID IN (24,26)
AND 
(
ot.Title LIKE '%from: %' OR ot.Title LIKE '%for: %'		--	483
)
AND pl.PackageID = 135269								--	483

--	483 RECORDS
--	0


---		These are the update queries I ran....


--UPDATE ObjTitles SET Title = REPLACE(ot.Title,'from:  ','from ')
--SELECT o.ObjectID,o.ObjectNumber,ot.Title,ot.TitleTypeID,REPLACE(ot.title,'from:  ','from ') AS tFinal
FROM Objects AS o
INNER JOIN ObjTitles AS ot ON o.ObjectID = ot.ObjectID
INNER JOIN PackageList AS pl ON o.ObjectID = pl.ID AND pl.TableID = 108
WHERE PackageID = 135269
AND ot.Title LIKE '%from:  %'		--	4
AND ot.TitleTypeID IN (24,26)

--UPDATE ObjTitles SET Title = REPLACE(ot.title,'for:  ','for ')
--SELECT o.ObjectID,o.ObjectNumber,ot.Title,ot.TitleTypeID,REPLACE(ot.title,'for:  ','for ') AS tFinal
FROM Objects AS o
INNER JOIN ObjTitles AS ot ON o.ObjectID = ot.ObjectID
INNER JOIN PackageList AS pl ON o.ObjectID = pl.ID AND pl.TableID = 108
WHERE PackageID = 135269
AND ot.Title LIKE '%for:  %'		--	0
AND ot.TitleTypeID IN (24,26)

--UPDATE ObjTitles SET Title = REPLACE(ot.title,'from: ','from ')
--SELECT o.ObjectID,o.ObjectNumber,ot.Title,ot.TitleTypeID,REPLACE(ot.title,'from: ','from ') AS tFinal
FROM Objects AS o
INNER JOIN ObjTitles AS ot ON o.ObjectID = ot.ObjectID
INNER JOIN PackageList AS pl ON o.ObjectID = pl.ID AND pl.TableID = 108
WHERE PackageID = 135269
AND ot.Title LIKE '%from: %'		--	108
AND ot.TitleTypeID IN (24,26)		--	104 updated

--UPDATE ObjTitles SET Title = REPLACE(ot.title,'for: ','for ')
--SELECT o.ObjectID,o.ObjectNumber,ot.Title,ot.TitleTypeID,REPLACE(ot.title,'for: ','for ') AS tFinal
FROM Objects AS o
INNER JOIN ObjTitles AS ot ON o.ObjectID = ot.ObjectID
INNER JOIN PackageList AS pl ON o.ObjectID = pl.ID AND pl.TableID = 108
WHERE PackageID = 135269
AND ot.Title LIKE '%for: %'			--	375
AND ot.TitleTypeID IN (24,26)