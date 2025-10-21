
--ObjectUpdate_Accessioned_Phyllis

SELECT * FROM AccessionMethods
SELECT * FROM ObjectStatuses


SELECT 
o.ObjectID,
o.ObjectNumber,
o.SortNumber,
o.ObjectStatusID,
os.ObjectStatus,
oa.AccessionMethodID,
am.AccessionMethod,
oa.AccessionISODate,
o.IsVirtual
 
FROM [Objects] AS o
LEFT OUTER JOIN ObjectStatuses AS os ON o.ObjectStatusID = os.ObjectStatusID
LEFT OUTER JOIN ObjAccession AS oa ON o.ObjectID = oa.ObjectID
LEFT OUTER JOIN AccessionMethods AS am ON oa.AccessionMethodID = am.AccessionMethodID
 
WHERE o.SortNumber BETWEEN '  2014   297                    ' AND '  2014   598%'
AND oa.AccessionISODate IS NULL
 
/*
 
--This is what I ran:
UPDATE ObjAccession
SET AccessionMethodID = 2, AccessionISODate = '2014-05-19'
WHERE ObjectID IN
(
	SELECT ObjectID
	FROM Objects
	WHERE SortNumber BETWEEN '  2014   297                    ' AND '  2014   598%'
)
-- (79 row(s) affected)
 
UPDATE [Objects]
SET ObjectStatusID = 2
WHERE SortNumber BETWEEN '  2014   297                    ' AND '  2014   598%'

-- (79 row(s) affected) 
 
 
*/