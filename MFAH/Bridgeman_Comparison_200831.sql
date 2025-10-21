


SELECT b.*, o.ObjectID
FROM MFAHt_Bridgeman AS b
LEFT OUTER JOIN Objects AS o ON b.SupplierReference = o.ObjectNumber
WHERE o.ObjectNumber IS NOT NULL	-- 7176
--WHERE o.ObjectNumber IS NULL		-- 194


SELECT * FROM UserFields WHERE UserFieldID = 293 -- Bridgeman Images
SELECT * FROM DDContexts WHERE ContextID = 148 -- MEDIA_MASTER, Media Master Flex Fields


SELECT
ufx.*
FROM UserFieldXrefs AS ufx
WHERE ufx.UserFieldID = 293
AND ufx.FieldValue = 1

SELECT * FROM DDTables WHERE TableID = 318

SELECT DISTINCT ObjectID FROM
(
	SELECT 
	b.*, 
	o.ObjectID, 
	o.ObjectNumber,
	mx.MediaMasterID,
	mr.RenditionNumber,
	uf.UserFieldName, ufx.FieldValue, ufx.ValueDate, ufx.ValueRemarks
	FROM MFAHt_Bridgeman AS b
	LEFT OUTER JOIN Objects AS o ON b.SupplierReference = o.ObjectNumber
	LEFT OUTER JOIN MediaXrefs AS mx ON o.ObjectID = mx.ID AND mx.TableID = 108
	LEFT OUTER JOIN MediaRenditions AS mr ON mx.MediaMasterID = mr.MediaMasterID
	LEFT OUTER JOIN UserFieldXrefs AS ufx ON mx.MediaMasterID = ufx.ID AND ufx.UserFieldID = 293
	LEFT OUTER JOIN UserFields AS uf ON ufx.UserFieldID = uf.UserFieldID
	WHERE o.ObjectNumber IS NOT NULL	-- 7176
	AND ufx.FieldValue = 1
) AS q







SELECT * FROM Packages WHERE Name = 'Bridgeman_Reconciliation_200901'		--	309622


--INSERT INTO TMS.dbo.PackageList (PackageID, ID, MainData, OrderPos, LoginID, EnteredDate, Notes, TableID)
SELECT DISTINCT
309622										AS PackageID,
o.ObjectID									AS ID,
o.ObjectNumber								AS MainData,
ROW_NUMBER() OVER (ORDER BY o.SortNumber)	AS OrderPos,
'dthompson'									AS LoginID,
GETDATE()									AS EnteredDate,
''											AS Notes,
108											AS TableID

FROM
(
	SELECT DISTINCT ObjectID, ObjectNumber, SortNumber FROM
	(
		SELECT 
		b.*, 
		o.ObjectID, 
		o.ObjectNumber,
		o.SortNumber,
		mx.MediaMasterID,
		mr.RenditionNumber,
		uf.UserFieldName, ufx.FieldValue, ufx.ValueDate, ufx.ValueRemarks
		FROM MFAHt_Bridgeman AS b
		LEFT OUTER JOIN Objects AS o ON b.SupplierReference = o.ObjectNumber
		LEFT OUTER JOIN MediaXrefs AS mx ON o.ObjectID = mx.ID AND mx.TableID = 108
		LEFT OUTER JOIN MediaRenditions AS mr ON mx.MediaMasterID = mr.MediaMasterID
		LEFT OUTER JOIN UserFieldXrefs AS ufx ON mx.MediaMasterID = ufx.ID AND ufx.UserFieldID = 293
		LEFT OUTER JOIN UserFields AS uf ON ufx.UserFieldID = uf.UserFieldID
		WHERE o.ObjectNumber IS NOT NULL	-- 7176
		AND ufx.FieldValue = 1
	) AS q
) AS o









