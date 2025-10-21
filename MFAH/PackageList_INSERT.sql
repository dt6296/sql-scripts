
SELECT
pf.FolderID,
pf.FolderName,
pf.FolderTypeID,
pft.FolderType,
p.PackageID,
p.Name AS PackageName,
p.Notes,
p.Owner,
p.PackageType,
p.Global,
p.Locked,
p.ItemCount,
p.DisplayRecID

FROM PackageFolders AS pf
INNER JOIN FolderTypes AS pft ON pf.FolderTypeID = pft.FolderTypeID
INNER JOIN PackageFolderXrefs AS pfx ON pf.FolderID = pfx.FolderID
INNER JOIN Packages AS p ON pfx.PackageID = p.PackageID

--WHERE pf.FolderID = 1353	--	MFAH Collecting Areas
WHERE pf.FolderID = 1354	--	Adolpho Leirner Collection of Brazilian Constructive Art -- 240410


SELECT 
o.ObjectID,
o.ObjectNumber,
o.SortNumber,
o.ObjectStatusID,
os.ObjectStatus,
o.DepartmentID,
d.Department,
o.PublicAccess

FROM Objects AS o
INNER JOIN ObjectStatuses AS os ON o.ObjectStatusID = os.ObjectStatusID
INNER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID

WHERE o.ObjectStatusID = 2					-- Accessioned O-bject
AND o.PublicAccess = 1						-- Approved for Web
--AND o.DepartmentID IN (1)					-- European Art - 240380




SELECT * FROM Departments WHERE MainTableID = 108 ORDER BY Department


--- Insert records into package based on custom query


SELECT * FROM Packages WHERE Name LIKE 'MediaWithMultiple%'		--	277763


--INSERT INTO TMS.dbo.PackageList (PackageID, ID, MainData, OrderPos, LoginID, EnteredDate, Notes, TableID)
SELECT DISTINCT
248448,
o.ObjectID,
o.ObjectNumber,
ROW_NUMBER() OVER (ORDER BY o.SortNumber),
'dthompson',
GETDATE(),
NULL,
108

FROM Objects AS o

WHERE  1=1
AND o.PublicAccess = 1						-- Approved for Web

AND	o.ObjectStatusID = 2					-- Accessioned Object
--AND o.ObjectStatusID = 27					-- Blaffer Foundation Accession

--AND o.DepartmentID IN (1)					-- European Art - 240380
--AND o.DepartmentID IN (15,111,16,113,17)	-- Arts of Africa, Oceania & the Americas - 240369
--AND o.DepartmentID IN (2)					-- Decorative Arts, Craft & Design - 240370
AND o.DepartmentID IN (116)				-- Latin American Art - 240371
--AND o.DepartmentID IN (9)					-- Prints and Drawings - 240376
--AND o.DepartmentID IN (6)					-- Antiquities - 240377
--AND o.DepartmentID IN (14,112)			-- Arts of Asia - 240378
--AND o.DepartmentID IN (1,22)				-- European Art - 240380	- !!!!
--AND o.DepartmentID IN (5)					-- Modern & Contemporary Art - 240381
--AND o.DepartmentID IN (20)				-- Rienzi - 240382
--AND o.DepartmentID IN (121)				-- Art of the Islamic Worlds - 240383
--AND o.DepartmentID IN (3,37)				-- Bayou Bend - 240384
--AND o.DepartmentID IN (102)				-- Film - 240385
--AND o.DepartmentID IN (11)				-- Photography - 240386
--AND o.DepartmentID IN (10)				-- American Painting & Sculpture - 240368
--AND o.DepartmentID IN (68)				-- Sarah Campbell Blaffer Foundation - 240387

AND o.CreditLine LIKE '%Leirner%' -- 240410

--DELETE FROM PackageList WHERE PackageID = 240380



------------------------------------------------------------------------------------------- Insert from Custom Query


SELECT * FROM Packages WHERE Name LIKE 'Objects without Image%'		--	248448


--INSERT INTO TMS.dbo.PackageList (PackageID, ID, MainData, OrderPos, LoginID, EnteredDate, Notes, TableID)
SELECT DISTINCT
248448										AS PackageID,
o.ObjectID									AS ID,
o.ObjectNumber								AS MainData,
ROW_NUMBER() OVER (ORDER BY o.SortNumber)	AS OrderPos,
'dthompson'									AS LoginID,
GETDATE()									AS EnteredDate,
o.CurLocationString							AS Notes,
108											AS TableID

FROM
(
	SELECT
	o.ObjectID,
	o.ObjectNumber,
	o.SortNumber,
	ol.CurLocationString,
	ol.CurSite,
	ol.CurRoom,
	ol.CurUnitType,
	ol.CurUnitNumber,
	ol.CurUnitPosition

	FROM Objects AS o
	LEFT OUTER JOIN MFAHv_OBJ_Location_ActiveComponent_First AS ol ON o.ObjectID = ol.ObjectID

	WHERE o.ObjectStatusID IN (2,27) -- Accessioned, Blaffer
	AND o.ObjectID NOT IN
	(
		SELECT 
		mx.ID
		FROM MediaXrefs AS mx 
		LEFT OUTER JOIN MediaRenditions AS mr ON mx.MediaMasterID = mr.MediaMasterID
		LEFT OUTER JOIN MediaMaster AS mm ON mr.MediaMasterID = mm.MediaMasterID
		LEFT OUTER JOIN MediaFiles AS mf ON mr.RenditionID = mf.RenditionID
		LEFT OUTER JOIN MediaFormats AS ft ON mf.FormatID = ft.FormatID
		LEFT OUTER JOIN MediaTypes AS mt ON mr.MediaTypeID = mt.MediaTypeID
		WHERE TableID = 108
		AND mt.MediaTypeID IN (1,28,29,30,31,32,33) 
	)
	--ORDER BY o.SortNumber
) AS o



--------------------------------------------------------------------------------------------------------------------

SELECT DISTINCT
o.ObjectID,
o.ObjectNumber,
oi.RenditionNumber,
ol.CurSite,
ROW_NUMBER() OVER (ORDER BY o.SortNumber)


FROM Objects AS o
LEFT OUTER JOIN MFAHv_OBJ_Image AS oi ON o.ObjectID = oi.ObjectID
LEFT OUTER JOIN MFAHv_OBJ_Location_ActiveComponent_First AS ol ON o.ObjectID = ol.ObjectID

WHERE o.DepartmentID = 3		-- Bayou Bend
AND o.ObjectStatusID = 2	-- Accessioned Objects
AND oi.ObjectID IS NULL		-- 1018 records
AND ol.CurSite = 'PARK 288'
AND o.ObjectID = 17436

ORDER BY o.SortNumber


SELECT * FROM Packages WHERE Name LIKE 'Bayou Bend Objects without%' -- PackageID = 118312
SELECT * FROM PackageList WHERE PackageID = 118312


--INSERT INTO TMS.dbo.PackageList (PackageID, ID, MainData, OrderPos, LoginID, EnteredDate, Notes, TableID)

SELECT	DISTINCT
118312,
o.ObjectID,
o.ObjectNumber,
ROW_NUMBER() OVER (ORDER BY o.SortNumber),
'dthompson',
GETDATE(),
NULL,
108
FROM Objects AS o
WHERE o.ObjectID NOT IN
(
	SELECT
	o.ObjectID
	FROM			Objects					AS o
	LEFT OUTER JOIN MediaXrefs				AS mx	ON	o.ObjectID = mx.ID	AND	mx.TableID = 108
	LEFT OUTER JOIN	MediaMaster				AS mm	ON	mx.MediaMasterID = mm.MediaMasterID
	LEFT OUTER JOIN	MediaRenditions			AS mr	ON	mm.MediaMasterID = mr.MediaMasterID
	WHERE mr.MediaTypeID = 1
)
AND o.ObjectStatusID = 2
AND o.DepartmentID IN (3,37)

ORDER BY o.SortNumber


--------------------------------------------------------------------


--INSERT INTO TMS.dbo.PackageList (PackageID, ID, MainData, OrderPos, LoginID, EnteredDate, Notes, TableID)

SELECT 
PackageID, 
ID, 
MainData, 
ROW_NUMBER() OVER (ORDER BY sq.AlphaSort) AS OrderPos,
LoginID, 
EnteredDate, 
Notes, 
TableID

FROM	-- This gets rid of the duplicates
(
	SELECT DISTINCT
	124632				AS PackageID,
	c.ConstituentID		AS ID,
	c.DisplayName		AS MainData,
	c.AlphaSort,
	'dthompson'			AS LoginID,
	GETDATE()			AS EnteredDate,
	NULL				AS Notes,
	23					AS TableID
	FROM ThesXrefs  AS tx
	LEFT OUTER JOIN Constituents AS c ON tx.ID = c.ConstituentID AND tx.TableID = 23
	WHERE tx.ThesXrefTypeID = 4
)	AS sq



----------------------------------------------------------------------------------- OCM Label Text Entries 2/19/16


SELECT * FROM Packages WHERE Name LIKE '%OCM%' -- PackageID = 38971
SELECT * FROM PackageList WHERE PackageID = 38971 ORDER BY OrderPOS DESC




--INSERT INTO TMS.dbo.PackageList												--(294 row(s) affected)
(PackageID, ID, MainData, OrderPos, LoginID, EnteredDate, Notes, TableID)

SELECT DISTINCT
38971,
o.ObjectID,
o.ObjectNumber,
ROW_NUMBER() OVER (ORDER BY o.SortNumber) + (SELECT MAX(OrderPOS) FROM PackageList WHERE PackageID = 38971),
'dthompson',
GETDATE(),
NULL,
108

FROM			Objects			AS o 
LEFT OUTER JOIN MediaXrefs		AS mx	ON	o.ObjectID			= mx.ID
										AND mx.TableID			= 108
LEFT OUTER JOIN MediaRenditions	AS mr	ON	mx.MediaMasterID	= mr.MediaMasterID

WHERE te.Purpose = 'OCM'
AND te.TextTypeID = 212	-- Label Text
AND te.LoginID = 'lgraveline'
AND o.ObjectID NOT IN
(
	SELECT ID FROM PackageList WHERE PackageID = 38971
)





----------------------------------------------------------------------------------- Constituent Gender 2/21/16

SELECT * FROM DDTables
SELECT * FROM Packages WHERE TableID = 23
SELECT * FROM Packages WHERE Name LIKE '%Gender%' -- PackageID = 50341
SELECT * FROM PackageList WHERE PackageID = 50341 ORDER BY OrderPOS DESC




--INSERT INTO TMS.dbo.PackageList		--										8936
(PackageID, ID, MainData, OrderPos, LoginID, EnteredDate, Notes, TableID)

SELECT DISTINCT
50341,
c.ConstituentID,
c.DisplayName,
ROW_NUMBER() OVER (ORDER BY c.AlphaSort),-- + (SELECT MAX(OrderPOS) FROM PackageList WHERE PackageID = 50341),
'dthompson',
GETDATE(),
NULL,
23

FROM Constituents AS c

WHERE c.ConstituentID IN
(
SELECT
tx.ID
FROM ThesXrefs AS tx
INNER JOIN Terms AS t ON tx.TermID = t.TermID
INNER JOIN Constituents AS c ON tx.ID = c.ConstituentID
WHERE tx.TableID = 23
AND tx.TermID IN (105,106,201187,201188,201452)
--ORDER BY c.AlphaSort
)


--------------------------------------------------------------------------------------- Provenance - 20xx


SELECT * FROM Packages WHERE Name LIKE 'Provenance%' -- PackageID = 56842





--INSERT INTO TMS.dbo.PackageList												--(474 row(s) affected)
(PackageID, ID, MainData, OrderPos, LoginID, EnteredDate, Notes, TableID)

SELECT DISTINCT
56918,
o.ObjectID,
o.ObjectNumber,
ROW_NUMBER() OVER (ORDER BY o.SortNumber) + (SELECT ISNULL(MAX(OrderPOS),0) FROM PackageList WHERE PackageID = 56918),
'dthompson',
GETDATE(),
NULL,
108

FROM Objects AS o
INNER JOIN MFAHvr_OBJ_Value_Acquisitions AS ov ON o.ObjectID = ov.ObjectID 

WHERE 
	o.PublicAccess = 1
AND o.ObjectStatusID IN (2,27)
AND ov.ReportStatus = 1
AND ov.CY = 2011
AND o.ObjectID NOT IN
(
	SELECT ID FROM PackageList WHERE PackageID = 56918
)




----------------------------------------------------------------------------------------------




SELECT * FROM Packages WHERE Name LIKE 'RecordsToDelete' -- PackageID = 91614

SELECT * FROM Objects WHERE ObjectID BETWEEN 133978 AND 134046 ORDER BY EnteredDate DESC




--INSERT INTO TMS.dbo.PackageList (PackageID, ID, MainData, OrderPos, LoginID, EnteredDate, Notes, TableID)

SELECT DISTINCT
91614,
ObjectID,
ObjectNumber,
ROW_NUMBER() OVER (ORDER BY SortNumber) + (SELECT ISNULL(MAX(OrderPOS),0) FROM PackageList WHERE PackageID = 56918),
'dthompson',
GETDATE(),
NULL,
108
FROM Objects
WHERE ObjectID BETWEEN 133978 AND 134046

---------------------------------------------------------------------------------


SELECT * FROM Departments WHERE MainTableID = 108	--	9





SELECT o.ObjectID, o.AccessionNumber, o.SortNumber, lt.TextEntry
FROM MFAHv_OCM_Object AS o
INNER JOIN MFAHv_OCM_ObjectLabelText AS lt ON o.ObjectID = lt.ID AND lt.TableID = 108
WHERE o.DepartmentID = 13

SELECT * FROM Packages WHERE Name = 'P&D Objects with OCM Label Text'	--	111588


--INSERT INTO TMS.dbo.PackageList (PackageID, ID, MainData, OrderPos, LoginID, EnteredDate, Notes, TableID)
SELECT DISTINCT
111588,
lt.ID,
o.AccessionNumber,
ROW_NUMBER() OVER (ORDER BY o.SortNumber),
'dthompson',
GETDATE(),
NULL,
108
FROM MFAHv_OCM_Object AS o
INNER JOIN MFAHv_OCM_ObjectLabelText AS lt ON o.ObjectID = lt.ID AND lt.TableID = 108
WHERE o.DepartmentID = 13


------------------------------------


SELECT * FROM Packages WHERE Name LIKE 'Bayou Bend Objects without Studio Photography'		-- 118718




--INSERT INTO TMS.dbo.PackageList (PackageID, ID, MainData, OrderPos, LoginID, EnteredDate, Notes, TableID)

SELECT DISTINCT
118718,
so.ObjectID,
so.ObjectNumber,
ROW_NUMBER() OVER (ORDER BY so.SortNumber),
'dthompson',
GETDATE(),
NULL,
108

FROM

(
	SELECT DISTINCT
	o.ObjectID,
	o.ObjectNumber,
	o.SortNumber

	FROM Objects AS o
	LEFT OUTER JOIN MFAHv_OBJ_Image AS oi ON o.ObjectID = oi.ObjectID

	WHERE o.DepartmentID = 3	-- Bayou Bend 14741 records
	AND o.ObjectStatusID = 2	-- Accessioned objects 11826 records

	AND o.ObjectID NOT IN		-- 5395 records
	(
		SELECT DISTINCT
		ObjectID
		FROM MFAHv_OBJ_Image
		WHERE ImageCaption LIKE '%publication quality%'	-- 21661
	)
	--AND o.ObjectID = 268
) AS so

----------------------------------------------------------------------------------------------------


SELECT * FROM Packages WHERE Name = 'P&D with Prefix 170316'	-- 120520


--INSERT INTO TMS.dbo.PackageList (PackageID, ID, MainData, OrderPos, LoginID, EnteredDate, Notes, TableID)

SELECT DISTINCT
120520,
so.ObjectID,
so.ObjectNumber,
ROW_NUMBER() OVER (ORDER BY so.SortNumber),
'dthompson',
GETDATE(),
NULL,
108

FROM
(
	SELECT DISTINCT
	oc.o_ObjectID AS ObjectID,
	o.ObjectNumber,
	o.SortNumber
	--,	oc.cx_Role,	oc.cxd_Prefix,	oc.c_DisplayName


	FROM MFAHv_OBJ_Constituent AS oc
	INNER JOIN MFAHv_OBJ AS o ON oc.o_ObjectID = o.ObjectID

	WHERE oc.cx_RoleTypeID = 1
	AND o.ObjectStatusID = 2
	AND o.DepartmentID = 9
	AND oc.cxd_Prefix IS NOT NULL 
	AND oc.cxd_Prefix <> ''

	--ORDER BY o.SortNumber	
) AS so


------------------------------------------------------------------------------------------- Media Loader
------------------------------------------------------------------------------------------- and to load LTA database

DELETE FROM MFAHt_PackageInsert

-- Cut-and-paste IDs from spreadsheet into MFAHt_PackageInsert
-- Create object package in TMS



SELECT TOP 10 * FROM Packages WHERE PackageType = 1 ORDER BY EnteredDate DESC	-- 224941



--INSERT INTO TMS.dbo.PackageList (PackageID, ID, MainData, OrderPos, LoginID, EnteredDate, Notes, TableID)

SELECT DISTINCT
224941,
p.ObjectID,
o.ObjectNumber,
ROW_NUMBER() OVER (ORDER BY o.SortNumber),
'dthompson',
GETDATE(),
NULL,
108

FROM MFAHt_PackageInsert AS p
INNER JOIN Objects AS o ON p.ObjectID = o.ObjectID


SELECT * FROM PackageList WHERE PackageID = 224941




------------------------------------------------------------------------------------ Objects without Primary Image  4/2/2019



SELECT * FROM Packages WHERE PackageID = 234243	-- Objects without Primary Image
SELECT * FROM Packages WHERE PackageID = 234257	-- Objects without Primary Image - NonAccessioned


SELECT * FROM PackageList WHERE PackageID = 234243
SELECT * FROM PackageList WHERE PackageID = 234257



--INSERT INTO TMS.dbo.PackageList (PackageID, ID, MainData, OrderPos, LoginID, EnteredDate, Notes, TableID)
SELECT
--234243,
234257,
sq.ID AS ObjectID,
sq.ObjectNumber,
ROW_NUMBER() OVER (ORDER BY sq.SortNumber),
'dthompson',
GETDATE(),
'',
108

FROM
(
	SELECT mx.ID, o.ObjectNumber, o.SortNumber

	FROM MediaXrefs AS mx
	INNER JOIN Objects AS o ON mx.ID = o.ObjectID AND mx.TableID = 108
	INNER JOIN MediaMaster AS mm ON mx.MediaMasterID = mm.MediaMasterID
	INNER JOIN MediaRenditions AS mr ON mm.MediaMasterID = mr.MediaMasterID
	INNER JOIN MediaFiles AS mf ON mr.PrimaryFileID = mf.FileID
	INNER JOIN MediaFormats AS f ON mf.FormatID = f.FormatID AND f.MediaTypeID = 1

--	WHERE o.ObjectStatusID IN (2,27)		-- Accessioned Objects (1058)
	WHERE o.ObjectStatusID NOT IN (2,27)	-- Non-accessioned Objects (777)
	GROUP BY mx.ID, o.ObjectNumber, o.SortNumber

	HAVING SUM(mx.PrimaryDisplay) = 0
)	AS sq



----------------------------------------------------------------------------------------------------------------------------------------------- Inser into Media Package

SELECT * FROM Packages WHERE Name LIKE 'MediaWithMultiple%'			-- 277763




--INSERT INTO TMS.dbo.PackageList (PackageID, ID, MainData, OrderPos, LoginID, EnteredDate, Notes, TableID)
SELECT
277763																											AS PackageID,
sq.MediaMasterID																							AS ID,
NULL																												AS MainData,
ROW_NUMBER() OVER (ORDER BY sq.MediaMasterID)							AS OrderPos,
'dthompson'																										AS LoginID,
GETDATE()																										AS EnteredDate,
sq.CountRenditions																							AS Notes,
318																													AS TableID

	FROM
		(
			SELECT mm.MediaMasterID, COUNT(mr.RenditionID) AS CountRenditions
			FROM MediaMaster AS mm
			LEFT OUTER JOIN MediaRenditions AS mr ON mm.MediaMasterID = mr.MediaMasterID
			GROUP BY mm.MediaMasterID
			HAVING COUNT(mm.MediaMasterID)>1
		)
	AS sq




