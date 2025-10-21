








SELECT 
ObjectID,
ObjectNumber,
Dimensions AS CurrentDimLabel,
REPLACE(Dimensions, 'x', N'×') AS ProposedDimLabel
FROM Objects
WHERE Dimensions LIKE '% x %'
ORDER BY SortNumber







--UPDATE Objects
SET Dimensions = REPLACE(Dimensions, ' x ', N' × ') 
WHERE Dimensions LIKE '% x %'