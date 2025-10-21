
SELECT COUNT(*) FROM Objects WHERE PublicAccess = 1 AND ObjectStatusID IN (2,27)

SELECT * FROM Departments WHERE MainTableID = 108



SELECT
o.ObjectNumber
FROM Objects AS o
INNER JOIN MFAHv_OBJ_Location AS ol ON o.ObjectID = ol.ObjectID
WHERE o.OnView = 1
AND ol.CurLocationString NOT LIKE ('%on view%')




SELECT
o.ObjectNumber
FROM Objects AS o
INNER JOIN MFAHv_OBJ_Location AS ol ON o.ObjectID = ol.ObjectID
WHERE o.OnView = 0
AND ol.CurLocationString LIKE ('%on view%') -- 6330




SELECT
o.ObjectNumber
FROM Objects AS o
INNER JOIN MFAHv_OBJ_Location AS ol ON o.ObjectID = ol.ObjectID
WHERE o.OnView = 1
AND ol.CurLocationString LIKE ('%on view%') -- 1401





SELECT
o.ObjectNumber
FROM Objects AS o
INNER JOIN MFAHv_OBJ_Location AS ol ON o.ObjectID = ol.ObjectID
WHERE o.OnView = 0
AND ol.CurLocationString NOT LIKE ('%on view%')





SELECT
o.ObjectNumber
FROM Objects AS o
WHERE o.OnView = 1
AND o.ObjectStatusID IN (2,27)





SELECT
o.ObjectNumber, ol.CurLocationString
FROM Objects AS o
INNER JOIN MFAHv_OBJ_Location AS ol ON o.ObjectID = ol.ObjectID
WHERE ol.CurLocationString NOT LIKE ('%on view%')
AND o.ObjectNumber LIKE 'TEST.DAVE.04'




SELECT DISTINCT
o.ObjectID, ol.CurLocationString
FROM Objects AS o
INNER JOIN MFAHv_OBJ_Location AS ol ON o.ObjectID = ol.ObjectID
WHERE ol.CurLocationString LIKE ('%on view%')	--7558




--UPDATE Objects SET OnView = 0
SELECT DISTINCT
ol.ObjectID
FROM MFAHv_OBJ_Location AS ol
INNER JOIN
(
	SELECT LocationID FROM Locations
	WHERE LocationString LIKE '%on view%' --655
) AS l ON ol.CurLocationID = l.LocationID


SELECT
*
FROM ObjLocations


--UPDATE Objects SET OnView = 0


--Use this to check record counts. ----------------------------------------

--UPDATE Objects SET OnView = 1
SELECT o.ObjectNumber
FROM Objects AS o
WHERE ObjectID IN
(
	SELECT DISTINCT ObjectID
	FROM ObjComponents		AS oc
	INNER JOIN ObjLocations	AS ol	ON	oc.ComponentID = ol.ComponentID
									AND	oc.CurrentObjLocID = ol.ObjLocationID
	INNER JOIN Locations	AS l	ON	ol.LocationID = l.LocationID
	WHERE l.LocationString LIKE '%on view%'	-- 7558		7497	7306
)
AND o.ObjectStatusID IN (2,27)				-- 6130		6069	6069
AND o.PublicAccess = 1						-- 4471		4408	4408

