


















SELECT
om.ObjectID,
om.ObjectNumber,
o.DepartmentID,
o.Department,
om.PublicCaption,
om.Description,
om.RenditionNumber,
om.MediaTypeID,
om.MediaType,
om.FileName

FROM MFAHv_OBJ_Media AS om
INNER JOIN MFAHv_OBJ AS o ON om.ObjectID = o.ObjectID

WHERE o.ObjectStatusID = 2
AND o.DepartmentID = 2				-- Dec Arts

AND
(om.MediaTypeID = 32	-- Black & White Print
OR om.RenditionNumber LIKE '%bwp%')					-- 674 records





SELECT
om.ObjectID,
om.ObjectNumber,
o.DepartmentID,
o.Department,
om.PublicCaption,
om.Description,
om.RenditionNumber,
om.MediaTypeID,
om.MediaType,
om.FileName

FROM MFAHv_OBJ_Media AS om
INNER JOIN MFAHv_OBJ AS o ON om.ObjectID = o.ObjectID

WHERE o.ObjectStatusID = 2
AND o.DepartmentID = 2

AND 
(om.MediaTypeID = 0	--Image
OR om.FileName LIKE '%.jpg'
OR om.FileName LIKE '%.jpeg'
OR om.FileName LIKE '%.bmp'
OR om.FileName LIKE '%.tif'
OR om.FileName LIKE '%.tiff'
)									-- 14801 records





SELECT DISTINCT
o.ObjectID, o.ObjectNumber

FROM MFAHv_OBJ AS o
INNER JOIN MFAHv_OBJ_Media AS om ON o.ObjectID = om.ObjectID

WHERE o.ObjectStatusID = 2
AND o.DepartmentID = 2

AND
(om.MediaTypeID = 32	-- Black & White Print
OR om.RenditionNumber LIKE '%bwp%')					-- 454 records

AND o.ObjectID NOT IN

(
	SELECT DISTINCT
	om.ObjectID

	FROM MFAHv_OBJ_Media AS om
	INNER JOIN MFAHv_OBJ AS o ON om.ObjectID = o.ObjectID

	WHERE o.ObjectStatusID = 2
	AND o.DepartmentID = 2

	AND 
	(om.MediaTypeID = 0	--Image
	OR om.FileName LIKE '%.jpg'
	OR om.FileName LIKE '%.jpeg'
	OR om.FileName LIKE '%.bmp'
	OR om.FileName LIKE '%.tif'
	OR om.FileName LIKE '%.tiff')
)








SELECT DISTINCT
o.ObjectID, o.ObjectNumber--, om.RenditionNumber, om.MediaTypeID, mt.MediaType

FROM MFAHv_OBJ AS o
INNER JOIN MFAHv_OBJ_Media AS om ON o.ObjectID = om.ObjectID
INNER JOIN MediaTypes AS mt ON om.MediaTypeID = mt.MediaTypeID

WHERE o.ObjectStatusID = 2
AND o.DepartmentID = 2
AND om.MediaTypeID NOT IN (4,5)
AND	
(
	om.MediaTypeID IN (28,29,30,31,32)					--1661 records
	OR
	(
			om.RenditionNumber LIKE '%TM'
		OR	om.RenditionNumber LIKE '%T'
		OR	om.RenditionNumber LIKE '%bwp'
		OR	om.RenditionNumber LIKE '%N'
		OR	om.RenditionNumber LIKE '%SM'
		OR	om.RenditionNumber LIKE '%S'
	)
)

AND o.ObjectID NOT IN
(
	SELECT DISTINCT
	om.ObjectID

	FROM MFAHv_OBJ_Media AS om
	INNER JOIN MFAHv_OBJ AS o ON om.ObjectID = o.ObjectID

	WHERE o.ObjectStatusID = 2
	AND o.DepartmentID = 2

	AND 
	(
		om.MediaTypeID = 0	--Image
		OR om.FileName LIKE '%.jpg'
		OR om.FileName LIKE '%.jpeg'
		OR om.FileName LIKE '%.bmp'
		OR om.FileName LIKE '%.tif'
		OR om.FileName LIKE '%.tiff'
	)
)


