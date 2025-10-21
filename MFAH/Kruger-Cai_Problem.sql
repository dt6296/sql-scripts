













SELECT * FROM MFAHvr_OBJ_Value_Acquisitions
WHERE ObjectID IN (30630,107442)




SELECT
ObjectID,
ObjectNumber,
ObjectStatusID,		-- 2
ObjectStatus,		-- Accessioned Object
ObjectLevelID,		-- 6
ObjectLevel,		-- Item
ObjectTypeID,		-- 4
ObjectType,			-- Meta Object
ReportStatus
FROM MFAHvr_OBJ_Value_Acquisitions
WHERE ObjectID IN (30630,107442)


SELECT
ObjectID,
RelPosition,		-- 1
ObjectLevelID		-- 13
FROM MFAHv_OBJ_Related
WHERE ObjectID IN (30630,107442)




SELECT ObjectID, RelatedObjectID, AVG(ObjectLevelID) AS AVG_ObjectLevelID, ObjectNumber, ObjectLevelID
FROM MFAHv_OBJ_Related 
WHERE ObjectID IN (30630,107442)
GROUP BY ObjectID,RelatedObjectID, ObjectNumber,ObjectLevelID


SELECT ObjectNumber FROM Objects WHERE ObjectID = 33514

SELECT ObjectNumber FROM Objects WHERE ObjectID = 33514

SELECT * FROM ObjectLevels

SELECT ObjectID, AVG(ObjectLevelID) AS AVG_ObjectLevelID FROM MFAHv_OBJ_Related WHERE ObjectID IN (30630,107442) GROUP BY ObjectID
SELECT ObjectID, ObjectNumber, ObjectLevelID FROM MFAHv_OBJ_Related WHERE ObjectID IN (30630,107442)


SELECT * FROM MFAHv_OBJ_Related WHERE ObjectID IN (30630,107442)



