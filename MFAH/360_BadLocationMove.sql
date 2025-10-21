

SELECT l.* FROM Locations AS l
WHERE l.Site LIKE '360%'


--12991 LocationID is the good one
--9604 is the bad one.


SELECT ol.* FROM MFAHv_OBJ_Location AS ol
WHERE ol.CurLocationID = 9604



SELECT ol.* FROM MFAHv_OBJ_Location AS ol
WHERE ol.CurLocationID = 12991
