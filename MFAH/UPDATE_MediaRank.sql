
SELECT ObjectID, ObjectNumber,
IsVirtual, o.ObjectTypeID, ot.ObjectType, o.ObjectLevelID, ol.ObjectLevel
FROM Objects AS o
INNER JOIN ObjectTypes AS ot ON o.ObjectTypeID = ot.ObjectTypeID
INNER JOIN ObjectLevels AS ol ON o.ObjectLevelID = ol.ObjectLevelID
WHERE ObjectNumber LIKE '2020.137.%'
AND o.ObjectTypeID = 4
ORDER BY o.SortNumber


SELECT ObjectID FROM Objects WHERE ObjectNumber = '2020.137.3.1-.213'


--UPDATE MediaXrefs SET [Rank] = mx.DisplayOrder  

--SELECT dt.*
FROM MediaXrefs AS mx 
INNER JOIN
(
	SELECT
	om.RenditionNumber,
	om.SortNumber,
	om.MediaXrefID,
	om.FileName,
	om.PublicCaption,
	om.ObjectID,
	om.ObjectNumber,
	om.PrimaryDisplay,
	om.Rank,
	om.DepartmentID,
	om.DisplayOrder,
	CASE WHEN om.DepartmentID = 240 THEN 0 ELSE 1 END AS MajorOrder,

	RANK() 
		OVER(
			PARTITION BY om.ObjectID 
			ORDER BY	om.PrimaryDisplay DESC, 
						CASE WHEN om.DepartmentID = 240 THEN 0 ELSE 1 END, 
						--ISNULL(om.FileName,'ZZZZZ'),							-- ADDED 9/5/17 b/c slides and transparencies were ordered before actual images.
						--om.Rank, 
						CASE WHEN om.FileName IS NULL THEN 9999 ELSE om.Rank END,
						om.FileName,
						om.MediaXrefID
		) AS NewDisplayOrder
	FROM MFAHv_OBJ_Media AS om
	WHERE om.ObjectID = 146786
)	AS dt ON mx.MediaXrefID = dt.MediaXrefID

WHERE dt.ObjectID = 146786





ORDER BY dt.[Rank]


dt.ObjectID,
dt.PrimaryDisplay DESC, 
CASE WHEN dt.DepartmentID = 240 THEN 0 ELSE 1 END, 
ISNULL(dt.FileName,'ZZZZZ'),							-- ADDED 9/5/17 b/c slides and transparencies were ordered before actual images.
dt.Rank, 
dt.MediaXrefID


