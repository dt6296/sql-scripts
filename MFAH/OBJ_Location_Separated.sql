


SELECT
O.ObjectNumber,
ssol.ObjectID,
ssol.CurLocationID,
ssol.AvgLocID,
ssol.OBJSeparated

FROM Objects AS o 

INNER JOIN  -- This is where the real query starts.  ObjectNumber is just for troubleshooting.

(
SELECT
ol.ObjectID,
ol.CurLocationID,
sol.AvgLocID,
CASE WHEN ol.CurLocationID != sol.AvgLocID THEN 1 ELSE 0 END AS OBJSeparated

FROM	MFAHv_OBJ_Location		AS ol
INNER JOIN
(
	SELECT
	ol.ObjectID,
	AVG(ol.CurLocationID) AS AvgLocID
	FROM MFAHv_OBJ_Location		AS ol 
	GROUP BY 
	ol.ObjectID
) AS sol ON ol.ObjectID = sol.ObjectID

GROUP BY 
ol.ObjectID,
ol.CurLocationID,
sol.AvgLocID

HAVING COUNT(*) > 1 AND CASE WHEN ol.CurLocationID != sol.AvgLocID THEN 1 ELSE 0 END = 1

--ORDER BY ol.ObjectID
)
AS ssol ON o.ObjectID = ssol.ObjectID