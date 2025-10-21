--		FlexField_Insert_OBJ_RnR




SELECT * FROM UserFieldGroups WHERE ContextID = 36
UserFieldGroupID	GroupName					ContextID	DisplayAlways	IsWorkflow	LoginID		EnteredDate				GSRowVersion
38					3rd_Party_Photo_License		36			0				1			dthompson	2017-08-22 09:10:48.663	0x000000001DF16E98
39					MFAH_Photo_Repro_License	36			0				1			dthompson	2017-08-22 09:14:38.300	0x000000001DF17438


SELECT * FROM UserFieldGroupXrefs WHERE UserFieldGroupID IN (38,39)
UserFieldGroupXrefID	UserFieldID	UserFieldGroupID	DisplayOrder	DefaultValueID	LoginID		EnteredDate				GSRowVersion
186						256			38					1				966				dthompson	2017-08-22 09:12:10.503	0x000000001DF16A79
187						257			38					2				968				dthompson	2017-08-22 09:12:50.083	0x000000001DF16A7F

188						258			39					2				970				dthompson	2017-08-22 09:15:09.647	0x000000001DF175AF
189						259			39					4				972				dthompson	2017-08-22 09:15:33.127	0x000000001DF175B2
190						260			39					3				974				dthompson	2017-08-22 09:16:08.210	0x000000001DF17440
191						261			39					1				976				dthompson	2017-08-22 09:16:35.170	0x000000001DF175B6


SELECT * FROM UserFields WHERE ContextID = 36
UserFieldID	UserFieldName					ContextID	UserFieldType	LoginID		EnteredDate				UserFieldDataTypeID	GSRowVersion
256			Google							36			2				dthompson	2017-08-22 09:12:10.490	-1					0x000000001DF16A78	--38
257			Google_Extend_to_All_Objects	36			2				dthompson	2017-08-22 09:12:50.070	-1					0x000000001DF16A7E	--38

258			Notify_of_MFAH_Publication		36			2				dthompson	2017-08-22 09:15:09.633	-1					0x000000001DF175AE	--39
259			Extend_to_All_Objects			36			2				dthompson	2017-08-22 09:15:33.110	-1					0x000000001DF175B1	--39
260			Requests_Photography			36			2				dthompson	2017-08-22 09:16:08.193	-1					0x000000001DF1743F	--39
261			License_Acquired				36			2				dthompson	2017-08-22 09:16:35.147	-1					0x000000001DF175B5	--39



SELECT * FROM Packages WHERE Name LIKE '%DAVE%'
SELECT * FROM PackageList WHERE PackageID = 31258 -- TEST.DAVE


DECLARE
@PackageID			INT

SET @PackageID	=	31258






SELECT * FROM UserFieldXrefs WHERE UserFieldID IN (SELECT UserFieldID FROM UserFieldGroupXrefs WHERE ContextID = 36 AND UserFieldGroupID = 39) -- MFAH_Photo_Repro_License



SELECT
* FROM ObjRights WHERE ObjectID = 110421


--	These OBJ Rights records one or both of the User Field Groups	=	456 (some have one or the other, some have both)
	SELECT DISTINCT
	ort.ObjRightsID
	FROM ObjRights AS ort
	INNER JOIN UserFieldXrefs AS ufx ON ort.ObjRightsID = ufx.ID AND ContextID = 36
	--WHERE ufx.UserFieldGroupID = 38	--	3rd_Party_Photo_License
	--AND ort.ObjectID = 110421


--	These OBJ Rights records has the 3rd_Party_Photo_License User Field Groups	= 255
	SELECT DISTINCT
	ort.ObjRightsID
	FROM ObjRights AS ort
	INNER JOIN UserFieldXrefs AS ufx ON ort.ObjRightsID = ufx.ID AND ContextID = 36
	WHERE ufx.UserFieldGroupID = 38	--	3rd_Party_Photo_License
	--AND ort.ObjectID = 110421


--	These OBJ Rights records has the MFAH_Photo_Repro_License User Field Groups	= 448
	SELECT DISTINCT
	ort.ObjRightsID
	FROM ObjRights AS ort
	INNER JOIN UserFieldXrefs AS ufx ON ort.ObjRightsID = ufx.ID AND ContextID = 36
	WHERE ufx.UserFieldGroupID = 39	--	MFAH_Photo_Repro_License
	--AND ort.ObjectID = 110421




--INSERT INTO UserFieldXrefs (UserFieldID, ID, ContextID, ValueDate, FieldValue, ValueRemarks, LoginID, EnteredDate, UserFieldGroupID)
SELECT
261,				--License_Acquired
ort.ObjRightsID,
36,					--ObjectRights
NULL,
0,
NULL,
'dthompson',
GETDATE(),
39

FROM ObjRights AS ort
WHERE ort.ObjRightsID NOT IN
(
--	These OBJ Rights records has the MFAH_Photo_Repro_License User Field Groups	= 448
	SELECT DISTINCT
	ort.ObjRightsID
	FROM ObjRights AS ort
	INNER JOIN UserFieldXrefs AS ufx ON ort.ObjRightsID = ufx.ID AND ContextID = 36
	WHERE ufx.UserFieldGroupID = 39	--	MFAH_Photo_Repro_License
)
AND ort.ObjectID = 129555

--INSERT INTO UserFieldXrefs (UserFieldID, ID, ContextID, ValueDate, FieldValue, ValueRemarks, LoginID, EnteredDate, UserFieldGroupID)
SELECT
258,				--Notify_of_MFAH_Publication
ort.ObjRightsID,
36,					--ObjectRights
NULL,
0,
NULL,
'dthompson',
GETDATE(),
39

FROM ObjRights AS ort
WHERE ort.ObjRightsID NOT IN
(
--	These OBJ Rights records has the MFAH_Photo_Repro_License User Field Groups	= 448
	SELECT DISTINCT
	ort.ObjRightsID
	FROM ObjRights AS ort
	INNER JOIN UserFieldXrefs AS ufx ON ort.ObjRightsID = ufx.ID AND ContextID = 36
	WHERE ufx.UserFieldGroupID = 39	--	MFAH_Photo_Repro_License
)
AND ort.ObjectID = 129555

--INSERT INTO UserFieldXrefs (UserFieldID, ID, ContextID, ValueDate, FieldValue, ValueRemarks, LoginID, EnteredDate, UserFieldGroupID)
SELECT
260,				--Requests_Photography
ort.ObjRightsID,
36,					--ObjectRights
NULL,
0,
NULL,
'dthompson',
GETDATE(),
39

FROM ObjRights AS ort
WHERE ort.ObjRightsID NOT IN
(
--	These OBJ Rights records has the MFAH_Photo_Repro_License User Field Groups	= 448
	SELECT DISTINCT
	ort.ObjRightsID
	FROM ObjRights AS ort
	INNER JOIN UserFieldXrefs AS ufx ON ort.ObjRightsID = ufx.ID AND ContextID = 36
	WHERE ufx.UserFieldGroupID = 39	--	MFAH_Photo_Repro_License
)
AND ort.ObjectID = 129555

--INSERT INTO UserFieldXrefs (UserFieldID, ID, ContextID, ValueDate, FieldValue, ValueRemarks, LoginID, EnteredDate, UserFieldGroupID)
SELECT
259,				--Extend_to_All_Objects
ort.ObjRightsID,
36,					--ObjectRights
NULL,
0,
NULL,
'dthompson',
GETDATE(),
39

FROM ObjRights AS ort
WHERE ort.ObjRightsID NOT IN
(
--	These OBJ Rights records has the MFAH_Photo_Repro_License User Field Groups	= 448
	SELECT DISTINCT
	ort.ObjRightsID
	FROM ObjRights AS ort
	INNER JOIN UserFieldXrefs AS ufx ON ort.ObjRightsID = ufx.ID AND ContextID = 36
	WHERE ufx.UserFieldGroupID = 39	--	MFAH_Photo_Repro_License
)
AND ort.ObjectID = 129555









SELECT * FROM UserFieldXrefs WHERE UserFieldID IN 
(SELECT UserFieldID FROM UserFieldGroupXrefs WHERE ContextID = 36 AND UserFieldGroupID = 39) -- MFAH_Photo_Repro_License
ORDER BY EnteredDate DESC


--DELETE FROM UserFieldXrefs WHERE UserFieldXrefID IN
(
838702,
838701,
838700,
838699
)


SELECT * FROM ObjRights WHERE ObjRightsID = 46550

--DELETE FROM UserFieldXrefs WHERE ID = 46550 AND ContextID = 36 AND UserFieldGroupID = 39