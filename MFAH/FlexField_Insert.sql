
SELECT * FROM UserFieldGroups
25	PISD Google	1	1	0	dthompson	2016-07-28 14:25:54.943	0x00000000116690E3
23	Provenance	1	1	0	dthompson	2016-06-27 16:41:07.010	0x0000000011286288

SELECT * FROM UserFields

175	Web Chat	1	2	dthompson	2016-07-28 14:26:34.220	-1	0x00000000116690F6
176	Provenance	1	2	dthompson	2016-07-28 14:26:56.477	-1	0x00000000116690F9
177	URL Link	1	2	dthompson	2016-07-28 14:41:53.240	-1	0x00000000116B0A79

166	Uploaded	1	2	dthompson	2016-06-27 16:42:24.213	-1	0x0000000012BB12AA
167	Curator Approved	1	2	dthompson	2016-06-27 16:43:05.300	-1	0x0000000012BB12AE


--INSERT INTO UserFieldXrefs
(UserFieldID,ID,ContextID,FieldValue,LoginID,EnteredDate,UserFieldGroupID)

SELECT
177,			-- UserFieldID
o.ObjectID,		-- ObjectID
1,				-- Context 1 = Objects
0,				-- FieldValue 0 = Unchecked
'dthompson',	-- LoginID
GETDATE(),		-- EnteredDate
25				-- UserFieldGroupID 25 = PISD Google

FROM Objects AS o
WHERE o.ObjectStatusID IN (2,27)	-- Accessioned objects
AND o.ObjectID = 110421



SELECT *
FROM UserFieldXrefs AS ufx
INNER JOIN MFAHt_IMPORT_Provenance AS o ON o.ObjectID = ufx.ID AND ufx.UserFieldGroupID = 23
WHERE UserFieldID = 166


--************ Update Curator Approved ************

UPDATE UserFieldXrefs
SET FieldValue = 1,
ValueDate = '2016-12-01 00:00' -- SELECT *
FROM UserFieldXrefs AS ufx
INNER JOIN MFAHt_IMPORT_Provenance AS o ON o.ObjectID = ufx.ID AND ufx.UserFieldGroupID = 23
WHERE ufx.UserFieldID = 167	-- Curator Approved
AND o.ObjectID NOT IN
(
	SELECT ObjectID
	FROM MFAHt_IMPORT_Provenance
	GROUP BY ObjectID
	HAVING COUNT(*) > 1		-- 3 objects that have more than one record (x2 = 6)
)


--************ Update Uploaded

UPDATE UserFieldXrefs
SET FieldValue = 1,
ValueDate = '2017-01-07 00:00' -- SELECT *
FROM UserFieldXrefs AS ufx
INNER JOIN MFAHt_IMPORT_Provenance AS o ON o.ObjectID = ufx.ID AND ufx.UserFieldGroupID = 23
WHERE ufx.UserFieldID = 166		-- Uploaded
AND o.ObjectID NOT IN
(
	SELECT ObjectID
	FROM MFAHt_IMPORT_Provenance
	GROUP BY ObjectID
	HAVING COUNT(*) > 1		-- 3 objects that have more than one record (x2 = 6)
)



----------------------------------- ???
--UPDATE UserFieldXrefs
SET FieldValue = 1
FROM UserFieldXrefs AS ufx
INNER JOIN MFAHt_IMPORT_Provenance AS o ON o.ObjectID = ufx.ID AND ufx.UserFieldGroupID = 23	--12420 records updated (of 12546)

--UPDATE UserFieldXrefs
SET ValueDate = '2016-11-03 00:00'
FROM UserFieldXrefs AS ufx
INNER JOIN MFAHt_IMPORT_Provenance AS o ON o.ObjectID = ufx.ID AND ufx.UserFieldGroupID = 23 
WHERE UserFieldID = 166


SELECT * FROM MFAHt_IMPORT_Provenance


SELECT d.Department,
ufg.GroupName,
ufx.UserFieldID,
uf.UserFieldName,
ufx.FieldValue,
ufx.ValueDate
FROM UserFieldXrefs AS ufx
INNER JOIN UserFieldGroups AS ufg ON ufx.UserFieldGroupID = ufg.UserFieldGroupID
INNER JOIN UserFields AS uf ON ufx.UserFieldID = uf.UserFieldID
INNER JOIN Objects AS o ON ufx.ID = o.ObjectID
INNER JOIN Departments AS d ON o.DepartmentID = d.DepartmentID
WHERE ufx.UserFieldGroupID = 23
AND o.ObjectStatusID IN (2,27)