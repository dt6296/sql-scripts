
---------------------------------------------------------------------------------

SELECT * FROM MFAHt_IMPORT_Provenance

--DELETE FROM MFAHt_IMPORT_Provenance WHERE ObjectID IS NULL

--DELETE FROM MFAHt_IMPORT_Provenance WHERE NewProvenance IS NULL

--DELETE FROM MFAHt_IMPORT_Provenance WHERE NewProvenance = ''

--DELETE FROM MFAHt_IMPORT_Provenance


--SELECT SUBSTRING(NewProvenance,2,LEN(NewProvenance)-2) FROM MFAHt_IMPORT_Provenance


--UPDATE MFAHt_IMPORT_Provenance
--SET NewProvenance = SUBSTRING(NewProvenance,2,LEN(NewProvenance)-2)


--UPDATE Objects 
SET Provenance = p.NewProvenance -- SELECT o.ObjectID, p.ObjectID, o.Provenance, p.NewProvenance
FROM Objects AS o
INNER JOIN MFAHt_IMPORT_Provenance AS p ON o.ObjectID = p.ObjectID
WHERE o.ObjectID NOT IN
(
	SELECT ObjectID
	FROM MFAHt_IMPORT_Provenance
	GROUP BY ObjectID
	HAVING COUNT(*) > 1		-- 3 objects that have more than one record (x2 = 126)
)

(1913 row(s) affected)   1919 - 6 = 1913




SELECT o.ObjectID, o.ObjectNumber, o.Provenance, p.NewProvenance
FROM Objects AS o INNER JOIN MFAHt_IMPORT_Provenance AS p ON o.ObjectID = p.ObjectID



SELECT o.ObjectID, o.ObjectNumber, o.Provenance, p.NewProvenance
FROM Objects AS o INNER JOIN MFAHt_IMPORT_Provenance AS p ON o.ObjectID = p.ObjectID
WHERE o.Provenance <> p.NewProvenance


SELECT o.ObjectID, o.ObjectNumber, o.Provenance, p.NewProvenance
FROM Objects AS o INNER JOIN MFAHt_IMPORT_Provenance AS p ON o.ObjectID = p.ObjectID
WHERE o.Provenance = p.NewProvenance

SELECT ObjectID, ObjectNumber
FROM MFAHt_IMPORT_Provenance
GROUP BY ObjectID, ObjectNumber
HAVING COUNT(*) > 1
ORDER BY ObjectNumber











------------------------------------------------



--************ Update Curator Approved ************

--UPDATE UserFieldXrefs
SET FieldValue = 1,
ValueDate = '2019-04-09 00:00' -- SELECT *
FROM UserFieldXrefs AS ufx
INNER JOIN MFAHt_IMPORT_Provenance AS o ON o.ObjectID = ufx.ID and ufx.UserFieldGroupID = 23
WHERE ufx.UserFieldID = 167	-- Curator Approved
AND o.ObjectID NOT IN
(
	SELECT ObjectID
	FROM MFAHt_IMPORT_Provenance
	GROUP BY ObjectID
	HAVING COUNT(*) > 1		-- 3 objects that have more than one record (x2 = 6)
)


--************ Update Uploaded

--UPDATE UserFieldXrefs
SET FieldValue = 1,
ValueDate = '2019-04-22 00:00' -- SELECT *
FROM UserFieldXrefs AS ufx
INNER JOIN MFAHt_IMPORT_Provenance AS o ON o.ObjectID = ufx.ID and ufx.UserFieldGroupID = 23
WHERE ufx.UserFieldID = 166		-- Uploaded
AND o.ObjectID NOT IN
(
	SELECT ObjectID
	FROM MFAHt_IMPORT_Provenance
	GROUP BY ObjectID
	HAVING COUNT(*) > 1		-- 3 objects that have more than one record (x2 = 6)
)




------------------------------		This is for updating without an import file		---------------------------------------------------------------

SELECT * FROM UserFields WHERE UserFieldID = 166	--	Uploaded
SELECT * FROM UserFields WHERE UserFieldID = 167	--	Curator Approved


SELECT * FROM Packages WHERE Name = '2019-10-03 1979 for Dave'
PackageID = 261762


--************ Update Provenance ************


--UPDATE Objects SET Provenance = 'Miss Ima Hogg; Estate of Miss Ima Hogg, 1975; given to MFAH, 1979.'
--SELECT o.Provenance
FROM Objects AS o
INNER JOIN PackageList AS pl ON o.ObjectID = pl.ID AND pl.TableID = 108
WHERE pl.PackageID = 261762


--************ Update Curator Approved ************

--UPDATE UserFieldXrefs
SET FieldValue = 1,
ValueDate = '2019-10-03 00:00' -- SELECT o.ObjectNumber, *
FROM UserFieldXrefs AS ufx
INNER JOIN Objects AS o ON o.ObjectID = ufx.ID and ufx.UserFieldGroupID = 23
INNER JOIN PackageList AS pl ON o.ObjectID = pl.ID AND pl.TableID = 108
WHERE ufx.UserFieldID = 167	-- Curator Approved
AND pl.PackageID = 261762

--************ Update Uploaded

--UPDATE UserFieldXrefs
SET FieldValue = 1,
ValueDate = '2019-10-08 00:00' -- SELECT *
FROM UserFieldXrefs AS ufx
INNER JOIN Objects AS o ON o.ObjectID = ufx.ID and ufx.UserFieldGroupID = 23
INNER JOIN PackageList AS pl ON o.ObjectID = pl.ID AND pl.TableID = 108
WHERE ufx.UserFieldID = 166		-- Uploaded
AND pl.PackageID = 261762



--************ Update Curator Approved ************ Based on Object Number

SELECT * FROM UserFields WHERE UserFieldID = 166	--	Uploaded
SELECT * FROM UserFields WHERE UserFieldID = 167	--	Curator Approved


--UPDATE UserFieldXrefs
SET FieldValue = 1,
ValueDate = '2019-06-04 00:00' -- SELECT *
FROM UserFieldXrefs AS ufx
--INNER JOIN MFAHt_IMPORT_Provenance AS o ON o.ObjectID = ufx.ID and ufx.UserFieldGroupID = 23
--WHERE ufx.UserFieldID = 167	-- Curator Approved
WHERE ufx.UserFieldID = 166 -- Uploaded
AND ID IN
(
	SELECT ObjectID
	FROM Objects
	WHERE ObjectNumber LIKE 'B.69.364.%'
)







