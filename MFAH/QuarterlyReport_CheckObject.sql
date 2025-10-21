







SELECT * FROM MFAHv_OBJ_Related
WHERE ObjectID = 131364 OR RelatedObjectID = 131364	


SELECT ObjectID, AVG(ObjectLevelID) AS AVG_ObjectLevelID FROM MFAHv_OBJ_Related 
WHERE ObjectID = 131364
GROUP BY ObjectID


SELECT ReportStatus FROM MFAHvr_OBJ_Value_Acquisitions
WHERE ObjectID = 131364

