

--________________________________________________________________________Objects



SELECT * FROM MFAHv_OCM_Object WHERE ObjectID = 78914


SELECT COUNT(*), AccessionNumber, ObjectID
FROM MFAHv_OCM_Object
GROUP BY AccessionNumber, ObjectID
HAVING COUNT(*)>1




SELECT * FROM MFAHv_OBJ WHERE ObjectID = 78914




SELECT COUNT(*) FROM MFAHv_OCM_Object



--________________________________________________________________________ObjectMaker






SELECT COUNT(*), ConstituentID, NameID, ObjectID, RoleID
FROM MFAHv_OCM_ObjectMaker
GROUP BY ConstituentID, NameID, ObjectID, RoleID
HAVING COUNT(*)>1


SELECT * FROM MFAHv_OCM_Object --WHERE ObjectID = 109050
WHERE ObjectID IN
(
	--109050,
	--78619,
	--114517,
	--120723,
	--78618,
	82837,
	126174,
	--115106,
	--78617,
	126950--,
	--78613
)
SELECT cx_ID, cxd_ConstituentID, cxd_NameID, * FROM MFAHv_OBJ_Constituent
WHERE cx_ID IN
(
	--109050,
	--78619,
	--114517,
	--120723,
	--78618,
	82837,
	126174,
	--115106,
	--78617,
	126950--,
	--78613
)
AND cx_RoleTypeID = 1



--________________________________________________________________________ObjectCollection



SELECT COUNT(*), ObjectID, CollectionID, DisplayName
FROM MFAHv_OCM_ObjectCollection
GROUP BY ObjectID, CollectionID, DisplayName
HAVING COUNT(*)>1


(0 row(s) affected)


--________________________________________________________________________ObjectGeography



SELECT COUNT(*), ObjectID, GeoCode
FROM MFAHv_OCM_ObjectGeography
GROUP BY ObjectID, GeoCode
HAVING COUNT(*)>1

(192 row(s) affected)


SELECT * FROM MFAHv_OCM_Object WHERE ObjectID = 25963


