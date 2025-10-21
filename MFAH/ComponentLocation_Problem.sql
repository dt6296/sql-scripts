



/*
SELECT ObjectID, ObjectNumber
FROM Objects
WHERE ObjectNumber IN
(
	'BF.1979.27',
	'BF.2009.2',
	'2012.290'
)
*/

SELECT
ObjectID,
AccessionNumber,
ComponentNumber,
ComponentName,
ObjCompType,
oc_InactiveDisplay,
CurLocationID,
CurLocation,
OnView,
DisplayLocation,
DisplayRoom

FROM MFAHv_OBJ_Location
WHERE ObjectID IN
(
	106101,
	20429,
	99525
)



SELECT
o.ObjectID,
o.ObjectNumber,
oc.ComponentID,
oc.ComponentNumber,
oc.ComponentName,
CASE WHEN o.ObjectNumber = oc.ComponentNumber THEN 0 ELSE 1 END AS Mismatch

FROM Objects AS o
INNER JOIN ObjComponents AS oc ON o.ObjectID = oc.ObjectID

WHERE o.ObjectStatusID IN (2,27)
AND
CASE WHEN o.ObjectNumber = oc.ComponentNumber THEN 0 ELSE 1 END = 1

ORDER BY o.SortNumber


--2359 RECORDS, OBJECTS AND COMPONENTS
SELECT 
o.ObjectID,
o.ObjectNumber,
o.SortNumber,
o.ObjectCount,
oc.ComponentNumber,
oc.CompCount,
CASE WHEN oc.ComponentType = 0 THEN 'Part' ELSE 'Accessory' END AS ComponentType,
CASE WHEN o.ObjectNumber <> oc.ComponentNumber THEN 1 ELSE 0 END AS MisMatch,
oc.ComponentName
FROM Objects AS o
LEFT OUTER JOIN ObjComponents AS oc ON o.ObjectID = oc.ObjectID
WHERE o.ObjectID IN
(
	SELECT o.ObjectID
	FROM Objects AS o
	LEFT OUTER JOIN ObjComponents AS oc ON o.ObjectID = oc.ObjectID
	WHERE CASE WHEN o.ObjectNumber <> oc.ComponentNumber THEN 1 ELSE 0 END > 0
)
AND o.ObjectStatusID IN (2,27)
AND oc.CompCount + CASE WHEN o.ObjectNumber <> oc.ComponentNumber THEN 1 ELSE 0 END > 1
ORDER BY o.SortNumber


-- 503 RECORDS, JUST OBJECTS, all.
SELECT
o.ObjectID, o.ObjectNumber, o.SortNumber,
SUM(oc.CompCount) AS SumCompCount,
SUM(CASE WHEN o.ObjectNumber <> oc.ComponentNumber THEN 1 ELSE 0 END) AS Mismatch,
SUM(oc.CompCount) - SUM(CASE WHEN o.ObjectNumber <> oc.ComponentNumber THEN 1 ELSE 0 END) DIFF
FROM Objects AS o
LEFT OUTER JOIN ObjComponents AS oc ON o.ObjectID = oc.ObjectID 
WHERE o.ObjectStatusID IN (2,27)
GROUP BY o.ObjectID, o.ObjectNumber, o.SortNumber
HAVING SUM(oc.CompCount) - SUM(CASE WHEN o.ObjectNumber <> oc.ComponentNumber THEN 1 ELSE 0 END) = 0
ORDER BY o.SortNumber


