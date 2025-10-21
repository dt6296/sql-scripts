


SELECT COUNT(*) FROM Objects WHERE OnView = 1	-- 1688				0
SELECT COUNT(*) FROM Objects WHERE OnView = 0	-- 133944			135052




------------------------------------------------------------------------------------------------------------------- Do this FIRST.
--UPDATE Objects SET OnView = 0 WHERE OnView = 1							-- 1725




SELECT
--COUNT(*)

o.ObjectNumber, 
o.OnView AS ObjectOnView,
ol.OnView AS ObjLocOnView,
ol.CurLocationString

FROM MFAHv_OBJ_Location AS ol 
INNER JOIN Objects AS o ON ol.ObjectID = o.ObjectID

--WHERE o.OnView = 1
--WHERE ol.OnView = 1
--AND o.OnView = ol.OnView
WHERE o.OnView <> ol.OnView

AND ol.ObjectID  NOT IN
(
	SELECT 
	oc.ObjectID
	FROM ObjComponents AS oc
	GROUP BY oc.ObjectID
	HAVING COUNT(oc.ComponentID) > 1
)

GROUP BY
o.OnView,
ol.OnView,
ol.CurLocationString

------------------------------------------------------------------------------------------------------------------------------- NOT this one.

--UPDATE Objects SET OnView = 1 WHERE ObjectID IN
(
	SELECT --DISTINCT
	ObjectID,

	CAST(ISNULL(CASE WHEN l.UnitPosition LIKE '%on view%'
	THEN 1 ELSE
	CASE WHEN l.[Site] = 'LOAN'
	THEN 0 ELSE
	CASE WHEN ol.LocationID = -1
	THEN 0 ELSE 0 END END END,'') AS BIT) AS OnView
	
	FROM ObjComponents AS oc
	INNER JOIN ObjLocations AS ol ON oc.CurrentObjLocID = ol.ObjLocationID
	LEFT OUTER JOIN Locations AS l ON ol.LocationID = l.LocationID

	WHERE
	CAST(ISNULL(
		CASE WHEN l.UnitPosition LIKE '%on view%'	THEN 1 ELSE
		CASE WHEN l.[Site] = 'LOAN'	THEN 0 ELSE
		CASE WHEN ol.LocationID = -1	THEN 0 ELSE 
		0 END END END,'') AS BIT) = 1
)

---------------------------------------------------------------------------- Use THIS one.

--UPDATE Objects SET OnView = 1 WHERE ObjectID IN
(
	SELECT DISTINCT
	oc.ObjectID

	FROM ObjComponents AS oc
	INNER JOIN MFAHv_OBJ_Location AS ol ON oc.ComponentID = ol.ComponentID
	LEFT OUTER JOIN Locations AS l ON ol.CurLocationID = l.LocationID

	WHERE
	ol.OnView = 1
	AND oc.Inactive = 0
)

----------------------------------------------------------------------------------------------------------------------------

-- LOCATION RECORD - BUILDING / GALLERY

SELECT
l.LocationID,
l.LocationString,

ISNULL(CASE WHEN l.UnitPosition LIKE '%on view%' THEN ca.DisplayName1 ELSE '' END,'') --AS DisplayLocation 
+ CHAR(13) + 
ISNULL(CASE WHEN l.UnitPosition LIKE '%on view%' THEN dbo.MFAHfx_Proper(l.Room) ELSE '' END,'') AS TextEntry,

ISNULL(CASE WHEN l.UnitPosition LIKE '%on view%' THEN '<p>' + ca.DisplayName1 + '</p>' ELSE '' END,'') --AS DisplayLocation 
+
ISNULL(CASE WHEN l.UnitPosition LIKE '%on view%' THEN '<p>' + dbo.MFAHfx_Proper(l.Room) + '</p>' ELSE '' END,'') AS TextEntryHTML

FROM Locations AS l 
LEFT OUTER JOIN ConAddress AS ca ON l.AddressID = ca.ConAddressID

WHERE l.UnitPosition LIKE '%on view%'
AND l.Active = 1



INSERT INTO TextEntries (TableID, ID, TextTypeID, TextStatusID, Purpose, TextDate, LoginID, EnteredDate, AuthorConID, TextEntry, LanguageID)
SELECT
83,						-- TableID
l.LocationID,		-- ID
--324,						-- TextTypeID -- LocationDisplay_Building
325,						-- TextTypeID -- LocationDisplay_GalleryRoom
23,						-- TextStatusID,
'eMuseum',			-- Purpose
'2020-02-21'	,		-- TextDate
'dthompson',		-- LoginID
GETDATE()	,		-- EnteredDate
29872,					-- AuthorConID

--ISNULL(CASE WHEN l.UnitPosition LIKE '%on view%' THEN ca.DisplayName1 ELSE '' END,''), -- TextEntry = LocationDisplay_Building
ISNULL(CASE WHEN l.UnitPosition LIKE '%on view%' THEN dbo.MFAHfx_Proper(l.Room) ELSE '' END,''),	-- TextEntry= LocationDisplay_GalleryRoom

1					-- LanguageID

FROM Locations AS l 
LEFT OUTER JOIN ConAddress AS ca ON l.AddressID = ca.ConAddressID

WHERE l.UnitPosition LIKE '%on view%'
AND l.Active = 1








--DELETE FROM TextEntries WHERE TableID = 83 AND TextTypeID = 323

SELECT * FROM TextTypes WHERE TableID = 83


SELECT * FROM TextEntries
WHERE TableID = 83	-- Locations
AND TextTypeID = 323 -- LocationDisplay

TextTypeID = 323 -- LocationDisplay
TextTypeID = 324 -- LocationDisplay_Building
TextTypeID = 325 -- LocationDisplay_GalleryRoom

SELECT * FROM TextStatuses ORDER BY TextStatus

SELECT * FROM DDLanguages


SELECT * FROM Locations WHERE LocationID = 174

