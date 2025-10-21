

--	MFAHv_OBJ

SELECT
ObjectID, ObjectNumber, --RenditionNumber,
COUNT(*) AS Records
FROM MFAHv_OBJ
GROUP BY ObjectID, ObjectNumber, SortNumber--, RenditionNumber
HAVING COUNT(*) > 1
ORDER BY SortNumber



--	MFAHv_OCM_Object

SELECT ObjectID, COUNT(*) AS Records
FROM MFAHv_OCM_Object
GROUP BY ObjectID
HAVING COUNT(*) > 1


--	MFAHv_OBJ_Image

SELECT
ObjectID, ObjectNumber, MediaXrefID, --RenditionNumber,
COUNT(*) AS Records
FROM MFAHv_OBJ_Image
GROUP BY MediaXrefID, ObjectID, ObjectNumber--, RenditionNumber
HAVING COUNT(*) > 1
ORDER BY ObjectNumber

--	MFAHv_OCM_ObjectImage

SELECT ObjectID, ObjectNumber, MediaXrefID, ImageID, COUNT(*) AS Records
FROM MFAHv_OCM_ObjectImage
GROUP BY ObjectID, ObjectNumber, MediaXrefID, ImageID
HAVING COUNT(*) > 1
ORDER BY ObjectNumber


--	MFAHv_OBJ_Image_Primary

SELECT
MediaXrefID, ObjectID, ObjectNumber, --RenditionNumber,
COUNT(*) AS Records
FROM MFAHv_OBJ_Image_Primary
GROUP BY MediaXrefID, ObjectID, ObjectNumber--, RenditionNumber
HAVING COUNT(*) > 1
ORDER BY ObjectNumber







SELECT * FROM MFAHv_OBJ_Image_Primary
WHERE ObjectID = 45182

SELECT * FROM MediaXrefs WHERE MediaXrefID = 35326

SELECT * FROM MediaMaster WHERE MediaMasterID = 34231

SELECT * FROM MediaRenditions WHERE MediaMasterID = 34231

SELECT * FROM MediaFiles WHERE RenditionID IN (45016,50990,52576)









SELECT MediaXrefID, COUNT(*) AS Records
FROM MFAHv_OCM_ObjectImage
GROUP BY MediaXrefID
HAVING COUNT(*) > 1
 






SELECT
mr.RenditionID, 
COUNT(*)
FROM MediaRenditions AS mr
LEFT OUTER JOIN MediaFiles AS mf ON mr.RenditionID = mf.RenditionID
GROUP BY mr.RenditionID
HAVING COUNT(*) > 1

RenditionID	(No column name)
196557	2
130912	2


