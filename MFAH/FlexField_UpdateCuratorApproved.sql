






SELECT * FROM Packages WHERE Name = 'CD_Prov_Afr_Approve [2]'		--	106722
SELECT * FROM Packages WHERE Name = 'CD_Prov_Oceanic_Indo_Approve'	--	106723
SELECT * FROM Packages WHERE Name = 'CD_Prov_AmInd_Approve'			--	106727

SELECT * FROM Packages WHERE Name = 'CD_Prov_Ant_Approve'			--	106745

SELECT * FROM Packages WHERE Name = 'CD_Prov_Af_Glass_Approve'		--	106969



SELECT ObjectNumber FROM Objects WHERE ObjectID IN
(SELECT ID FROM PackageList WHERE PackageID IN (106969))





--UPDATE UserFieldXrefs --(Proveance Curator Approved)
SET FieldValue = 1,
ValueDate = '2016-12-21 00:00' -- SELECT *
FROM UserFieldXrefs AS ufx
INNER JOIN Objects AS o ON o.ObjectID = ufx.ID and ufx.UserFieldGroupID = 23
WHERE ufx.UserFieldID = 167	-- Curator Approved
AND o.ObjectID IN
(SELECT ID FROM PackageList WHERE PackageID IN (106969))
AND FieldValue = 0






SELECT pl.ID, o.ObjectNumber, o.SortNumber, pl.OrderPos
FROM PackageList AS pl
INNER JOIN Objects AS o ON pl.ID = o.ObjectID
WHERE pl.PackageID = 106969 --ORDER BY pl.OrderPos

AND ObjectNumber NOT IN
(
	'97.894', 
	'97.910', 
	'97.985', 
	'97.1046', 
	'97.1084', 
	'97.1243', 
	'97.1267.1', 
	'97.1310', 
	'97.1351.A,.B', 
	'97.1482', 
	'97.1495.1', 
	'97.1495.1,.2', 
	'97.1495.2'
	--and 98.722 through 2010.507 
)

AND pl.OrderPos < 888







--UPDATE UserFieldXrefs --(Proveance Curator Approved)
SET FieldValue = 1,
ValueDate = '2016-12-21 00:00' -- SELECT *
FROM UserFieldXrefs AS ufx
INNER JOIN Objects AS o ON o.ObjectID = ufx.ID and ufx.UserFieldGroupID = 23
WHERE ufx.UserFieldID = 167	-- Curator Approved
AND o.ObjectID IN
(
	SELECT ID FROM PackageList 
	WHERE PackageID IN (106969)
	AND ObjectNumber NOT IN
	(
		'97.894', 
		'97.910', 
		'97.985', 
		'97.1046', 
		'97.1084', 
		'97.1243', 
		'97.1267.1', 
		'97.1310', 
		'97.1351.A,.B', 
		'97.1482', 
		'97.1495.1', 
		'97.1495.1,.2', 
		'97.1495.2'
		--and 98.722 through 2010.507 
	)
	AND OrderPos < 888
)
AND FieldValue = 0






--UPDATE Objects SET Provenance = 'Alfred C. Glassell, Jr. (1913–2008), Houston, before 1997; given to MFAH, 1997.'
--SELECT Provenance
FROM UserFieldXrefs AS ufx
INNER JOIN Objects AS o ON o.ObjectID = ufx.ID and ufx.UserFieldGroupID = 23
WHERE ufx.UserFieldID = 167	-- Curator Approved
AND o.ObjectID IN
(
	SELECT ID FROM PackageList 
	WHERE PackageID IN (106969)
	AND ObjectNumber NOT IN
	(
		'97.894', 
		'97.910', 
		'97.985', 
		'97.1046', 
		'97.1084', 
		'97.1243', 
		'97.1267.1', 
		'97.1310', 
		'97.1351.A,.B', 
		'97.1482', 
		'97.1495.1', 
		'97.1495.1,.2', 
		'97.1495.2'
		--and 98.722 through 2010.507 
	)
	AND OrderPos < 888
)
--AND FieldValue = 0


