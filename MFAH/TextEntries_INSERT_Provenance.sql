


/*
For P&D update 1/17/2017

1	Import spreadsheets into MFAHt_Provenance_Update.
2	Copy provenance values into text entries (using the code below).
3	Update the provenance.
4	Update "Imported" FF only, NOT "Curator Approved" and insert Lauren's comment into the remarks field.
	'Standardized only with ongoing research.'
*/



SELECT * FROM TextTypes

SELECT * FROM TextStatuses


SELECT * FROM Packages WHERE Name LIKE 'P&D Blum Collection ALL'			--	 84074	1369
SELECT * FROM Packages WHERE Name LIKE 'P&D Collect Kelsey Provenance 1'	--	110589	 277
SELECT * FROM Packages WHERE Name LIKE 'P&D Collect Kelsey Provenance 2'	--	110596	 919
SELECT * FROM Packages WHERE Name LIKE 'P&D Collect Kelsey Provenance 3'	--	110607	 217

																			--			2782 Total





SELECT
te.TextEntryID,
te.TableID,
te.ID,
te.TextTypeID,
te.TextStatusID,
ts.TextStatus,
te.Purpose,
te.TextDate,
te.LoginID,
te.EnteredDate,
te.Remarks,
te.TextEntry

FROM TextEntries AS te
INNER JOIN TextStatuses AS ts ON te.TextStatusID = ts.TextStatusID

WHERE te.TextTypeID = 258	--	Old Provenance





SELECT o.ObjectID, o.Provenance
FROM Objects AS o INNER JOIN PackageList AS pl ON o.ObjectID = pl.ID AND pl.TableID = 108
WHERE pl.PackageID IN (84074,110589,110596,110607)
AND o.Provenance IS NOT NULL
-- 52 rows


SELECT o.ObjectID, o.Provenance
FROM Objects AS o
WHERE ObjectID IN
(SELECT pl.ID FROM PackageList AS pl WHERE pl.PackageID IN (84074,110589,110596,110607))
AND o.Provenance IS NOT NULL
-- 52 rows








--INSERT INTO TextEntries (TableID,ID,TextTypeID,TextStatusID,Purpose,TextDate,LoginID,EnteredDate,Remarks,TextEntry)

SELECT
--o.ObjectNumber,
108							AS	TableID,		-- 108 = Objects
pl.ID						AS	ID,				-- Test Record
258							AS	TextTypeID,		-- 258 = Old Provenance
44							AS	TextStatusID,	--  44 = Unapproved
'Provenance Review'			AS	Purpose,
'2017-01-17'				AS	TextDate,
'dthompson'					AS	LoginID,
GETDATE()					AS	EnteredDate,
'The text below was moved from the Provenance field and replaced 1/17/2017 by Dave Thompson at the request of Lauren Rosenblum.'
							AS	Remarks,
o.Provenance				AS	TextEntry

FROM Objects AS o
INNER JOIN PackageList AS pl ON o.ObjectID = pl.ID AND pl.TableID = 108

WHERE pl.PackageID IN (84074,110589,110596,110607)
AND o.Provenance IS NOT NULL

--WHERE o.ObjectID = 110421


--UPDATE Objects
SET Provenance = '[Peter Blum Gallery, Blumarts Inc., New York, by 1996]; purchased by MFAH, 1996.'
--SELECT o.ObjectNumber, o.Provenance
FROM Objects AS o 
INNER JOIN PackageList AS pl ON o.ObjectID = pl.ID AND pl.TableID = 108
WHERE pl.PackageID IN (84074)


--UPDATE Objects
SET Provenance = 'Mavis P. and Mary Wilson Kelsey, Houston, by 1975; given to MFAH, 1975.'
--SELECT o.ObjectNumber, o.Provenance
FROM Objects AS o 
INNER JOIN PackageList AS pl ON o.ObjectID = pl.ID AND pl.TableID = 108
WHERE pl.PackageID IN (110589)


--UPDATE Objects
SET Provenance = 'Mavis P. and Mary Wilson Kelsey, Houston, by 1989; given to MFAH, 1989.'
--SELECT o.ObjectNumber, o.Provenance
FROM Objects AS o 
INNER JOIN PackageList AS pl ON o.ObjectID = pl.ID AND pl.TableID = 108
WHERE pl.PackageID IN (110596)


--UPDATE Objects
SET Provenance = 'Mavis P. and Mary Wilson Kelsey, Houston, by 1991; given to MFAH, 1991.'
--SELECT o.ObjectNumber, o.Provenance
FROM Objects AS o 
INNER JOIN PackageList AS pl ON o.ObjectID = pl.ID AND pl.TableID = 108
WHERE pl.PackageID IN (110607)



--UPDATE UserFieldXrefs
SET FieldValue = 1,
ValueDate = '2017-01-07 00:00',
ValueRemarks = 'Standardized only with ongoing research.'	-- SELECT *
FROM UserFieldXrefs AS ufx
INNER JOIN PackageList AS pl ON pl.ID = ufx.ID AND pl.TableID = 108
WHERE ufx.UserFieldID = 166		-- Uploaded
AND ufx.UserFieldGroupID = 23 
AND pl.PackageID IN (84074,110589,110596,110607)	-- 2782
ORDER BY pl.ID


SELECT o.ObjectID, o.ObjectNumber, o.Provenance, ufx.FieldValue, ufx.ValueDate, ufx.ValueRemarks
FROM Objects AS o 
INNER JOIN UserFieldXrefs AS ufx ON o.ObjectID = ufx.ID 
WHERE ufx.UserFieldGroupID = 23
AND ufx.UserFieldID = 166
AND o.ObjectID = 33956




SELECT * FROM MFAHt_IMPORT_Provenance

--DELETE FROM MFAHt_IMPORT_Provenance WHERE ObjectID = 110421


--INSERT INTO TextEntries (TableID,ID,TextTypeID,TextStatusID,Purpose,TextDate,LoginID,EnteredDate,Remarks,TextEntry)

SELECT
o.ObjectNumber,
108							AS	TableID,		-- 108 = Objects
ip.ObjectID					AS	ID,				-- Test Record
258							AS	TextTypeID,		-- 258 = Old Provenance
44							AS	TextStatusID,	--  44 = Unapproved
'Provenance Review'			AS	Purpose,
'2017-01-17'				AS	TextDate,
'dthompson'					AS	LoginID,
GETDATE()					AS	EnteredDate,
'The text below was moved from the Provenance field and replaced 1/17/2017 by Dave Thompson at the request of Lauren Rosenblum.'
							AS	Remarks,
o.Provenance				AS	TextEntry

FROM Objects AS o
INNER JOIN MFAHt_IMPORT_Provenance AS ip ON o.ObjectID = ip.ObjectID


--WHERE o.ObjectID = 110421

/*
--DELETE 
--SELECT * 
FROM TextEntries 
--INNER JOIN MFAHt_IMPORT_Provenance AS ip ON te.ID = ip.ObjectID AND te.TableID = 108
WHERE TableID = 108
AND TextTypeID = 258
AND TextStatusID = 44
AND Purpose = 'Provenance Review'
AND TextDate = '2017-01-17'
AND LoginID = 'dthompson'
AND EnteredDate > '2017-01-17'
AND ID IN (SELECT ObjectID FROM MFAHt_IMPORT_Provenance)

*/



--UPDATE Objects 
SET Provenance = p.NewProvenance
FROM Objects AS o
INNER JOIN MFAHt_IMPORT_Provenance AS p ON o.ObjectID = p.ObjectID
WHERE o.ObjectID NOT IN
(
	SELECT ObjectID
	FROM MFAHt_IMPORT_Provenance
	GROUP BY ObjectID
	HAVING COUNT(*) > 1		-- 0 objects have more than one record 
)



--UPDATE UserFieldXrefs
SET FieldValue = 1, 
ValueDate = '2017-01-07 00:00',
ValueRemarks = 'Standardized only with ongoing research.'	-- SELECT *
FROM UserFieldXrefs AS ufx
INNER JOIN MFAHt_IMPORT_Provenance AS o ON o.ObjectID = ufx.ID 
WHERE ufx.UserFieldID = 166		-- Uploaded
AND ufx.UserFieldGroupID = 23

