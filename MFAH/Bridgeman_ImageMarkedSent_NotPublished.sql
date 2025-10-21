

SELECT * FROM Packages WHERE Name LIKE '%Bridgeman%'


SELECT * FROM Packages WHERE Name = 'Bridgeman_Reconciliation_200901' -- 309622



SELECT * FROM UserFieldGroups WHERE UserFieldGroupID = 44
--SubmittedTo3rdParty

SELECT * FROM UserFields WHERE UserFieldID = 293
--Bridgeman Images

SELECT * FROM DDContexts WHERE ContextID = 148
--Media Master Flex Fields



SELECT * FROM UserFieldXrefs 
WHERE ContextID = 148
AND UserFieldID = 293 
AND FieldValue = 1



SELECT * 
FROM MediaMaster AS mm
INNER JOIN MediaRenditions AS mr ON mm.MediaMasterID = mr.MediaMasterID
WHERE mm.MediaMasterID = 283232

-- RenditionNumber = 133449



SELECT * FROM Packages WHERE Name = 'Bridgeman_ImageSent_NotPublished' --311144


--INSERT INTO TMS.dbo.PackageList (PackageID, ID, MainData, OrderPos, LoginID, EnteredDate, Notes, TableID)
SELECT DISTINCT
311144										AS PackageID,
o.ObjectID									AS ID,
o.ObjectNumber								AS MainData,
ROW_NUMBER() OVER (ORDER BY o.SortNumber)	AS OrderPos,
'dthompson'									AS LoginID,
GETDATE()									AS EnteredDate,
''											AS Notes,
108											AS TableID

--SELECT o.ObjectID, o.ObjectNumber, o.SortNumber
FROM Objects AS o
WHERE o.ObjectID IN
(
	SELECT mx.ID
	FROM MediaXrefs AS mx
	WHERE MediaMasterID IN
	(
		SELECT ID FROM UserFieldXrefs 
		WHERE ContextID = 148
		AND UserFieldID = 293 
		AND FieldValue = 1
	)
	AND mx.TableID = 108
)
AND o.ObjectID NOT IN
(
	SELECT ID FROM PackageList WHERE PackageID = 309622
)



