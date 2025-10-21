



SELECT DISTINCT
ca.ConAddressID,
ca.ShortName,
ca.DisplayName1,
ca.DisplayName2,
l.LocationID,
l.Site,
l.Room	AS Subsite,			--Subsite
l.UnitType,
l.UnitPosition
--, ol.SubLevel

FROM			Locations		AS l
LEFT OUTER JOIN	ConAddress		AS ca	ON l.AddressID = ca.ConAddressID
--LEFT OUTER JOIN ObjLocations	AS ol	ON l.LocationID = ol.LocationID		-- adding this returned 14,823 records

WHERE 
--(l.Active = 1 AND l.[External] = 0)		-- 4549 records

--AND l.LocationString LIKE '%North%'

/*

l.LocationString LIKE '%360%' OR l.LocationString LIKE '%PEARL%'
LocationID		= 9604
ShortName		= 11 DORA MAAR HOUSE
Site			= 360 ART SERVICES
ConAddressID	= 12383

LocationID		= 10001
ShortName		= 11 DORA MAAR HOUSE
Site			= PEARL FINCHER MUSEUM
ConAddressID	= 12383

*/







--SELECT * FROM DDColumns WHERE ColumnName LIKE '%SubLevel%'
--SELECT * FROM DDColumns WHERE ColumnID = 925
--SELECT * FROM DDLocalColumnNames WHERE ColumnLabel LIKE '%site%'
--SELECT * FROM DDTables WHERE TableID = 94 = ObjComponents --119 = ObjLocations

--SELECT DISTINCT SubLevel FROM ObjLocations ORDER BY SubLevel
--There are 10,939 DISTINCT SubLevels in ObjLocations, most of which seem like specific one-offs, some of which might be real locaitons?






SELECT * FROM ObjCurLocView WHERE ObjectID = 88473




SELECT
dtn.*,
dt.PhysTableID,
dt.TableID,
dt.TableName
 
FROM DDLocalTableNames AS dtn
INNER JOIN DDTables AS dt ON dtn.TableID = dt.TableID
WHERE dtn.TableLabel LIKE 'Current%'
AND dtn.LanguageID = 1

SELECT * FROM DDTables WHERE PhysTableID = 83


SELECT * FROM vListViewObjectInfoCurrentLocation AS cl
WHERE ID = 88473




SELECT
lvo.ID,
lvo.ObjectNumber,
oclv.ObjectID,
oclv.ComponentID,
oclv.ComponentNumber,
oclv.CurLevel,
oclv.CurRoom,
oclv.CurSite,
oclv.CurSublevel,
oclv.CurUnitNumber,
oclv.CurUnitPosition,
oclv.CurUnitType

FROM vListViewObjects AS lvo
LEFT OUTER JOIN ObjCurLocView AS oclv ON lvo.ID = oclv.ObjectID

WHERE lvo.ID = 88473





SELECT
COUNT(*)

FROM Locations AS l

WHERE l.UnitPosition = 'on view'


SELECT
ol.LocLevel,
COUNT (*)
FROM ObjLocations AS ol
GROUP BY ol.LocLevel

WHERE ol.Sublevel = 'on view'


SELECT
l.LocationID,
l.Site,
l.Room,
l.UnitType,
l.UnitNumber,
l.UnitPosition,
l.Active,
l.PublicAccess,
l.SecurityCode,
l.Description,
l.LocationString,
l.[External]

FROM  Locations AS l
INNER JOIN
(
	SELECT l.Room, COUNT (*) AS CountUnitNumber
	FROM Locations AS l
	GROUP BY l.Room
	HAVING COUNT(*) > 1
)	AS subl	ON l.Room = subl.Room

--WHERE l.PublicAccess = 1
ORDER BY l.Site, l.Room


SELECT
l.SecurityCode,
COUNT(*)
FROM Locations AS l
GROUP BY l.SecurityCode

SELECT
l.PublicAccess,
COUNT(*)
FROM Locations AS l
GROUP BY l.PublicAccess




SELECT
--ol.LocationID,
ol.LocLevel,
ol.Sublevel,
COUNT(*)
FROM ObjLocations AS ol
GROUP BY
--ol.LocationID,
ol.LocLevel,
ol.Sublevel


/*
Location Authority Hierarchy

Site
Subsite
Unit Type
Unit Number
Unit Position

*/


SELECT
ol.*
FROM ObjLocations AS ol
--WHERE ol.LocationID = 12036	--(NULL)	77 records
WHERE ol.LocationID = 9924		--(on view)	128 records


/*

I think I can solve the multiple location issue by writing a script like:

COUNT (*)

FROM			ObjLocations	AS OL		--ON OC.CurrentObjLocID = OL.ObjLocationID 
LEFT OUTER JOIN Locations		AS L		ON OL.LocationID = L.LocationID
LEFT OUTER JOIN Crates			AS CurCr	ON OL.CrateID = CurCr.CrateID
(see MFAHv_OBJ_Location and Location_Displayed for full clause)

WHERE	OL.TransCodeID < 4
AND		OL.Active = 1
AND		oc.Inactive = 0			
AND		oc.ComponentType = 0	-- Part of an object

If any have COUNT (*) > 1 THEN flag somehow to not include the record in the OCM



Also:
I think we should use the PublicAccess field for "on view" instead of Locations.UnitPosition
since it isn't always correct and found in another Locations field.
37 or so locations are marked PublicAccess = 1 when they aren't accessible to the public.


"On view" is also found in CurSubLevel.

*/




SELECT

COUNT (*)

FROM			ObjLocations	AS OL		--ON OC.CurrentObjLocID = OL.ObjLocationID 
LEFT OUTER JOIN Locations		AS L		ON OL.LocationID = L.LocationID
LEFT OUTER JOIN Crates			AS CurCr	ON OL.CrateID = CurCr.CrateID
--(see MFAHv_OBJ_Location and Location_Displayed for full clause)

WHERE	OL.TransCodeID < 4
AND		OL.Inactive = 0
AND		oc.Inactive = 0			
AND		oc.ComponentType = 0	-- Part of an object

--If any have COUNT (*) > 1 THEN flag somehow to not include the record in the OCM