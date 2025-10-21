
SELECT * FROM DDContexts WHERE ContextID = 148
ContextID	ModuleID	TableID	Context	ContextType	Description	LoginID	EnteredDate	GSRowVersion	HierarchyId	XrefModuleID
148	9	917	MEDIA_MASTER	UserFields	Media Master Flex Fields	GS	2016-06-23 16:00:50.527	0x0000000046CE35F1	309343	NULL

SELECT * FROM UserFieldGroups WHERE ContextID = 148
UserFieldGroupID	GroupName	ContextID	DisplayAlways	IsWorkflow	LoginID	EnteredDate	GSRowVersion	DisplayOrder
44	SubmittedTo3rdParty	148	0	0	mlawson	2018-11-11 13:36:46.550	0x000000003FB28C4D	1


SELECT * FROM UserFieldGroupXrefs WHERE UserFieldGroupID IN (44)
UserFieldGroupXrefID	UserFieldID	UserFieldGroupID	DisplayOrder	DefaultValueID	LoginID	EnteredDate	GSRowVersion
203	292	44	1	1062	mlawson	2018-11-11 13:37:08.083	0x000000003FB43B58
204	293	44	2	1064	mlawson	2018-11-11 13:37:22.547	0x000000003FB3391D
205	294	44	3	1066	mlawson	2018-11-11 13:37:37.540	0x000000003FB43B77
206	295	44	4	1068	mlawson	2018-11-11 13:37:52.507	0x000000003FB43B95


SELECT * FROM UserFields WHERE ContextID = 148
UserFieldID	UserFieldName	ContextID	UserFieldType	LoginID	EnteredDate	UserFieldDataTypeID	GSRowVersion	DisplayOrder
292	Artstor	148	2	mlawson	2018-11-11 13:37:07.880	-1	0x000000003FB43B3D	2
293	Bridgeman Images	148	2	mlawson	2018-11-11 13:37:22.310	-1	0x000000003FB33902	2
294	Google Art Project	148	2	mlawson	2018-11-11 13:37:37.340	-1	0x000000003FB43B5C	2
295	1000 Museums	148	2	mlawson	2018-11-11 13:37:52.287	-1	0x000000003FB43B7A	2

SELECT COUNT(*)	 FROM MediaMaster AS mm																						--266,447 Media Records Total

SELECT COUNT(DISTINCT mm.MediaMasterID)
FROM MediaMaster AS mm
INNER JOIN UserFieldXrefs AS ufx ON mm.MediaMasterID = ufx.ID AND ufx.ContextID = 148				-- 27,451 have the flex field group

SELECT COUNT(DISTINCT mm.MediaMasterID)
FROM MediaMaster AS mm
LEFT OUTER JOIN UserFieldXrefs AS ufx ON mm.MediaMasterID = ufx.ID AND ufx.ContextID = 148	
WHERE ufx.ID IS NULL																																--238,996 do not have the flex field group


SELECT
ufx.*

FROM UserFieldXrefs AS ufx
WHERE ufx.ContextID = 148		--109,804 ufx records
													-- /4 = 27,451					Good!

													-- Need to insert 238,996 * 4 = 1,135,984 records



--INSERT INTO UserFieldXrefs (UserFieldID, ID, ContextID, ValueDate, FieldValue, ValueRemarks, LoginID, EnteredDate, UserFieldGroupID)
SELECT
UserFieldID,
MediaMasterID		AS ID,
148							AS ContextID,--MEDIA_MASTER
NULL						AS ValueDate,
0								AS FieldValue,
NULL						AS ValueRemarks,
'dthompson'				AS LoginID,
GETDATE()				AS EnteredDate,
44							AS UserFieldGruopID --SubmittedTo3rdParty

FROM MediaMaster 
CROSS JOIN UserFields

WHERE UserFieldID IN 

(SELECT UserFieldID FROM UserFields WHERE ContextID = 148) -- These are the only FFs in this context right now.
--AND MediaMasterID = 259718  --	DAVE_TEST_01

AND MediaMasterID IN
(
SELECT DISTINCT mm.MediaMasterID
FROM MediaMaster AS mm
LEFT OUTER JOIN UserFieldXrefs AS ufx ON mm.MediaMasterID = ufx.ID AND ufx.ContextID = 148	
WHERE ufx.ID IS NULL
) 
-- (955984 rows affected)

--SELECT * FROM UserFieldXrefs WHERE ID = 259718 AND ContextID = 148
--SELECT TOP 10 * FROM UserFieldXrefs WHERE LoginID = 'dthompson' ORDER BY EnteredDate DESC