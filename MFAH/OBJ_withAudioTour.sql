


SELECT * FROM TextTypes WHERE TableID = 108 AND TextType LIKE '%audio%'



SELECT 
ObjectID, ObjectNumber, SortNumber, 'TextEntry' AS Source FROM Objects WHERE ObjectID IN
(
	SELECT ID FROM TextEntries
	WHERE TableID = 108 AND TextTypeID IN (60,54)
)

UNION

SELECT ObjectID, ObjectNumber, SortNumber, 'Label Text' AS Source FROM Objects WHERE Chat LIKE '%audio%'

UNION

SELECT ObjectID, ObjectNumber, SortNumber, 'Notes' AS Source FROM Objects WHERE Notes LIKE '%audio%'

UNION

SELECT ObjectID, ObjectNumber, SortNumber, 'Curatorial Remarks' AS Source FROM Objects WHERE CuratorialRemarks LIKE '%audio%'

ORDER BY SortNumber




----------------------------



SELECT 
ObjectID FROM Objects WHERE ObjectID IN
(
	SELECT ID FROM TextEntries
	WHERE TableID = 108 AND TextTypeID IN (60,54)
)

UNION

SELECT ObjectID FROM Objects WHERE Chat LIKE '%audio%'

UNION

SELECT ObjectID FROM Objects WHERE Notes LIKE '%audio%'

UNION

SELECT ObjectID FROM Objects WHERE CuratorialRemarks LIKE '%audio%'

ORDER BY SortNumber