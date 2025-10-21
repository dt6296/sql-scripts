





SELECT DISTINCT
ol.ObjectID,
o.ObjectNumber,
o.OnView,
o.SortNumber

FROM ObjCurLocView AS ol
INNER JOIN Objects AS o ON ol.ObjectID = o.ObjectID

WHERE ol.CurUnitPosition = 'on view'
OR ol.CurUnitType = 'on view'

ORDER BY
o.SortNumber,
ol.ObjectID,
o.ObjectNumber,
o.OnView

--------------------------------------------------------------------------------

SELECT 
o.ObjectID,
o.ObjectNumber,
o.OnView

FROM Objects AS o

WHERE o.OnView = 1

ORDER BY o.SortNumber