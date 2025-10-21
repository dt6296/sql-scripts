



/*

SELECT ObjectID, ObjectNumber, ObjectCount, ObjectTypeID, ObjectLevelID

FROM Objects WHERE ObjectNumber LIKE '2014.660.%'
AND ObjectNumber != '2014.660.1-.429'


UPDATE Objects
SET ObjectTypeID = 5, ObjectLevelID = 6
WHERE ObjectNumber LIKE '2014.660.%'
AND ObjectNumber != '2014.660.1-.429'

SELECT * FROM ObjectTypes

SELECT * FROM ObjectLevels
*/


SELECT * FROM ObjComponents WHERE ObjectID IN
(
SELECT ObjectID FROM Objects 
WHERE ObjectNumber LIKE '2014.660.%'
AND ObjectNumber != '2014.660.1-.429'
)

/*

UPDATE ObjComponents
SET ComponentName = 'Photograph'
WHERE ObjectID IN
(
	SELECT ObjectID FROM Objects 
	WHERE ObjectNumber LIKE '2014.660.%'
	AND ObjectNumber != '2014.660.1-.429'
)
*/




SELECT * FROM Relationships WHERE LoginID = 'dthompson'


SELECT * FROM AssocParents



SELECT * FROM ConXrefs WHERE TableID = 108 AND ID = 106181

SELECT * FROM Roles WHERE RoleID = 394



