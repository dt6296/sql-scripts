








'PRODUCTION'



SELECT o.ObjectID, o.ObjectNumber, o.SortNumber, o.Description
FROM Objects AS o
WHERE o.SortNumber LIKE '  2014%660%'


SELECT
*
FROM TextEntries
WHERE ID IN
(
	SELECT o.ObjectID
	FROM Objects AS o
	WHERE o.SortNumber LIKE '  2014%660%'
)
AND TextTypeID = 72
AND TableID = 108


DELETE
FROM TextEntries
WHERE ID IN
(
	SELECT o.ObjectID
	FROM Objects AS o
	WHERE o.SortNumber LIKE '  2014%660%'
)
AND TextTypeID = 72
AND TableID = 108