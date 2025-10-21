







SELECT
o.ObjectID,
o.ObjectNumber,
oc.ComponentID,
oc.ComponentNumber

FROM Objects AS o
INNER JOIN ObjComponents AS oc ON o.ObjectID = oc.ObjectID	--	129243 COMPONENTS

WHERE o.ObjectID > 0
AND o.ObjectID NOT IN -- Objects that have a matching component number (122,438)
(
	SELECT
	o.ObjectID--,o.ObjectNumber,oc.ComponentID,oc.ComponentNumber,CASE WHEN o.ObjectNumber <> oc.ComponentNumber THEN 1 ELSE 0 END AS Mismatch
	FROM Objects AS o
	INNER JOIN ObjComponents AS oc ON o.ObjectID = oc.ObjectID
	WHERE o.ObjectID > 0
	AND CASE WHEN o.ObjectNumber <> oc.ComponentNumber THEN 1 ELSE 0 END = 0
)
AND o.ObjectID NOT IN	-- Objects with multiple components
(
	SELECT ObjectID--, COUNT(ComponentID) 
	FROM ObjComponents 
	GROUP BY ObjectID 
	HAVING COUNT(ComponentID)> 1 
)
ORDER BY o.SortNumber

--------------------		See Below	-----------------------------







SELECT DISTINCT * FROM 
(

	SELECT DISTINCT o.ObjectID, o.ObjectNumber, o.SortNumber
	FROM Objects AS o
	INNER JOIN							-- Components? that have a mismatched Object? number that don't have another one that matches (5,641)
	(
		SELECT
		o.ObjectID,
		o.ObjectNumber,
		oc.ComponentID,
		oc.ComponentNumber,
		oc.SortNumber

		FROM Objects AS o
		INNER JOIN ObjComponents AS oc ON o.ObjectID = oc.ObjectID

		WHERE o.ObjectID > 0
		AND o.ObjectID NOT IN			-- Objects that have a matching component number (122,438)
		(
			SELECT DISTINCT
			o.ObjectID
			FROM Objects AS o
			INNER JOIN ObjComponents AS oc ON o.ObjectID = oc.ObjectID
			WHERE o.ObjectID > 0
			AND o.ObjectNumber = oc.ComponentNumber
		)
	)AS so ON o.ObjectID = so.ObjectID	-- 5641

	WHERE o.ObjectStatusID IN (2,27)	-- Accessioned objects only		1694

) as oo

ORDER BY oo.SortNumber






--		This is wrong because it includes any record that doesn't have a matching componenet name, even if one exists, but the other doesn't match.


		SELECT DISTINCT
		o.ObjectID, o.ObjectNumber, o.SortNumber

		FROM Objects AS o
		INNER JOIN ObjComponents AS oc ON o.ObjectID = oc.ObjectID

		WHERE o.ObjectID > 0
		AND o.ObjectNumber <> oc.ComponentNumber
		AND o.ObjectStatusID IN (2,27)

		ORDER BY o.SortNumber






		----------------------------------------------------------------------------------------------



SELECT DISTINCT
o.ObjectID,
o.ObjectNumber,
oc.ComponentNumber

FROM Objects AS o	--	126430 OBJECTS
INNER JOIN ObjComponents AS oc ON o.ObjectID = oc.ObjectID	-- 129213 COMPONENTS











