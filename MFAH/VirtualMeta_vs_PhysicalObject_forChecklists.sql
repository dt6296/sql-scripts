
-- Trying to distinguish between virtual/meta objects and physical objects for Exhibition checklists

/*


SELECT ObjectID, ObjectNumber FROM Objects 
WHERE ObjectNumber LIKE 'TEST.DAVE.0%' OR ObjectNumber LIKE 'TEST.DAVE.META.%'


SELECT * FROM MFAHv_OBJ_Related WHERE (ObjectID IN
(110421,129555,130056,133570,133722)
OR o.ObjectNumber LIKE 'TEST.DAVE.%')
AND AssocField = 'ID1'

UNION

SELECT * FROM MFAHv_OBJ_Related WHERE ObjectID IN
(110421,129555,130056,133570,133722)
AND AssocField = 'ID2'

*/


/*

DECLARE @Object AS VARCHAR(25)
SET @Object = 'TEST.DAVE.%'


SELECT
o.ObjectID,o.ObjectNumber
FROM Objects AS o
WHERE 
(o.ObjectID IN (110421,129555,130056,133570,133722)
OR o.ObjectNumber LIKE @Object)
AND o.ObjectID NOT IN (SELECT ObjectID FROM MFAHv_OBJ_Related WHERE RelationshipTypeID = 0)

UNION

SELECT DISTINCT
o.ObjectID,o.ObjectNumber
FROM Objects AS o
LEFT OUTER JOIN MFAHv_OBJ_Related AS r ON o.ObjectID = r.ObjectID
WHERE 
(o.ObjectID IN (110421,129555,130056,133570,133722)
OR o.ObjectNumber LIKE @Object)
AND CASE WHEN o.ObjectID IN (SELECT ObjectID FROM MFAHv_OBJ_Related) AND r.RelationshipTypeID = 0 THEN 1 ELSE 0 END = 1
AND o.IsVirtual IN (0)

*/




DECLARE @Object AS VARCHAR(25)
DECLARE @VirtualPhysical INT

--SET @Object = 'TEST.DAVE.%'
--SET @Object = '2016.156'
SET @VirtualPhysical = 1

-- Include any exhibition objects that do NOT have parent-child or intellectual child relationships.
SELECT
'top' AS QRY,
o.ObjectID,o.ObjectNumber,o.SortNumber,o.IsVirtual
FROM Objects AS o
WHERE o.ObjectID NOT IN (SELECT ObjectID FROM MFAHv_OBJ_Related WHERE RelationshipTypeID IN (0,2))
--AND o.ObjectNumber LIKE @Object
AND (o.ObjectNumber IN ('2011.646','2016.34') OR o.ObjectNumber LIKE '2009.29.%')


UNION

-- Include any exhibition objects that have see-also relationships.
SELECT
'middle' AS QRY,
o.ObjectID,o.ObjectNumber,o.SortNumber,o.IsVirtual
FROM Objects AS o
WHERE o.ObjectID IN (SELECT ObjectID FROM MFAHv_OBJ_Related WHERE RelationshipTypeID = 1)
--AND o.ObjectNumber LIKE @Object
AND (o.ObjectNumber IN ('2011.646','2016.34') OR o.ObjectNumber LIKE '2009.29.%')

UNION

-- Include any exhibition objects that DO have parent-child or intellecutal child relationships
-- that are ALSO Physical (0), or Virtual (1), or Either (2), based on @VirtualPhysical parameter.
SELECT DISTINCT
'bottom' AS QRY,
o.ObjectID,o.ObjectNumber,o.SortNumber,o.IsVirtual
FROM Objects AS o
LEFT OUTER JOIN MFAHv_OBJ_Related AS r ON o.ObjectID = r.ObjectID
WHERE CASE WHEN o.ObjectID IN (SELECT ObjectID FROM MFAHv_OBJ_Related) AND r.RelationshipTypeID IN (0,2) THEN 1 ELSE 0 END = 1
AND CASE WHEN @VirtualPhysical = 2 THEN 2 ELSE CASE WHEN o.IsVirtual = 1 THEN 1 ELSE 0 END END = @VirtualPhysical
--AND o.ObjectNumber LIKE @Object
AND (o.ObjectNumber IN ('2011.646','2016.34') OR o.ObjectNumber LIKE '2009.29.%')

ORDER BY o.SortNumber

--SELECT DISTINCT RelationshipTypeID, RelationshipType FROM MFAHv_OBJ_Related
/*

RelationshipTypeID	RelationshipType
2	Inseparable Objects
1	See Also
0	Parent-Child

*/


--SELECT * FROM MFAHv_OBJ_Related WHERE ObjectID IN (125869,135572,131642)




















